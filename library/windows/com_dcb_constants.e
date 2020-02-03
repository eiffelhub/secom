note

	description:
	
		"Device Control Block (DCB) constants used by class COM_DEVICE_CONTROL_BLOCK"

	library: "Serial Communications Library"
	copyright: "Copyright (c) 2005, Brian E. Heilig"
	license: "Eiffel Forum License v2 (see license.txt)"
	date: "$Date: 2006/03/26 05:07:55 $"
	revision: "$Revision: 1.7 $"

class

	COM_DCB_CONSTANTS

inherit

	COM_ABSTRACT_CONTROL_CONSTANTS

feature -- Access (Baud Rate)

	Baud_110: INTEGER
			-- A baud rate of 110 symbols per second.
		external
			"C inline use <windows.h>"
		alias
			"CBR_110"
		end

	Baud_300: INTEGER
			-- A baud rate of 300 symbols per second.
		external
			"C inline use <windows.h>"
		alias
			"CBR_300"
		end
	
	Baud_600: INTEGER
			-- A baud rate of 600 symbols per second.
		external
			"C inline use <windows.h>"
		alias
			"CBR_600"
		end
	
	Baud_1200: INTEGER
			-- A baud rate of 1200 symbols per second.
		external
			"C inline use <windows.h>"
		alias
			"CBR_1200"
		end
	
	Baud_2400: INTEGER
			-- A baud rate of 2400 symbols per second.
		external
			"C inline use <windows.h>"
		alias
			"CBR_2400"
		end
	
	Baud_4800: INTEGER
			-- A baud rate of 4800 symbols per second.
		external
			"C inline use <windows.h>"
		alias
			"CBR_4800"
		end
	
	Baud_9600: INTEGER
			-- A baud rate of 9600 symbols per second.
		external
			"C inline use <windows.h>"
		alias
			"CBR_9600"
		end
	
	Baud_14400: INTEGER
			-- A baud rate of 14.4 kilo symbols per second.
		external
			"C inline use <windows.h>"
		alias
			"CBR_14400"
		end
	
	Baud_19200: INTEGER
			-- A baud rate of 19.2 kilo symbols per second.
		external
			"C inline use <windows.h>"
		alias
			"CBR_19200"
		end
	
	Baud_38400: INTEGER
			-- A baud rate of 38.4 kilo symbols per second.
		external
			"C inline use <windows.h>"
		alias
			"CBR_38400"
		end
	
	Baud_56000: INTEGER
			-- A baud rate of 56 kilo symbols per second.
		external
			"C inline use <windows.h>"
		alias
			"CBR_56000"
		end
	
	Baud_57600: INTEGER
			-- A baud rate of 57.6 kilo symbols per second.
		external
			"C inline use <windows.h>"
		alias
			"CBR_57600"
		end
	
	Baud_115200: INTEGER
			-- A baud rate of 115.2 kilo symbols per second.
		external
			"C inline use <windows.h>"
		alias
			"CBR_115200"
		end
	
	Baud_128000: INTEGER
			-- A baud rate of 128 kilo symbols per second.
		external
			"C inline use <windows.h>"
		alias
			"CBR_128000"
		end
	
	Baud_256000: INTEGER
			-- A baud rate of 256 kilo symbols per second.
		external
			"C inline use <windows.h>"
		alias
			"CBR_256000"
		end

feature -- Access (data-terminal-ready control flow)

	Dtr_control_disable: INTEGER
			-- Disables the DTR line when the device is opened
			-- and leaves it disabled.
		external
			"C inline use <windows.h>"
		alias
			"DTR_CONTROL_DISABLE"
		end
	
	Dtr_control_enable: INTEGER
			-- Enables the DTR line when the device is opened
			-- and leaves it on.
		external
			"C inline use <windows.h>"
		alias
			"DTR_CONTROL_ENABLE"
		end
	
	Dtr_control_handshake: INTEGER
			-- Enables DTR handshaking.  When in use the DTR line can not be
			-- directly controlled.
		external
			"C inline use <windows.h>"
		alias
			"DTR_CONTROL_HANDSHAKE"
		end

feature -- Access (request-to-send control flow)

	Rts_control_disable: INTEGER
			-- Disables the RTS line when the device is opened
			-- and leave it disabled. 
		external
			"C inline use <windows.h>"
		alias
			"RTS_CONTROL_DISABLE"
		end

	Rts_control_enable: INTEGER
			-- Enables the RTS line when the device is opened
			-- and leave it on. 
		external
			"C inline use <windows.h>"
		alias
			"RTS_CONTROL_ENABLE"
		end
	
	Rts_control_handshake: INTEGER
			-- Enables RTS handshaking. The driver raises the RTS line when the
			-- "type-ahead" (input) buffer is less than one-half full and lowers
			-- the RTS line when the buffer is more than three-quarters full.
			-- When in use the RTS line can not be directly controlled.
		external
			"C inline use <windows.h>"
		alias
			"RTS_CONTROL_HANDSHAKE"
		end
	
	Rts_control_toggle: INTEGER
			-- Specifies that the RTS line will be high if bytes are available
			-- for transmission. After all buffered bytes have been sent, the
			-- RTS line will be low. Not available on Windows Me/98/95
		external
			"C inline use <windows.h>"
		alias
			"RTS_CONTROL_TOGGLE"
		end

feature -- Access (Parity)

	No_parity: INTEGER
			-- No parity bit is sent
		external
			"C inline use <windows.h>"
		alias
			"NOPARITY"
		end

	Odd_parity: INTEGER
			-- Parity bit sent for each data word.  The number of ones
			-- in the data byte and the parity bit is always odd
		external
			"C inline use <windows.h>"
		alias
			"ODDPARITY"
		end

	Even_parity: INTEGER
			-- Parity bit sent for each data word.  The number of ones
			-- in the data byte and the parity bit is always even.
		external
			"C inline use <windows.h>"
		alias
			"EVENPARITY"
		end

	Mark_parity: INTEGER
			-- An additional mark bit is sent for each data word.
		external
			"C inline use <windows.h>"
		alias
			"MARKPARITY"
		end

	Space_parity: INTEGER
			-- An additional space bit is sent for each data word.
		external
			"C inline use <windows.h>"
		alias
			"SPACEPARITY"
		end

feature -- Access (Stop Bits)

	One_stop_bit: INTEGER
			-- A mark is sent for each data word, indicating the
			-- end of the word.
		external
			"C inline use <windows.h>"
		alias
			"ONESTOPBIT"
		end

	One_5_stop_bits: INTEGER
			-- 1 mark is sent for odd data words, and 2 marks are sent
			-- for even data words, for an average of 1.5 marks per word.
		external
			"C inline use <windows.h>"
		alias
			"ONE5STOPBITS"
		end
	
	Two_stop_bits: INTEGER
			-- 2 marks are sent for each data word, indicating the
			-- end of the word.
		external
			"C inline use <windows.h>"
		alias
			"TWOSTOPBITS"
		end

feature -- Access (data bits)

	Five_data_bits: INTEGER = 5
			-- Five data bits per word

	Six_data_bits: INTEGER = 6
			-- Five data bits per word

	Seven_data_bits: INTEGER = 7
			-- Five data bits per word

	Eight_data_bits: INTEGER = 8
			-- Five data bits per word

end -- class COM_DCB_CONSTANTS
