indexing

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

	Baud_110: INTEGER is
			-- 110 symbols per second.
		deferred
		end

	Baud_300: INTEGER is
			-- 300 symbols per second.
		deferred
		end

	Baud_600: INTEGER is
			-- 600 symbols per second.
		deferred
		end

	Baud_1200: INTEGER is
			-- 1200 symbols per second.
		deferred
		end

	Baud_2400: INTEGER is
			-- 2400 symbols per second.
		deferred
		end

	Baud_4800: INTEGER is
			-- 4800 symbols per second.
		deferred
		end

	Baud_9600: INTEGER is
			-- 9600 symbols per second.
		deferred
		end

	Baud_19200: INTEGER is
			-- 19200 symbols per second.
		deferred
		end

	Baud_38400: INTEGER is
			-- 38400 symbols per second.
		deferred
		end

	Baud_56000: INTEGER is
			-- 56000 symbols per second.
		deferred
		end

	Baud_57600: INTEGER is
			-- 57600 symbols per second.
		deferred
		end

	Baud_115200: INTEGER is
			-- 115200 symbols per second.
		deferred
		end

	Baud_128000: INTEGER is
			-- 128000 symbols per second.
		deferred
		end

	Baud_256000: INTEGER is
			-- 256000 symbols per second.
		deferred
		end

feature -- Access (parity)

	No_parity: INTEGER is
			-- No parity scheme is used
		deferred
		end

	Even_parity: INTEGER is
			-- Ensure the number of ones in a data word is even
		deferred
		end

	Odd_parity: INTEGER is
			-- Ensure the number of ones in a data word is odd
		deferred
		end

feature -- Access (stop bits)

	One_stop_bit: INTEGER is
			-- One stop bit is transmitted per data word
		deferred
		end

	Two_stop_bits: INTEGER is
			-- Two stop bits are transmitted per data word
		deferred
		end

feature -- Access (data bits)

	Five_data_bits: INTEGER is
			-- Five data bits per word
		deferred
		end

	Six_data_bits: INTEGER is
			-- Six data bits per word
		deferred
		end

	Seven_data_bits: INTEGER is
			-- Seven data bits per word
		deferred
		end

	Eight_data_bits: INTEGER is
			-- Eight data bits per word
		deferred
		end

end -- class COM_ABSTRACT_CONTROL_CONSTANTS
