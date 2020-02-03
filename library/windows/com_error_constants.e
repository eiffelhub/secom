note

	description:

		"Errors for a communications device."

	library: "Serial Communications Library"
	copyright: "Copyright (c) 2005, Brian E. Heilig"
	license: "Eiffel Forum License v2 (see license.txt)"
	date: "$Date: 2006/04/05 00:21:08 $"
	revision: "$Revision: 1.4 $"

class
	COM_ERROR_CONSTANTS

feature -- Access

	Ce_error_none: INTEGER = 0
			-- No error

	Ce_rx_overflow: INTEGER
			-- Receive queue overflow
		external
			"C inline use <windows.h>"
		alias
			"CE_RXOVER"
		end

	Ce_overrun: INTEGER
			-- A character-buffer overrun has occurred. The next character is lost.
		external
			"C inline use <windows.h>"
		alias
			"CE_OVERRUN"
		end

	Ce_rx_parity: INTEGER
			-- The hardware detected a parity error.
		external
			"C inline use <windows.h>"
		alias
			"CE_RXPARITY"
		end

	Ce_frame: INTEGER
			-- The hardware detected a framing error.
		external
			"C inline use <windows.h>"
		alias
			"CE_FRAME"
		end

	Ce_break: INTEGER
			-- The hardware detected a break condition.
		external
			"C inline use <windows.h>"
		alias
			"CE_BREAK"
		end

	Ce_tx_full: INTEGER
			-- The application tried to transmit a character, but the
			-- output buffer was full.
		external
			"C inline use <windows.h>"
		alias
			"CE_TXFULL"
		end

	Ce_parallel_time_out: INTEGER
			-- A time-out occurred on a parallel device.
		external
			"C inline use <windows.h>"
		alias
			"CE_PTO"
		end

	Ce_io_error: INTEGER
			-- An I/O error occurred during communications with a parallel device.
		external
			"C inline use <windows.h>"
		alias
			"CE_IOE"
		end

	Ce_device_not_selected: INTEGER
			-- A parallel device is not selected.
		external
			"C inline use <windows.h>"
		alias
			"CE_DNS"
		end

	Ce_out_of_paper: INTEGER
			-- A parallel device signaled that it is out of paper.
		external
			"C inline use <windows.h>"
		alias
			"CE_OOP"
		end

	Ce_mode_unsupported: INTEGER
			-- The requested mode is not supported, or the handle
			-- is invalid.
		external
			"C inline use <windows.h>"
		alias
			"CE_MODE"
		end

feature -- Status report

	is_known_error (an_error: INTEGER): BOOLEAN
			-- Is `an_error' a known error?
		do
			Result := an_error = Ce_error_none or
			          an_error = Ce_rx_overflow or
			          an_error = Ce_overrun or
			          an_error = Ce_rx_parity or
			          an_error = Ce_frame or
			          an_error = Ce_break or
			          an_error = Ce_tx_full or
			          an_error = Ce_parallel_time_out or
			          an_error = Ce_io_error or
			          an_error = Ce_device_not_selected or
			          an_error = Ce_out_of_paper or
			          an_error = Ce_mode_unsupported
		end
	

end -- class COM_ERROR_CONSTANTS
