indexing

	description:
	
		"Test cases for an abstract COM_DEVICE. This test requires a serial port %
		%named COM1 and a loopback cable connected to that port."

	library: "Serial Communications Library"
	copyright: "Copyright (c) 2005, Brian E. Heilig"
	license: "Eiffel Forum License v2 (see license.txt)"
	date: "$Date: 2006/04/05 00:57:22 $"
	revision: "$Revision: 1.11 $"

deferred class COM_TEST_COM_DEVICE

inherit

	TS_TEST_CASE

	KL_SHARED_PLATFORM
		export {NONE} all end

	COM_CONTROL_CONSTANTS
		export {NONE} all end

	COM_PROP_CONSTANTS
		export {NONE} all end

feature -- Test

	test_device_exists is
			-- Test to make sure the device was properly opened
		do
			assert (Device_opened_string, Device.is_open)
			assert_strings_equal ("Name set", device_name, Device.name)

			set_device_defaults

			assert ("Timeouts", Device.timeouts.has_overall_timer)
		end

	test_set_control_string is
			-- Test the routine `set_control_string'
		local
			dcb: COM_DEVICE_CONTROL_BLOCK
		do
			assert (Device_opened_string, Device.is_open)
			set_device_defaults

			Device.set_control_string ("57600,e,6,2")
			dcb := Device.control_settings
			assert_integers_equal ("57600 baud", Baud_57600, dcb.baud_rate)
			assert_integers_equal ("Even parity", Even_parity, dcb.parity)
			assert_integers_equal ("Six data bits", Six_data_bits, dcb.data_bits)
			assert_integers_equal ("Two stop bits", Two_stop_bits, dcb.stop_bits)

			Device.set_control_string ("9600,n,8,1")
			dcb := Device.control_settings
			assert_integers_equal ("9600 baud", Baud_9600, dcb.baud_rate)
			assert_integers_equal ("No parity", No_parity, dcb.parity)
			assert_integers_equal ("Eight data bits", Eight_data_bits, dcb.data_bits)
			assert_integers_equal ("One stop bit", One_stop_bit, dcb.stop_bits)
		end

	test_com_properties is
			-- Test the com_properties query. 
		local
			prop: COM_PROPERTIES
		do
			assert (Device_opened_string, Device.is_open)
			set_device_defaults

			prop := Device.properties
			assert ("Properties exists", prop /= Void)
--			check_true ("Service provider comm", prop.service_mask.bit_and (Sp_serial_comm) /= 0)
--			check_true ("Provider subtype RS232", prop.provider_sub_type = Pst_rs232)

				-- Settable parameters
--			check_true ("Can set baud", prop.settable_params.bit_and (Sp_baud) /= 0)
--			check_true ("Can set data bits", prop.settable_params.bit_and (Sp_data_bits) /= 0)
--			check_true ("Can set parity", prop.settable_params.bit_and (Sp_parity) /= 0)
--			check_true ("Can check parity", prop.settable_params.bit_and (Sp_parity_check) /= 0)
--			check_true ("Can set stop bits", prop.settable_params.bit_and (Sp_stop_bits) /= 0)

				-- Settable baud rates
--			check_true ("9600 settable", prop.settable_baud.bit_and (Sb_9600) /= 0)
--			check_true ("38400 settable", prop.settable_baud.bit_and (Sb_38400) /= 0)
--			check_true ("57600 settable", prop.settable_baud.bit_and (Sb_57600) /= 0)

				-- Settable data bits
--			check_true ("6 data bits settable", prop.settable_data.bit_and (Databits_6) /= 0)
--			check_true ("7 data bits settable", prop.settable_data.bit_and (Databits_7) /= 0)
--			check_true ("8 data bits settable", prop.settable_data.bit_and (Databits_8) /= 0)

				-- Settable stop bits and parity
--			check_true ("No parity settable", prop.settable_stop_and_parity.bit_and (Parity_none) /= 0)
--			check_true ("Even parity settable", prop.settable_stop_and_parity.bit_and (Parity_even) /= 0)
--			check_true ("Odd parity settable", prop.settable_stop_and_parity.bit_and (Parity_odd) /= 0)
--			check_true ("1 stop bit settable", prop.settable_stop_and_parity.bit_and (Stopbits_1) /= 0)
--			check_true ("2 stop bit settable", prop.settable_stop_and_parity.bit_and (Stopbits_2) /= 0)
		end

	test_com_status is
			-- Test the com_status query
		local
			stat: COM_STATUS
		do
			assert (Device_opened_string, Device.is_open)
			set_device_defaults

				-- Test to ensure a loopback is connected
			Device.put_character ('X')
			assert_integers_equal ("Write character count", Platform.Character_bytes, Device.last_write_count)
			Device.read_character
			assert (Loopback_string, not Device.timed_out)

			Device.put_string (A_test_string)

				-- Allow time for the data to transfer
			cwin_sleep(100)

			stat := Device.status
			assert_integers_equal ("Data available", A_test_string.count + 1, stat.in_queue_count)
			Device.read_string
			assert_integers_equal ("Read count", A_test_string.count + 1, Device.last_read_count)
			assert_strings_equal ("Read string", A_test_string, Device.last_string)
		end

feature -- Access

	set_device_defaults is
			-- Restore default parameters for `Device'
		require
			is_open: Device.is_open
		local
			settings: COM_DEVICE_CONTROL_BLOCK
			timeouts: COM_TIMEOUTS
		do
				-- Set for 9600 8N1
			settings := Device.control_settings
			settings.set_defaults
			settings.set_baud_rate (Baud_9600)
			settings.set_parity (No_parity)
			settings.set_data_bits (Eight_data_bits)
			settings.set_stop_bits (One_stop_bit)
			Device.set_control_settings (settings)

				-- Set a timeout so that tests do not take forever
				-- in case you forgot to put a loopback
			timeouts := Device.timeouts
			timeouts.set_inter_character_timer (0)
			timeouts.set_overall_timer (500)
			Device.set_timeouts (timeouts)
		ensure
			will_timeout: Device.timeouts.has_overall_timer
		end

	Device: COM_DEVICE is
			-- The test object
		once
			create {COM_DEVICE} Result.make (Device_name)
		ensure
			exists: Result /= Void
			name: Result.name.is_equal (Device_name)
		end

	Device_name: STRING is
			-- The device name used for testing.
		once
			if variables.has ("device") then
				Result := variables.value ("device")
			else
				Result := "COM1"
			end
		ensure
			exists: Result /= Void
			set_from_command_line:
				variables.has ("device") implies
				Result.is_equal (variables.value ("device"))
			default:
				not variables.has ("device") implies
				Result.is_equal ("COM1")
		end

	A_test_string: STRING is
		once
			Result := "The quick brown fox jumped over the lazy dog's back."
		end

	Loopback_string: STRING is
		once
			Result := "Loopback connected on "
			Result.append_string (Device_name)
		end

	Device_opened_string: STRING is
		once
			Result := "Device available: "
			Result.append_string (Device_name)
		end

feature {NONE} -- External

	cwin_sleep (dwMilliseconds: INTEGER) is
			-- Sleep for `dwMilliseconds' milliseconds
		external
			"C use <windows.h>"
		alias
			"Sleep"
		end

end -- COM_TEST_COM_DEVICE
