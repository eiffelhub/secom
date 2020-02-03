indexing

	description:
	
		"Test cases for an abstract COM_DEVICE. This test requires a serial port %
		%named COM1 and a loopback cable connected to that port."

	library: "Serial Communications Library"
	copyright: "Copyright (c) 2005, Brian E. Heilig"
	license: "Eiffel Forum License v2 (see license.txt)"
	date: "$Date: 2006/04/05 00:22:37 $"
	revision: "$Revision: 1.7 $"

deferred class COM_TEST_COM_DEVICE

inherit

	TS_TEST_CASE

	KL_SHARED_PLATFORM
		export {NONE} all end

	COM_CONTROL_CONSTANTS
		export {NONE} all end

    KL_SHARED_OPERATING_SYSTEM
		export {NONE} all end

feature -- Test

	test_device_exists is
			-- Test to make sure the device was properly opened
		do
			assert (Device_opened_string, Device.is_open)
			assert_strings_equal ("Name set", Device_name, Device.name)

			set_device_defaults

			assert ("Timeouts", Device.timeouts.has_overall_timer)
		end

	test_standard_comm is
			-- Perform some basic communications tests
			-- A loopback must be installed on the test device
		do
			assert (Device_opened_string, Device.is_open)
			set_device_defaults

			Device.put_character ('X')
			assert_integers_equal ("Write character count", Platform.Character_bytes, Device.last_write_count)
			Device.read_character
			assert (Loopback_string, not Device.timed_out)
			assert_integers_equal ("Read character count", Platform.Character_bytes, Device.last_read_count)
			assert_characters_equal ("Read character", 'X', Device.last_character)

			Device.put_integer (1234567890)
			assert_integers_equal ("Write integer count", Platform.Integer_bytes, Device.last_write_count)
			Device.read_integer
			assert ("Didn't timeout", not Device.timed_out)
			assert_integers_equal ("Read integer count", Platform.Integer_bytes, Device.last_read_count)
			assert_integers_equal ("Read integer", 1234567890, Device.last_integer)

			Device.put_boolean (True)
			assert_integers_equal ("Write boolean count", Platform.Boolean_bytes, Device.last_write_count)
			Device.read_boolean
			assert ("Didn't timeout", not Device.timed_out)
			assert_integers_equal ("Read boolean count", Platform.Boolean_bytes, Device.last_read_count)
			assert_booleans_equal ("Read boolean", True, Device.last_boolean)

			Device.put_real (3402823.4663852886e32)
			assert_integers_equal ("Write real count", Platform.Real_bytes, Device.last_write_count)
			Device.read_real
			assert ("Didn't timeout", not Device.timed_out)
			assert_integers_equal ("Read real count", Platform.Real_bytes, Device.last_read_count)
			assert ("Read real", Device.last_real = 3402823.4663852886e32)

			Device.put_double (-12345.6789e-256)
			assert_integers_equal ("Write double count", Platform.Double_bytes, Device.last_write_count)
			Device.read_double
			assert ("Didn't timeout", not Device.timed_out)
			assert_integers_equal ("Read double count", Platform.Double_bytes, Device.last_read_count)
			assert ("Read double", Device.last_double = -12345.6789e-256)

			Device.put_string (A_test_string)
			assert_integers_equal ("Write string count", A_test_string.count + 1, Device.last_write_count)
			Device.read_string
			assert ("Didn't timeout", not Device.timed_out)
			assert_integers_equal ("Read string count", Device.last_string.count + 1, Device.last_read_count)
			assert_strings_equal ("Read string", A_test_string, Device.last_string)

			Device.put_stream (A_test_string, A_test_string.count)
			assert_integers_equal ("Write stream count", A_test_string.count, Device.last_write_count)
			Device.put_new_line
			assert_integers_equal ("Write new line count", 1, Device.last_write_count)
			Device.read_line
			assert ("Didn't timeout", not Device.timed_out)
			assert_integers_equal ("Read line count", Device.last_string.count, Device.last_read_count)
			assert_integers_equal ("Read total", A_test_string.count + 1, Device.last_read_count)

				-- Test the devices ability to send unaltered binary data
			Device.put_stream (Full_ascii_string, Full_ascii_string.count)
			Device.read_stream (Full_ascii_string.count)
			assert ("Didn't timeout", not Device.timed_out)
			assert_integers_equal ("Full ASCII count", Full_ascii_string.count, Device.last_read_count)
			assert_strings_equal ("Full ASCII string", Full_ascii_string, Device.last_string)
		end

	test_timeouts is
			-- Perform some read and write operations with timeouts
		local
			old_to, new_to: COM_ABSTRACT_TIMEOUTS
		do
			assert (Device_opened_string, Device.is_open)
			set_device_defaults

				-- Save timeouts to re-apply later
			old_to := Device.timeouts

				-- First make sure a normal read will work so we don't block forever
			Device.put_character ('~')
			Device.read_character
			assert (Loopback_string, not Device.timed_out)
			assert_integers_equal ("Read count", 1, Device.last_read_count)
			assert_characters_equal ("Read char", '~', Device.last_character)

				-- Set the device timeouts to non-blocking
			new_to := Device.timeouts
			new_to.set_non_blocking
			Device.set_timeouts (new_to)

				-- Now make sure a read times out
			Device.read_character
			assert_integers_equal ("Read count with non blocking", 0, Device.last_read_count)
			assert ("Timed out", Device.timed_out)

				-- Test the overall timeout
			new_to.set_overall_timer (500)
			Device.set_timeouts (new_to)
			Device.read_integer
			assert_integers_equal ("Read count with overall timer", 0, Device.last_read_count)
			assert ("Timed out", Device.timed_out)

				-- Test to ensure read_string will timeout correctly
			Device.put_stream ("The quick brown fox", 19)
			Device.read_string
			assert_integers_equal ("read_string timeout count", 19, Device.last_read_count)
			assert ("read_string timeout", Device.timed_out)
			assert_strings_equal ("read_string timeout string", "The quick brown fox", Device.last_string)

				-- Test to ensure read_line will timeout correctly
			Device.put_string ("The quick brown fox")
			Device.read_line
			assert_integers_equal ("read_line timeout count", 20, Device.last_read_count)
			assert ("read_line timeout", Device.timed_out)
			assert_strings_equal ("read_line timeout string", "The quick brown fox%U", Device.last_string)

				-- Test an inter-character timeout. At least one char must be
				-- received or it will block forever
			new_to.set_overall_timer (0)
			new_to.set_inter_character_timer (500)
			Device.set_timeouts (new_to)
			Device.put_character ('X')
			Device.read_integer
			assert_integers_equal ("Read count with char timer", 1, Device.last_read_count)
			assert ("Timed out", Device.timed_out)

				-- Test a blocking read
			new_to.set_blocking
			Device.set_timeouts (new_to)
			Device.put_string (A_test_string)
			Device.read_stream (A_test_string.count)
			assert_integers_equal ("Read count with blocking", A_test_string.count, Device.last_read_count)
			assert_strings_equal ("Read char", A_test_string, Device.last_string)
			assert ("Not timed out", not Device.timed_out)

			Device.set_timeouts (old_to)
		end

