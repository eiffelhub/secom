note

	description:

		"Root class for the read_port example"

	library: "Serial Communications Library"
	copyright: "Copyright (c) 2005, Brian E. Heilig"
	license: "Eiffel Forum License v2 (see license.txt)"
	date: "$Date: 2006/03/28 20:17:41 $"
	revision: "$Revision: 1.12 $"

class

	READ_PORT

inherit

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

	KL_SHARED_STANDARD_FILES
		export {NONE} all end

	KL_SHARED_ARGUMENTS
		export {NONE} all end

	KL_SHARED_EXCEPTIONS
		export {NONE} all end

create

	make

feature {NONE} -- Initialization

	make
			-- Execute 'read_port'
		local
			to: COM_ABSTRACT_TIMEOUTS
			l_device_name: like device_name
		do
			Arguments.set_program_name ("read_port")
			create error_handler.make_standard
			set_default_parameters
			read_command_line
			l_device_name := device_name

			if l_device_name /= Void then

				create {COM_DEVICE} device.make (l_device_name)
				if not device.is_open then
					report_error (Failed_open_error)
				end

				set_control_settings

				-- Set the device to blocking mode
				to := device.timeouts
				to.set_overall_timer (5000)
				device.set_timeouts (to)

				-- Read from the device and output the results to stdout
				from
				until False
				loop
					device.read_line
					if device.timed_out then
						std.error.put_string ("Timed out")
						Exceptions.die (0)
					end
					std.output.put_string (device.last_string)
				end
			end
		rescue
			if Exceptions.is_developer_exception then
				std.error.put_string (Exceptions.developer_exception_name)
				std.error.put_new_line
			else
				std.error.put_string ("An unknown exception was received")
				std.error.put_new_line
			end
			Exceptions.die (1)
		end

