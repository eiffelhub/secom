note

	description:

		"Constants used for device control settings."

	library: "Serial Communications Library"
	copyright: "Copyright (c) 2005, Brian E. Heilig"
	license: "Eiffel Forum License v2 (see license.txt)"
	date: "$Date: 2006/03/26 05:07:51 $"
	revision: "$Revision: 1.6 $"

deferred class
	COM_ABSTRACT_CONTROL_CONSTANTS

feature -- Access (Baud rate)

	Baud_110: INTEGER
			-- 110 symbols per second.
		deferred
		end

	Baud_300: INTEGER
			-- 300 symbols per second.
		deferred
		end

	Baud_600: INTEGER
			-- 600 symbols per second.
		deferred
		end

	Baud_1200: INTEGER
			-- 1200 symbols per second.
		deferred
		end

	Baud_2400: INTEGER
			-- 2400 symbols per second.
		deferred
		end

	Baud_4800: INTEGER
			-- 4800 symbols per second.
		deferred
		end

	Baud_9600: INTEGER
			-- 9600 symbols per second.
		deferred
		end

	Baud_19200: INTEGER
			-- 19200 symbols per second.
		deferred
		end

	Baud_38400: INTEGER
			-- 38400 symbols per second.
		deferred
		end

	Baud_56000: INTEGER
			-- 56000 symbols per second.
		deferred
		end

	Baud_57600: INTEGER
			-- 57600 symbols per second.
		deferred
		end

	Baud_115200: INTEGER
			-- 115200 symbols per second.
		deferred
		end

	Baud_128000: INTEGER
			-- 128000 symbols per second.
		deferred
		end

	Baud_256000: INTEGER
			-- 256000 symbols per second.
		deferred
		end

feature -- Access (parity)

	No_parity: INTEGER
			-- No parity scheme is used
		deferred
		end

	Even_parity: INTEGER
			-- Ensure the number of ones in a data word is even
		deferred
		end

	Odd_parity: INTEGER
			-- Ensure the number of ones in a data word is odd
		deferred
		end

feature -- Access (stop bits)

	One_stop_bit: INTEGER
			-- One stop bit is transmitted per data word
		deferred
		end

	Two_stop_bits: INTEGER
			-- Two stop bits are transmitted per data word
		deferred
		end

feature -- Access (data bits)

	Five_data_bits: INTEGER
			-- Five data bits per word
		deferred
		end

	Six_data_bits: INTEGER
			-- Six data bits per word
		deferred
		end

	Seven_data_bits: INTEGER
			-- Seven data bits per word
		deferred
		end

	Eight_data_bits: INTEGER
			-- Eight data bits per word
		deferred
		end

end -- class COM_ABSTRACT_CONTROL_CONSTANTS
