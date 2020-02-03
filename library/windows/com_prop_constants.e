indexing

	description:
	
		"Device properties constants used by class COM_PROPERTIES"

	library: "Serial Communications Library"
	copyright: "Copyright (c) 2005, Brian E. Heilig"
	license: "Eiffel Forum License v2 (see license.txt)"
	date: "$Date: 2006/03/26 05:07:55 $"
	revision: "$Revision: 1.3 $"

class
	COM_PROP_CONSTANTS

feature -- Access (service provider type)

	Sp_serial_comm: INTEGER is
			-- Indicates a serial service provider
		external
			"C inline use <windows.h>"
		alias
			"SP_SERIALCOMM"
		end

feature -- Access (selectable baud rates)

	Sb_75: INTEGER is
			-- 75 bits per second
		external
			"C inline use <windows.h>"
		alias
			"BAUD_075"
		end

	Sb_110: INTEGER is
			-- 110 bits per second
		external
			"C inline use <windows.h>"
		alias
			"BAUD_110"
		end

	Sb_134_5: INTEGER is
			-- 134.5 bits per second
		external
			"C inline use <windows.h>"
		alias
			"BAUD_134_5"
		end

	Sb_150: INTEGER is
			-- 150 bits per second
		external
			"C inline use <windows.h>"
		alias
			"BAUD_150"
		end

	Sb_300: INTEGER is
			-- 300 bits per second
		external
			"C inline use <windows.h>"
		alias
			"BAUD_300"
		end

	Sb_600: INTEGER is
			-- 600 bits per second
		external
			"C inline use <windows.h>"
		alias
			"BAUD_600"
		end

	Sb_1200: INTEGER is
			-- 1200 bits per second
		external
			"C inline use <windows.h>"
		alias
			"BAUD_1200"
		end

	Sb_1800: INTEGER is
			-- 1800 bits per second
		external
			"C inline use <windows.h>"
		alias
			"BAUD_1800"
		end

	Sb_2400: INTEGER is
			-- 2400 bits per second
		external
			"C inline use <windows.h>"
		alias
			"BAUD_2400"
		end

	Sb_4800: INTEGER is
			-- 4800 bits per second
		external
			"C inline use <windows.h>"
		alias
			"BAUD_4800"
		end

	Sb_7200: INTEGER is
			-- 7200 bits per second
		external
			"C inline use <windows.h>"
		alias
			"BAUD_7200"
		end

	Sb_9600: INTEGER is
			-- 9600 bits per second
		external
			"C inline use <windows.h>"
		alias
			"BAUD_9600"
		end

	Sb_14400: INTEGER is
			-- 14.4 kilo bits per second
		external
			"C inline use <windows.h>"
		alias
			"BAUD_14400"
		end

	Sb_19200: INTEGER is
			-- 19.2 kilo bits per second
		external
			"C inline use <windows.h>"
		alias
			"BAUD_19200"
		end

	Sb_38400: INTEGER is
			-- 38.4 kilo bits per second
		external
			"C inline use <windows.h>"
		alias
			"BAUD_38400"
		end

	Sb_56000: INTEGER is
			-- 56 kilo bits per second
		external
			"C inline use <windows.h>"
		alias
			"BAUD_56K"
		end

	Sb_57600: INTEGER is
			-- 57.6 kilo bits per second
		external
			"C inline use <windows.h>"
		alias
			"BAUD_57600"
		end

	Sb_115200: INTEGER is
			-- 115.2 kilo bits per second
		external
			"C inline use <windows.h>"
		alias
			"BAUD_115200"
		end

	Sb_128000: INTEGER is
			-- 128 kilo bits per second
		external
			"C inline use <windows.h>"
		alias
			"BAUD_128K"
		end

	Sb_user: INTEGER is
			-- Indicates baud rate is programmable
		external
			"C inline use <windows.h>"
		alias
			"BAUD_USER"
		end