feature -- Access

	set_device_defaults is
			-- Restore default parameters for `Device'
		require
			is_open: Device.is_open
		local
			settings: COM_ABSTRACT_SETTINGS
			timeouts: COM_ABSTRACT_TIMEOUTS
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

	Device: COM_ABSTRACT_DEVICE is
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
			elseif operating_system.is_windows then
				Result := "COM1"
			else
				Result := "/dev/ttyS0"
			end
		ensure
			exists: Result /= Void
			set_from_command_line:
				variables.has ("device") implies
				Result.is_equal (variables.value ("device"))
			windows_default:
				not variables.has ("device") and
				operating_system.is_windows implies
				Result.is_equal ("COM1")
			posix_default:
				not variables.has ("device") and
				operating_system.is_unix implies
				Result.is_equal ("/dev/ttyS0")
		end

	A_test_string: STRING is
		once
			Result := "The quick brown fox jumped over the lazy dog's back."
		ensure
			exists: Result /= Void
		end

	Full_ascii_string: STRING is
			-- A 256-byte string containing all ASCII characters
		once
			Result :=
				"%/000/%/001/%/002/%/003/%/004/%/005/%/006/%/007/%/008/%/009/%
				%%/010/%/011/%/012/%/013/%/014/%/015/%/016/%/017/%/018/%/019/%
				%%/020/%/021/%/022/%/023/%/024/%/025/%/026/%/027/%/028/%/029/%
				%%/030/%/031/%/032/%/033/%/034/%/035/%/036/%/037/%/038/%/039/%
				%%/040/%/041/%/042/%/043/%/044/%/045/%/046/%/047/%/048/%/049/%
				%%/050/%/051/%/052/%/053/%/054/%/055/%/056/%/057/%/058/%/059/%
				%%/060/%/061/%/062/%/063/%/064/%/065/%/066/%/067/%/068/%/069/%
				%%/070/%/071/%/072/%/073/%/074/%/075/%/076/%/077/%/078/%/079/%
				%%/080/%/081/%/082/%/083/%/084/%/085/%/086/%/087/%/088/%/089/%
				%%/090/%/091/%/092/%/093/%/094/%/095/%/096/%/097/%/098/%/099/%
				%%/100/%/101/%/102/%/103/%/104/%/105/%/106/%/107/%/108/%/109/%
				%%/110/%/111/%/112/%/113/%/114/%/115/%/116/%/117/%/118/%/119/%
				%%/120/%/121/%/122/%/123/%/124/%/125/%/126/%/127/%/128/%/129/%
				%%/130/%/131/%/132/%/133/%/134/%/135/%/136/%/137/%/138/%/139/%
				%%/140/%/141/%/142/%/143/%/144/%/145/%/146/%/147/%/148/%/149/%
				%%/150/%/151/%/152/%/153/%/154/%/155/%/156/%/157/%/158/%/159/%
				%%/160/%/161/%/162/%/163/%/164/%/165/%/166/%/167/%/168/%/169/%
				%%/170/%/171/%/172/%/173/%/174/%/175/%/176/%/177/%/178/%/179/%
				%%/180/%/181/%/182/%/183/%/184/%/185/%/186/%/187/%/188/%/189/%
				%%/190/%/191/%/192/%/193/%/194/%/195/%/196/%/197/%/198/%/199/%
				%%/200/%/201/%/202/%/203/%/204/%/205/%/206/%/207/%/208/%/209/%
				%%/210/%/211/%/212/%/213/%/214/%/215/%/216/%/217/%/218/%/219/%
				%%/220/%/221/%/222/%/223/%/224/%/225/%/226/%/227/%/228/%/229/%
				%%/230/%/231/%/232/%/233/%/234/%/235/%/236/%/237/%/238/%/239/%
				%%/240/%/241/%/242/%/243/%/244/%/245/%/246/%/247/%/248/%/249/%
				%%/250/%/251/%/252/%/253/%/254/%/255/"
		ensure
			exists: Result /= Void
			proper_len: Result.count = 256
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

end -- COM_TEST_COM_DEVICE
