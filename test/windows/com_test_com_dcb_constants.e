indexing

	description:
	
		"Test cases for Serial Communications Library"

	library: "Serial Communications Library"
	copyright: "Copyright (c) 2005, Brian E. Heilig"
	license: "Eiffel Forum License v2 (see license.txt)"
	date: "$Date: 2006/04/05 00:57:22 $"
	revision: "$Revision: 1.8 $"

deferred class COM_TEST_COM_DCB_CONSTANTS

inherit

	TS_TEST_CASE

feature -- Test

	test_baud_rates is
			-- Ensure the baud rate settings are the expected values
			-- These values are necessary for to_baud_rate to work
		do
			assert_integers_equal ("CBR 110", 110, cdc.Baud_110)
			assert_integers_equal ("CBR 300", 300, cdc.Baud_300)
			assert_integers_equal ("CBR 600", 600, cdc.Baud_600)
			assert_integers_equal ("CBR 1200", 1200, cdc.Baud_1200)
			assert_integers_equal ("CBR 2400", 2400, cdc.Baud_2400)
			assert_integers_equal ("CBR 4800", 4800, cdc.Baud_4800)
			assert_integers_equal ("CBR 9600", 9600, cdc.Baud_9600)
			assert_integers_equal ("CBR 14400", 14400, cdc.Baud_14400)
			assert_integers_equal ("CBR 19200", 19200, cdc.Baud_19200)
			assert_integers_equal ("CBR 38400", 38400, cdc.Baud_38400)
			assert_integers_equal ("CBR 56000", 56000, cdc.Baud_56000)
			assert_integers_equal ("CBR 57600", 57600, cdc.Baud_57600)
			assert_integers_equal ("CBR 115200", 115200, cdc.Baud_115200)
			assert_integers_equal ("CBR 128000", 128000, cdc.Baud_128000)
			assert_integers_equal ("CBR 256000", 256000, cdc.Baud_256000)
		end

	test_dtr_control is
			-- Ensure the DTR control flow settings are the expected values
		do
--			check_integers_equal ("DTR control disable", 0, cdc.Dtr_control_disable)
--			check_integers_equal ("DTR control enable", 1, cdc.Dtr_control_enable)
--			check_integers_equal ("DTR control handshake", 2, cdc.Dtr_control_handshake)
		end

	test_rts_control is
			-- Ensure the RTS control flow settings are the expected values
		do
--			check_integers_equal ("RTS control disable", 0, cdc.Rts_control_disable)
--			check_integers_equal ("RTS control enable", 1, cdc.Rts_control_enable)
--			check_integers_equal ("RTS control handshake", 2, cdc.Rts_control_handshake)
--			check_integers_equal ("RTS control toggle", 3, cdc.Rts_control_toggle)
		end

	test_parity is
			-- Ensure the parity settings are the expected values
		do
--			check_integers_equal ("No parity", 0, cdc.No_parity)
--			check_integers_equal ("Odd parity", 1, cdc.Odd_parity)
--			check_integers_equal ("Even parity", 2, cdc.Even_parity)
--			check_integers_equal ("Mark parity", 3, cdc.Mark_parity)
--			check_integers_equal ("Space parity", 4, cdc.Space_parity)
		end

	test_stop_bits is
			-- Ensure the stop bit settings are the expected values
		do
--			check_integers_equal ("One stop bit", 0, cdc.One_stop_bit)
--			check_integers_equal ("1.5 stop bits", 1, cdc.One_5_stop_bits)
--			check_integers_equal ("2 stop bits", 2, cdc.Two_stop_bits)
		end

	test_data_bits is
			-- Ensure the data bit settings are the expected values
			-- These values are necessary for `to_data_bits' to work
		do
			assert_integers_equal ("5 data bits", 5, cdc.Five_data_bits)
			assert_integers_equal ("6 data bits", 6, cdc.Six_data_bits)
			assert_integers_equal ("7 data bits", 7, cdc.Seven_data_bits)
			assert_integers_equal ("8 data bits", 8, cdc.Eight_data_bits)
		end

feature -- Access

	cdc: COM_DCB_CONSTANTS is
			-- The test object
		once
			create Result
		end

end -- class COM_TEST_COM_DCB_CONSTANTS
