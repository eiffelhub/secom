indexing

	description:
	
		"Test cases for Serial Communications Library"

	library: "Serial Communications Library"
	copyright: "Copyright (c) 2005, Brian E. Heilig"
	license: "Eiffel Forum License v2 (see license.txt)"
	date: "$Date: 2006/04/04 22:27:19 $"
	revision: "$Revision: 1.5 $"

deferred class COM_TEST_COM_PROP_CONSTANTS

inherit

	TS_TEST_CASE

feature -- Test

	test_settable_params is
			-- Ensure the settable params constants are the expected values
		do
			assert ("SP serial comm", cpc.Sp_serial_comm = 1)
		end

	test_settable_baud_rates is
			-- Ensure the settable baud rates are the expected values
		do
			assert ("Baud 75", cpc.Sb_75 = 1)
			assert ("Baud 110", cpc.Sb_110 = 2)
			assert ("Baud 134.5", cpc.Sb_134_5 = 4)
			assert ("Baud 150", cpc.Sb_150 = 8)
			assert ("Baud 300", cpc.Sb_300 = 16)
			assert ("Baud 600", cpc.Sb_600 = 32)
			assert ("Baud 1200", cpc.Sb_1200 = 64)
			assert ("Baud 1800", cpc.Sb_1800 = 128)
			assert ("Baud 2400", cpc.Sb_2400 = 256)
			assert ("Baud 4800", cpc.Sb_4800 = 512)
			assert ("Baud 7200", cpc.Sb_7200 = 1024)
			assert ("Baud 9600", cpc.Sb_9600 = 2048)
			assert ("Baud 14400", cpc.Sb_14400 = 4096)
			assert ("Baud 19200", cpc.Sb_19200 = 8192)
			assert ("Baud 38400", cpc.Sb_38400 = 16384)
			assert ("Baud 56000", cpc.Sb_56000 = 32768)
			assert ("Baud 57600", cpc.Sb_57600 = 262144)
			assert ("Baud 115200", cpc.Sb_115200 = 131072)
			assert ("Baud 128000", cpc.Sb_128000 = 65536)
			assert ("Baud User", cpc.Sb_user = 268435456)
		end

	test_provider_sub_types is
			-- Ensure the provider sub types are the expected values
		do
			assert ("PST unspecified", cpc.Pst_unspecified = 0)
			assert ("PST RS232", cpc.Pst_rs232 = 1)
			assert ("PST parallel port", cpc.Pst_parallel_port = 2)
			assert ("PST RS422", cpc.Pst_rs422 = 3)
			assert ("PST RS423", cpc.Pst_rs423 = 4)
			assert ("PST RS449", cpc.Pst_rs449 = 5)
			assert ("PST modem", cpc.Pst_modem = 6)
			assert ("PST fax", cpc.Pst_fax = 33)
			assert ("PST scanner", cpc.Pst_scanner = 34)
			assert ("PST network bridge", cpc.Pst_network_bridge = 256)
			assert ("PST lat", cpc.Pst_lat = 257)
			assert ("PST TCP/IP client", cpc.Pst_tcpip_telnet = 258)
			assert ("PST X25", cpc.Pst_x25 = 259)
		end

	test_provider_capabilities is
			-- Ensure provider capability flags are the expected values
		do
			assert ("PCF DTR/DSR", cpc.Pcf_dtr_dsr = 1)
			assert ("PCF RTS/CTS", cpc.Pcf_rts_cts = 2)
			assert ("PCF RLSD", cpc.Pcf_rlsd = 4)
			assert ("PCF parity check", cpc.Pcf_parity_check = 8)
			assert ("PCF XON/XOFF", cpc.Pcf_xon_xoff = 16)
			assert ("PCF set X char", cpc.Pcf_set_x_char = 32)
			assert ("PCF total timeouts", cpc.Pcf_total_timeouts = 64)
			assert ("PCF interval timeouts", cpc.Pcf_int_timeouts = 128)
			assert ("PCF special chars", cpc.Pcf_special_chars = 256)
			assert ("PCF 16 bit mode", cpc.Pcf_16_bit_mode = 512)
		end

	test_settable_parameters is
			-- Ensure the settable parameters are the expected values
		do
			assert ("SP parity", cpc.Sp_parity = 1)
			assert ("SP baud", cpc.Sp_baud = 2)
			assert ("SP data bits", cpc.Sp_data_bits = 4)
			assert ("SP stop bits", cpc.Sp_stop_bits = 8)
			assert ("SP handshaking", cpc.Sp_handshaking = 16)
			assert ("SP parity check", cpc.Sp_parity_check = 32)
			assert ("SP RLSD", cpc.Sp_rlsd = 64)
		end

	test_data_bits is
			-- Ensure selectable data bits are the expected values
		do
			assert ("Data bits 5", cpc.Databits_5 = 1)
			assert ("Data bits 6", cpc.Databits_6 = 2)
			assert ("Data bits 7", cpc.Databits_7 = 4)
			assert ("Data bits 8", cpc.Databits_8 = 8)
			assert ("Data bits 16", cpc.Databits_16 = 16)
			assert ("Data bits 16X", cpc.Databits_16x = 32)
		end

	test_stop_bits is
			-- Ensure selectable stop bits are the expected values
		do
			assert ("1 stop bit", cpc.Stopbits_1 = 1)
			assert ("1.5 stop bits", cpc.Stopbits_1_5 = 2)
			assert ("2 stop bits", cpc.Stopbits_2 = 4)
		end

	test_parity is
			-- Ensure selectable parity constants are the expected values
		do
			assert ("No parity", cpc.Parity_none = 256)
			assert ("Odd parity", cpc.Parity_odd = 512)
			assert ("Even parity", cpc.Parity_even = 1024)
			assert ("Mark parity", cpc.Parity_mark = 2048)
			assert ("Space parity", cpc.Parity_space = 4096)
		end

feature -- Access

	cpc: COM_PROP_CONSTANTS is
			-- The test object
		once
			create Result
		ensure
			exists: Result /= Void
		end

end -- class COM_TEST_COM_PROP_CONSTANTS
