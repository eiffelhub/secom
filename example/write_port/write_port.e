indexing

	description:
	
		"Root class for the write_port example"

	library: "Serial Communications Library"
	copyright: "Copyright (c) 2005, Brian E. Heilig"
	license: "Eiffel Forum License v2 (see license.txt)"
	date: "$Date: 2006/03/28 20:17:42 $"
	revision: "$Revision: 1.11 $"

class

	WRITE_PORT

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

	make is
			-- Execute 'write_port'
		local
			to: COM_ABSTRACT_TIMEOUTS
		do
			Arguments.set_program_name ("write_port")
			create error_handler.make_standard
			set_default_parameters
			read_command_line

			create {COM_DEVICE} device.make (device_name)
			if not device.is_open then
				report_error (Failed_open_error)
			end

			set_control_settings

			-- Set the device to blocking mode
			to := device.timeouts
			to.set_blocking
			device.set_timeouts (to)

			-- Write the command line parameters to the device
			from lines.start until lines.after loop
				device.put_stream (lines.item_for_iteration, lines.item_for_iteration.count)
				device.put_new_line
				lines.forth
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

	device: COM_ABSTRACT_DEVICE
			-- Serial device to read from

	device_name: STRING
			-- Name of the serial device, e.g. COM1

	baud: INTEGER
			-- Device baud rate

	parity_char: CHARACTER
			-- Character version of parity

	data_bits: INTEGER
			-- Number of data bits per word

	stop_bits: INTEGER
			-- Number of stop bits per word

	lines: DS_LINKED_LIST [STRING]
			-- Lines of data to write to the device

	error_handler: UT_ERROR_HANDLER
			-- Error handler

	set_default_parameters is
			-- Set up the default command line parameters
		do
			baud := 57600
			parity_char := 'n'
			data_bits := 8
			stop_bits := 1
		end

	read_command_line is
			-- Read command line arguments.
		local
			i, nb: INTEGER
			arg: STRING
			arg_param: STRING
		do
			nb := Arguments.argument_count
			create lines.make
			from i := 1 until i > nb loop
				arg := Arguments.argument (i)
				if arg.is_equal ("--help") then
					report_usage_error
				elseif arg.count > 7 and then arg.substring (1, 7).is_equal ("--baud=") then
					arg_param := arg.substring (8, arg.count)
					if not STRING_.is_integer (arg_param) then
						report_usage_error
					else
						baud := arg_param.to_integer
					end
				elseif arg.count > 9 and then arg.substring (1, 9).is_equal ("--parity=") then
					parity_char := arg.item (10)
				elseif arg.count > 7 and then arg.substring (1, 7).is_equal ("--data=") then
					arg_param := arg.substring (8, arg.count)
					if not STRING_.is_integer (arg_param) then
						report_usage_error
					else
						data_bits := arg_param.to_integer
					end
				elseif arg.count > 7 and then arg.substring (1, 7).is_equal ("--stop=") then
					arg_param := arg.substring (8, arg.count)
					if not STRING_.is_integer (arg_param) then
						report_usage_error
					else
						stop_bits := arg_param.to_integer
					end
				elseif arg.count > 9 and then arg.substring (1, 9).is_equal ("--device=") then
					device_name := arg.substring (10, arg.count)
				else
					lines.put_last (arg)
				end
				i := i + 1
			end
			if device_name = Void or else device_name.count = 0 then
				report_usage_error
			end
		ensure
			device_name_set: device_name /= Void and then device_name.count > 0
			lines_not_void: lines /= Void
		end

	set_control_settings is
			-- Apply the control settings to `device'
		require
			device_exists: device /= Void and then device.is_open
		local
			settings: COM_ABSTRACT_SETTINGS
			a_device: COM_ABSTRACT_DEVICE
			setting: INTEGER
		do
			a_device := device
			settings := a_device.control_settings
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
			
			a_device.set_control_settings (settings)
		end

feature {NONE} -- Error handling

	report_usage_error is
			-- Report usage error and then terminate
			-- with exit status 1.
		do
			error_handler.report_error (Usage_message)
			Exceptions.die (1)
		end

	report_error (an_error: STRING) is
			-- Report an error and terminate with
			-- exit status 1.
		do
			std.error.put_string (an_error)
			std.error.put_new_line
			Exceptions.die(1)
		end

	Failed_open_error: STRING is
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

	Invalid_baud_error: STRING is
			-- An error message indicating `baud'
			-- is an invalid setting
		once
			Result := "Invalid baud rate "
			Result.append_string (baud.out)
		ensure
			exists: Result /= Void and then Result.count > 0
		end

	Invalid_parity_error: STRING is
			-- An error message indicating `parity_char'
			-- is an invalid setting
		once
			Result := "Invalid parity setting"
		ensure
			exists: Result /= Void and then Result.count > 0
		end

	Invalid_data_bits_error: STRING is
			-- An error message indicating `data_bits'
			-- is an invalid setting
		once
			Result := "Invalid data bits "
			Result.append_string (data_bits.out)
		ensure
			exists: Result /= Void and then Result.count > 0
		end

	Invalid_stop_bits_error: STRING is
			-- An error message indicating `stop_bits'
			-- is an invalid setting
		once
			Result := "Invalid stop bits "
			Result.append_string (stop_bits.out)
		ensure
			exists: Result /= Void and then Result.count > 0
		end

	Usage_message: UT_USAGE_MESSAGE is
			-- read_port usage message
		local
			s: STRING
		once
			s := "[-settings=x] --device=x [lines]"
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
			s.append_string ("%N")
			s.append_string ("lines is the list of zero or more lines you want%N")
			s.append_string ("written to the device%N")

			create Result.make (s)
		ensure
			usage_message_not_void: Result /= Void
		end

end -- class WRITE_PORT
