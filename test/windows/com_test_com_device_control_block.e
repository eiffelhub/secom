indexing

	description:
	
		"Test cases for Serial Communications Library"

	library: "Serial Communications Library"
	copyright: "Copyright (c) 2005, Brian E. Heilig"
	license: "Eiffel Forum License v2 (see license.txt)"
	date: "$Date: 2006/03/26 05:07:58 $"
	revision: "$Revision: 1.7 $"

deferred class COM_TEST_COM_DEVICE_CONTROL_BLOCK

inherit

	TS_TEST_CASE

	COM_DCB_CONSTANTS
		export {NONE}
			all
		end

feature -- Test

	test_make_default is
			-- Test feature `make_default'.
		local
			cdcb: COM_DEVICE_CONTROL_BLOCK
		do
			create cdcb.make_default
			assert ("DCB exists", cdcb.exists)
			assert ("Not shared", not cdcb.is_shared)
			assert ("Default baud rate", cdcb.Baud_rate = Baud_9600)
			assert ("Parity check clear", not cdcb.is_parity_checked)
			assert ("CTS control disabled", not cdcb.is_cts_controlled)
			assert ("DSR control disabled", not cdcb.is_dsr_controlled)
			assert ("DTR control disabled", cdcb.dtr_control = Dtr_control_disable)
			assert ("DSR sensitivity disabled", not cdcb.is_dsr_sensitive)
			assert ("Tx continue on xoff disabled", not cdcb.is_tx_continued_on_xoff)
			assert ("Outx controlled", not cdcb.is_outx_controlled)
			assert ("Inx controlled", not cdcb.is_inx_controlled)
			assert ("Errors replaced", not cdcb.are_errors_replaced)
			assert ("Nulls discarded", not cdcb.are_nulls_discarded)
			assert ("RTS control disabled", cdcb.rts_control = Rts_control_disable)
			assert ("Abort on error disabled", not cdcb.is_abort_on_error)
			assert ("Xon lim", cdcb.xon_lim = 1)
			assert ("Data bits", cdcb.data_bits = 8)
			assert ("Parity", cdcb.parity = No_parity)
			assert ("Stop bits", cdcb.stop_bits = One_stop_bit)
			assert ("Xon char", cdcb.xon_char = '%/17/')
			assert ("Xoff char", cdcb.xoff_char = '%/19/')
			assert ("Error char", cdcb.error_char = '%/26/')
			assert ("Eof char", cdcb.eof_char = '%/4/')
			assert ("Event char", cdcb.event_char = '%/7/')
		end

	test_build_from_string is
			-- Test feature `build_from_string'
		local
			cdcb: COM_DEVICE_CONTROL_BLOCK
		do
			create cdcb.make_default

			-- Using 'dtr=hs' or 'rts=tg' causes a failure despite the fact that these settings are allowed.
			-- Windows reports error 87, "The parameter is incorrect"
			cdcb.build_from_string ("baud=56000 parity=m data=7 stop=1.5 xon=off odsr=off octs=off dtr=off rts=off idsr=off")
			assert ("56000 Baud rate", cdcb.baud_rate = Baud_56000)
			assert ("Mark parity", cdcb.parity = Mark_parity)
			assert ("7 data bits", cdcb.data_bits = 7)
			assert ("1.5 stop bits", cdcb.stop_bits = One_5_stop_bits)
			assert ("DTR control disabled", cdcb.dtr_control = Dtr_control_disable)
			assert ("RTS control disabled", cdcb.rts_control = Rts_control_disable)
			assert ("CTS control disabled", not cdcb.is_cts_controlled)
			assert ("DSR control disabled", not cdcb.is_dsr_controlled)
			assert ("DSR sensitivity disabled", not cdcb.is_dsr_sensitive)
			assert ("Outx control disabled", not cdcb.is_outx_controlled)
			assert ("Inx control disabled", not cdcb.is_inx_controlled)

			assert ("Parity check cleared", not cdcb.is_parity_checked)
			assert ("Tx continue on xoff disabled", not cdcb.is_tx_continued_on_xoff)
			assert ("Errors not replaced", not cdcb.are_errors_replaced)
			assert ("Nulls not discarded", not cdcb.are_nulls_discarded)
			assert ("Abort on error disabled", not cdcb.is_abort_on_error)
			assert ("Xon lim", cdcb.xon_lim = 1)
			assert ("Xon char", cdcb.xon_char = '%/17/')
			assert ("Xoff char", cdcb.xoff_char = '%/19/')
			assert ("Error char", cdcb.error_char = '%/26/')
			assert ("Eof char", cdcb.eof_char = '%/4/')
			assert ("Event char", cdcb.event_char = '%/7/')
		end

	test_build_from_string_obsolete_format is
			-- Test feature `build_from_string' using the obsolete format
		local
			cdcb: COM_DEVICE_CONTROL_BLOCK
		do
			create cdcb.make_default

			cdcb.build_from_string ("57600,o,7,1.5")
			assert ("57600 Baud rate", cdcb.baud_rate = Baud_57600)
			assert ("Odd parity", cdcb.parity = Odd_parity)
			assert ("7 data bits", cdcb.data_bits = 7)
			assert ("1.5 stop bits", cdcb.stop_bits = One_5_stop_bits)
			assert ("Parity check cleared", not cdcb.is_parity_checked)
		end

	test_status_setting is
			-- Test status setting features
		local
			cdcb: COM_DEVICE_CONTROL_BLOCK
		do
			create cdcb.make_default

			cdcb.set_parity_check (False)
			assert ("Parity check", not cdcb.is_parity_checked)

			cdcb.set_cts_control (False)
			assert ("CTS control", not cdcb.is_cts_controlled)

			cdcb.set_dsr_control (False)
			assert ("DSR control", not cdcb.is_dsr_controlled)

			cdcb.set_dsr_sensitive (False)
			assert ("DSR sensitive", not cdcb.is_dsr_sensitive)

			cdcb.set_tx_continue_on_xoff (False)
			assert ("Tx continue on XOff", not cdcb.is_tx_continued_on_xoff)

			cdcb.set_outx_control (False)
			assert ("Outx control", not cdcb.is_outx_controlled)

			cdcb.set_inx_control (False)
			assert ("Inx control", not cdcb.is_inx_controlled)

			cdcb.set_error_replacement (False)
			assert ("Error replacement", not cdcb.are_errors_replaced)

			cdcb.set_null_discard (False)
			assert ("Discard nulls", not cdcb.are_nulls_discarded)

			cdcb.set_abort_on_error (False)
			assert ("Abort on error", not cdcb.is_abort_on_error)
		end

	test_element_change is
			-- Test element change features
		local
			cdcb: COM_DEVICE_CONTROL_BLOCK
		do
			create cdcb.make_default

			cdcb.set_baud_rate (Baud_128000)
			assert ("Baud rate", cdcb.baud_rate = Baud_128000)

			cdcb.set_dtr_control (Dtr_control_handshake)
			assert ("DTR control", cdcb.dtr_control = Dtr_control_handshake)

			cdcb.set_rts_control (Rts_control_toggle)
			assert ("RTS control", cdcb.rts_control = Rts_control_toggle)

			cdcb.set_xon_lim (24)
			assert ("Xon limit", cdcb.xon_lim = 24)

			cdcb.set_xoff_lim (128)
			assert ("Xoff limit", cdcb.xoff_lim = 128)

			cdcb.set_data_bits (6)
			assert ("Byte size", cdcb.data_bits = 6)

			cdcb.set_parity (Space_parity)
			assert ("Parity", cdcb.parity = Space_parity)

			cdcb.set_stop_bits (Two_stop_bits)
			assert ("Stop bits", cdcb.stop_bits = Two_stop_bits)

			cdcb.set_xon_char ('A')
			assert ("Xon char", cdcb.xon_char = 'A')

			cdcb.set_xoff_char ('~')
			assert ("Xoff_char", cdcb.xoff_char = '~')

			cdcb.set_error_char ('*')
			assert ("Error char", cdcb.error_char = '*')

			cdcb.set_eof_char ('U')
			assert ("EOF char", cdcb.eof_char = 'U')

			cdcb.set_event_char ('^')
			assert ("Event char", cdcb.event_char = '^')
		end

	test_is_valid_dtr_control is
			-- Test routine `is_valid_dtr_control'
		local
			cdcb: COM_DEVICE_CONTROL_BLOCK
		do
			create cdcb.make_default
			assert ("Dtr_control_disable is valid", cdcb.is_valid_dtr_control (Dtr_control_disable))
			assert ("Dtr_control_enable is valid", cdcb.is_valid_dtr_control (Dtr_control_enable))
			assert ("Dtr_control_handshake is valid", cdcb.is_valid_dtr_control (Dtr_control_handshake))
		end

	test_is_valid_rts_control is
			-- Test routine `is_valid_rts_control'
		local
			cdcb: COM_DEVICE_CONTROL_BLOCK
		do
			create cdcb.make_default
			assert ("Rts_control_disable is valid", cdcb.is_valid_rts_control (Rts_control_disable))
			assert ("Rts_control_enable is valid", cdcb.is_valid_rts_control (Rts_control_enable))
			assert ("Rts_control_handshake is valid", cdcb.is_valid_rts_control (Rts_control_handshake))
			assert ("Rts_control_toggle is valid", cdcb.is_valid_rts_control (Rts_control_toggle))
		end

	test_is_valid_baud is
			-- Test routine `is_valid_baud'
		local
			cdcb: com_DEVICE_CONTROL_BLOCK
		do
			create cdcb.make_default
			assert ("Baud_110 is valid", cdcb.is_valid_baud (Baud_110))
			assert ("Baud_300 is valid", cdcb.is_valid_baud (Baud_300))
			assert ("Baud_600 is valid", cdcb.is_valid_baud (Baud_600))
			assert ("Baud_1200 is valid", cdcb.is_valid_baud (Baud_1200))
			assert ("Baud_2400 is valid", cdcb.is_valid_baud (Baud_2400))
			assert ("Baud_4800 is valid", cdcb.is_valid_baud (Baud_4800))
			assert ("Baud_9600 is valid", cdcb.is_valid_baud (Baud_9600))
			assert ("Baud_14400 is valid", cdcb.is_valid_baud (Baud_14400))
			assert ("Baud_19200 is valid", cdcb.is_valid_baud (Baud_19200))
			assert ("Baud_38400 is valid", cdcb.is_valid_baud (Baud_38400))
			assert ("Baud_56000 is valid", cdcb.is_valid_baud (Baud_56000))
			assert ("Baud_57600 is valid", cdcb.is_valid_baud (Baud_57600))
			assert ("Baud_115200 is valid", cdcb.is_valid_baud (Baud_115200))
			assert ("Baud_128000 is valid", cdcb.is_valid_baud (Baud_128000))
			assert ("Baud_256000 is valid", cdcb.is_valid_baud (Baud_256000))

		end

	test_is_valid_parity is
			-- Test routine `is_valid_parity'
		local
			cdcb: COM_DEVICE_CONTROL_BLOCK
		do
			create cdcb.make_default
			assert ("Odd_parity is valid", cdcb.is_valid_parity (Odd_parity))
			assert ("Even_parity is valid", cdcb.is_valid_parity (Even_parity))
			assert ("No_parity is valid", cdcb.is_valid_parity (No_parity))
			assert ("Mark_parity is valid", cdcb.is_valid_parity (Mark_parity))
			assert ("Space_parity is valid", cdcb.is_valid_parity (Space_parity))
		end

	test_is_valid_stop_bits is
			-- Test routine `is_valid_stop_bits'
		local
			cdcb: COM_DEVICE_CONTROL_BLOCK
		do
			create cdcb.make_default
			assert ("One_stop_bit is valid", cdcb.is_valid_stop_bits (One_stop_bit))
			assert ("Two_stop_bits is valid", cdcb.is_valid_stop_bits (Two_stop_bits))
			assert ("One_5_stop_bits is valid", cdcb.is_valid_stop_bits (One_5_stop_bits))
		end

	test_is_valid_data_bits is
			-- Test routine `is_valid_data_bits'
		local
			cdcb: COM_DEVICE_CONTROL_BLOCK
		do
			create cdcb.make_default
			assert ("Five_data_bits is valid", cdcb.is_valid_data_bits (Five_data_bits))
			assert ("Six_data_bits is valid", cdcb.is_valid_data_bits (Six_data_bits))
			assert ("Seven_data_bits is valid", cdcb.is_valid_data_bits (Seven_data_bits))
			assert ("Eight_data_bits is valid", cdcb.is_valid_data_bits (Eight_data_bits))
		end

	test_to_baud_rate is
			-- Test routine `to_baud_rate'
		local
			cdcb: COM_DEVICE_CONTROL_BLOCK
		do
			create cdcb.make_default
			assert ("Baud_110", cdcb.to_baud_rate (110) = Baud_110)
			assert ("Baud_300", cdcb.to_baud_rate (300) = Baud_300)
			assert ("Baud_600", cdcb.to_baud_rate (600) = Baud_600)
			assert ("Baud_1200", cdcb.to_baud_rate (1200) = Baud_1200)
			assert ("Baud_2400", cdcb.to_baud_rate (2400) = Baud_2400)
			assert ("Baud_4800", cdcb.to_baud_rate (4800) = Baud_4800)
			assert ("Baud_9600", cdcb.to_baud_rate (9600) = Baud_9600)
			assert ("Baud_14400", cdcb.to_baud_rate (14400) = Baud_14400)
			assert ("Baud_19200", cdcb.to_baud_rate (19200) = Baud_19200)
			assert ("Baud_38400", cdcb.to_baud_rate (38400) = Baud_38400)
			assert ("Baud_56000", cdcb.to_baud_rate (56000) = Baud_56000)
			assert ("Baud_57600", cdcb.to_baud_rate (57600) = Baud_57600)
			assert ("Baud_115200", cdcb.to_baud_rate (115200) = Baud_115200)
			assert ("Baud_128000", cdcb.to_baud_rate (128000) = Baud_128000)
			assert ("Baud_256000", cdcb.to_baud_rate (256000) = Baud_256000)
		end

	test_to_parity is
			-- Test routine `to_parity'
		local
			cdcb: COM_DEVICE_CONTROL_BLOCK
		do
			create cdcb.make_default
			assert ("Even_parity1", cdcb.to_parity ('e') = Even_parity)
			assert ("Even_parity2", cdcb.to_parity ('E') = Even_parity)
			assert ("Odd_parity1", cdcb.to_parity ('o') = Odd_parity)
			assert ("Odd_parity2", cdcb.to_parity ('O') = Odd_parity)
			assert ("No_parity1", cdcb.to_parity ('n') = No_parity)
			assert ("No_parity2", cdcb.to_parity ('N') = No_parity)
			assert ("Mark_parity1", cdcb.to_parity ('m') = Mark_parity)
			assert ("Mark_parity2", cdcb.to_parity ('M') = Mark_parity)
			assert ("Space_parity1", cdcb.to_parity ('s') = Space_parity)
			assert ("Space_parity2", cdcb.to_parity ('S') = Space_parity)
		end

	test_to_stop_bits is
			-- Test routine `to_stop_bits'
		local
			cdcb: COM_DEVICE_CONTROL_BLOCK
		do
			create cdcb.make_default
			assert ("One_stop_bit", cdcb.to_stop_bits (1) = One_stop_bit)
			assert ("Two_stop_bits", cdcb.to_stop_bits (2) = Two_stop_bits)
		end

	test_to_data_bits is
			-- Test routine `to_data_bits'
		local
			cdcb: COM_DEVICE_CONTROL_BLOCK
		do
			create cdcb.make_default
			assert ("5 data bits", cdcb.to_data_bits (5) = Five_data_bits)
			assert ("6 data bits", cdcb.to_data_bits (6) = Six_data_bits)
			assert ("7 data bits", cdcb.to_data_bits (7) = Seven_data_bits)
			assert ("8 data bits", cdcb.to_data_bits (8) = Eight_data_bits)
		end

end -- COM_TEST_COM_DEVICE_CONTROL_BLOCK