feature -- Access (provider sub types)

	Pst_fax: INTEGER is
			-- FAX device
		external
			"C inline use <windows.h>"
		alias
			"PST_FAX"
		end

	Pst_lat: INTEGER is
			-- Local area terminal protocol
		external
			"C inline use <windows.h>"
		alias
			"PST_LAT"
		end

	Pst_modem: INTEGER is
			-- Modem device
		external
			"C inline use <windows.h>"
		alias
			"PST_MODEM"
		end

	Pst_network_bridge: INTEGER is
			-- Unspecified network bridge
		external
			"C inline use <windows.h>"
		alias
			"PST_NETWORK_BRIDGE"
		end

	Pst_parallel_port: INTEGER is
			-- Parallel port
		external
			"C inline use <windows.h>"
		alias
			"PST_PARALLELPORT"
		end

	Pst_rs232: INTEGER is
			-- RS-232 serial port
		external
			"C inline use <windows.h>"
		alias
			"PST_RS232"
		end

	Pst_rs422: INTEGER is
			-- RS-422 port
		external
			"C inline use <windows.h>"
		alias
			"PST_RS422"
		end

	Pst_rs423: INTEGER is
			-- RS-423 port
		external
			"C inline use <windows.h>"
		alias
			"PST_RS423"
		end

	Pst_rs449: INTEGER is
			-- RS-449 port
		external
			"C inline use <windows.h>"
		alias
			"PST_RS449"
		end

	Pst_scanner: INTEGER is
			-- Scanner device
		external
			"C inline use <windows.h>"
		alias
			"PST_SCANNER"
		end

	Pst_tcpip_telnet: INTEGER is
			-- TCP/IP Telnet® protocol
		external
			"C inline use <windows.h>"
		alias
			"PST_TCPIP_TELNET"
		end

	Pst_unspecified: INTEGER is
			-- Unspecified device
		external
			"C inline use <windows.h>"
		alias
			"PST_UNSPECIFIED"
		end

	Pst_x25: INTEGER is
			-- X.25 standards
		external
			"C inline use <windows.h>"
		alias
			"PST_X25"
		end

feature -- Access (provider capabilities)

	Pcf_16_bit_mode: INTEGER is
			-- Special 16-bit mode supported
		external
			"C inline use <windows.h>"
		alias
			"PCF_16BITMODE"
		end

	Pcf_dtr_dsr: INTEGER is
			-- DTR (data-terminal-ready)/DSR (data-set-ready) supported
		external
			"C inline use <windows.h>"
		alias
			"PCF_DTRDSR"
		end

	Pcf_int_timeouts: INTEGER is
			-- Interval time-outs supported
		external
			"C inline use <windows.h>"
		alias
			"PCF_INTTIMEOUTS"
		end

	Pcf_parity_check: INTEGER is
			-- Parity checking supported
		external
			"C inline use <windows.h>"
		alias
			"PCF_PARITY_CHECK"
		end

	Pcf_rlsd: INTEGER is
			-- RLSD (receive-line-signal-detect) supported
		external
			"C inline use <windows.h>"
		alias
			"PCF_RLSD"
		end

	Pcf_rts_cts: INTEGER is
			-- RTS (request-to-send)/CTS (clear-to-send) supported
		external
			"C inline use <windows.h>"
		alias
			"PCF_RTSCTS"
		end

	Pcf_set_x_char: INTEGER is
			-- Settable XON/XOFF supported
		external
			"C inline use <windows.h>"
		alias
			"PCF_SETXCHAR"
		end

	Pcf_special_chars: INTEGER is
			-- Special character support provided
		external
			"C inline use <windows.h>"
		alias
			"PCF_SPECIALCHARS"
		end

	Pcf_total_timeouts: INTEGER is
			-- Total (elapsed) time-outs supported
		external
			"C inline use <windows.h>"
		alias
			"PCF_TOTALTIMEOUTS"
		end

	Pcf_xon_xoff: INTEGER is
			-- XON/XOFF flow control supported
		external
			"C inline use <windows.h>"
		alias
			"PCF_XONXOFF"
		end