feature -- Access

	device: detachable COM_ABSTRACT_DEVICE
			-- Serial device to read from

	device_name: detachable STRING
			-- Name of the serial device, e.g. /dev/ttyS0

	error_handler: UT_ERROR_HANDLER
			-- Error handler

	baud: INTEGER
			-- Device baud rate

	parity_char: CHARACTER
			-- Character version of parity

	data_bits: INTEGER
			-- Number of data bits per word

	stop_bits: INTEGER
			-- Number of stop bits per word

	set_default_parameters
			-- Set up the default command line parameters
		do
			baud := 57600
			parity_char := 'n'
			data_bits := 8
			stop_bits := 1
		end

	read_command_line
			-- Read command line arguments.
		local
			i, nb: INTEGER
			arg: STRING
			arg_param: STRING
		do
			nb := Arguments.argument_count
			from i := 1 until i > nb loop
				arg := Arguments.argument (i)
				if arg.is_equal ("--help") then
					report_usage_error
				elseif arg.count > 7 and then arg.substring (1, 7).is_equal ("--baud=") then
					arg_param := arg.substring (8, arg.count)
					if not arg_param.is_integer then
						report_usage_error
					else
						baud := arg_param.to_integer
					end
				elseif arg.count > 9 and then arg.substring (1, 9).is_equal ("--parity=") then
					parity_char := arg.item (10)
				elseif arg.count > 7 and then arg.substring (1, 7).is_equal ("--data=") then
					arg_param := arg.substring (8, arg.count)
					if not arg_param.is_integer then
						report_usage_error
					else
						data_bits := arg_param.to_integer
					end
				elseif arg.count > 7 and then arg.substring (1, 7).is_equal ("--stop=") then
					arg_param := arg.substring (8, arg.count)
					if not arg_param.is_integer then
						report_usage_error
					else
						stop_bits := arg_param.to_integer
					end
				elseif arg.count > 9 and then arg.substring (1, 9).is_equal ("--device=") then
					device_name := arg.substring (10, arg.count)
				else
					report_usage_error
				end
				i := i + 1
			end
			if not attached device_name as devname or else devname.count = 0 then
				report_usage_error
			end
		ensure
			device_name_set: attached device_name as el_devname and then el_devname.count > 0
		end

	set_control_settings
			-- Apply the control settings to `device'
		require
			device_exists: attached device as dev and then dev.is_open
		local
			settings: COM_ABSTRACT_SETTINGS
			setting: INTEGER
		do
			check attached device as l_device then
				settings := l_device.control_settings
				settings.set_defaults

				setting := settings.to_baud_rate (baud)
				if not settings.is_valid_baud (setting) then
					report_error (Invalid_baud_error)
				else
					settings.set_baud_rate (setting)
				end

				setting := settings.to_parity (parity_char)
				if not settings.is_valid_parity (setting) then
					report_error (Invalid_parity_error)
				else
					settings.set_parity (setting)
					if parity_char /= 'n' and parity_char /= 'N' then
						settings.set_parity_check (True)
					end
				end

				setting := settings.to_data_bits (data_bits)
				if not settings.is_valid_data_bits (setting) then
					report_error (Invalid_data_bits_error)
				else
					settings.set_data_bits (setting)
				end

				setting := settings.to_stop_bits (stop_bits)
				if not settings.is_valid_stop_bits (setting) then
					report_error (Invalid_stop_bits_error)
				else
					settings.set_stop_bits (setting)
				end

				l_device.set_control_settings (settings)
			end
		end

feature {NONE} -- Error handling

	report_usage_error
			-- Report usage error and then terminate
			-- with exit status 1.
		do
			error_handler.report_error (Usage_message)
			Exceptions.die (1)
		end

	report_error (an_error: STRING)
			-- Report an error and terminate with
			-- exit status 1.
		do
			std.error.put_string (an_error)
			std.error.put_new_line
			Exceptions.die(1)
		end

	Failed_open_error: STRING
			-- An error message indicating `device'
			-- failed to open
		require
			device_name_exists: device_name /= Void
		once
			Result := "Failed to open "
			Result.append_string (device_name)
		ensure
			exists: Result /= Void and then Result.count > 0
		end

	Invalid_baud_error: STRING
			-- An error message indicating `baud'
			-- is an invalid setting
		once
			Result := "Invalid baud rate "
			Result.append_string (baud.out)
		ensure
			exists: Result /= Void and then Result.count > 0
		end

	Invalid_parity_error: STRING
			-- An error message indicating `parity_char'
			-- is an invalid setting
		once
			Result := "Invalid parity setting"
		ensure
			exists: Result /= Void and then Result.count > 0
		end

	Invalid_data_bits_error: STRING
			-- An error message indicating `data_bits'
			-- is an invalid setting
		once
			Result := "Invalid data bits "
			Result.append_string (data_bits.out)
		ensure
			exists: Result /= Void and then Result.count > 0
		end

	Invalid_stop_bits_error: STRING
			-- An error message indicating `stop_bits'
			-- is an invalid setting
		once
			Result := "Invalid stop bits "
			Result.append_string (stop_bits.out)
		ensure
			exists: Result /= Void and then Result.count > 0
		end

	Usage_message: UT_USAGE_MESSAGE
			-- read_port usage message
		local
			s: STRING
		once
			s := "[--settings=x] --device=x"
			s.append_string ("%N")
			s.append_string ("where settings include:%N")
			s.append_string ("  --baud   : Baud rate in symbols per second%N")
			s.append_string ("             Default is 57600%N")
			s.append_string ("  --parity : Parity scheme, e.g. 'None', 'e', 'odd' etc.%N")
			s.append_string ("             Default is no parity%N")
			s.append_string ("  --data   : Number of data bits per word, 5-8%N")
			s.append_string ("             Default is 8%N")
			s.append_string ("  --stop   : Number of stop bits per word, 1-2%N")
			s.append_string ("             Default is 1%N")
			s.append_string ("%N")
			s.append_string ("device is the serial device, e.g. COM1 or /dev/ttyS0%N")

			create Result.make (s)
		ensure
			usage_message_not_void: Result /= Void
		end

end -- class READ_PORT