feature -- Access (settable parameters)

	Sp_baud: INTEGER is
			-- Baud rate may be changed
		external
			"C inline use <windows.h>"
		alias
			"SP_BAUD"
		end

	Sp_data_bits: INTEGER is
			-- Data bits may be changed
		external
			"C inline use <windows.h>"
		alias
			"SP_DATABITS"
		end

	Sp_handshaking: INTEGER is
			-- Flow control may be changed
		external
			"C inline use <windows.h>"
		alias
			"SP_HANDSHAKING"
		end

	Sp_parity: INTEGER is
			-- Parity scheme may be changed
		external
			"C inline use <windows.h>"
		alias
			"SP_PARITY"
		end

	Sp_parity_check: INTEGER is
			-- Parity checking may be changed
		external
			"C inline use <windows.h>"
		alias
			"SP_PARITY_CHECK"
		end

	Sp_rlsd: INTEGER is
			-- RLSD (receive-line-signal-detect) may be changed
		external
			"C inline use <windows.h>"
		alias
			"SP_RLSD"
		end

	Sp_stop_bits: INTEGER is
			-- Stop bits may be changed
		external
			"C inline use <windows.h>"
		alias
			"SP_STOPBITS"
		end

feature -- Access (selectable data bits)

	Databits_5: INTEGER_16 is
			-- 5 data bits may be used
		external
			"C inline use <windows.h>"
		alias
			"DATABITS_5"
		end

	Databits_6: INTEGER_16 is
			-- 6 data bits may be used
		external
			"C inline use <windows.h>"
		alias
			"DATABITS_6"
		end

	Databits_7: INTEGER_16 is
			-- 7 data bits may be used
		external
			"C inline use <windows.h>"
		alias
			"DATABITS_7"
		end

	Databits_8: INTEGER_16 is
			-- 8 data bits may be used
		external
			"C inline use <windows.h>"
		alias
			"DATABITS_8"
		end

	Databits_16: INTEGER_16 is
			-- 16 data bits may be used
		external
			"C inline use <windows.h>"
		alias
			"DATABITS_16"
		end

	Databits_16x: INTEGER_16 is
			-- Special wide path through serial hardware lines
		external
			"C inline use <windows.h>"
		alias
			"DATABITS_16X"
		end

feature -- Access (selectable stop bits)

	Stopbits_1: INTEGER_16 is
			-- 1 stop bit may be used
		external
			"C inline use <windows.h>"
		alias
			"STOPBITS_10"
		end

	Stopbits_1_5: INTEGER_16 is
			-- 1.5 stop bits may be used
		external
			"C inline use <windows.h>"
		alias
			"STOPBITS_15"
		end

	Stopbits_2: INTEGER_16 is
			-- 2 stop bits may be used
		external
			"C inline use <windows.h>"
		alias
			"STOPBITS_20"
		end

feature -- Access (selectable parity schemes)

	Parity_none: INTEGER_16 is
			-- `No parity' may be used
		external
			"C inline use <windows.h>"
		alias
			"PARITY_NONE"
		end

	Parity_odd: INTEGER_16 is
			-- Odd parity may be used
		external
			"C inline use <windows.h>"
		alias
			"PARITY_ODD"
		end

	Parity_even: INTEGER_16 is
			-- Even parity may be used
		external
			"C inline use <windows.h>"
		alias
			"PARITY_EVEN"
		end

	Parity_mark: INTEGER_16 is
			-- Mark parity may be used
		external
			"C inline use <windows.h>"
		alias
			"PARITY_MARK"
		end

	Parity_space: INTEGER_16 is
			-- Space parity may be used
		external
			"C inline use <windows.h>"
		alias
			"PARITY_SPACE"
		end

end -- class COM_PROP_CONSTANTS
