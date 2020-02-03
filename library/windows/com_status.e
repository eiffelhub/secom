note

	description:

		"Objects that retrieve the status of a communications device."

	library: "Serial Communications Library"
	copyright: "Copyright (c) 2005, Brian E. Heilig"
	license: "Eiffel Forum License v2 (see license.txt)"
	date: "$Date: 2006/04/04 22:27:18 $"
	revision: "$Revision: 1.6 $"

class
	COM_STATUS

inherit

	EWG_STRUCT

	KL_SHARED_EXCEPTIONS
		export {NONE} all end

	COM_ERROR_CONSTANTS
		export {NONE} all end

	COM_SHARED_WINDOWS_ERROR
		export {NONE} all end

create
	make, make_existing

feature {NONE} -- Initialization

	make
			-- Create an un-initialized com status structure.
		do
			make_new_unshared
		ensure
			exists: exists
			not_shared: not is_shared
		end

	make_existing (comm: COM_DEVICE)
			-- Create this structure from an extant, open communications device.
			-- Throws an exception if call to `get_comm_stat' fails.
		require
			exists: comm /= Void
			handle_available: comm.is_open
		do
			make_new_unshared
			get_comm_stat (comm)
		ensure
			exists: exists
			not_shared: not is_shared
		end

feature -- Access

	in_queue_count: INTEGER
			-- Number of bytes received by the serial provider but not yet read.
		do
			Result := c_get_in_queue_count (item)
		end

	out_queue_count: INTEGER
			-- Number of bytes remaining to be transmitted for all write operations.
		do
			Result := c_get_out_queue_count (item)
		end

	last_error: INTEGER
			-- Last error reported from `get_comm_stat'.

feature -- Status report

	is_cts_hold: BOOLEAN
			-- Is transmission waiting for the CTS (clear-to-send) signal to be sent?
		do
			Result := c_get_cts_hold (item)
		end

	is_dsr_hold: BOOLEAN
			-- Is transmission waiting for the DSR (data-set-ready) signal to be sent?
		do
			Result := c_get_dsr_hold (item)
		end

	is_rlsd_hold: BOOLEAN
			-- Is transmission  waiting for the RLSD (receive-line-signal-detect)
			-- signal to be sent?
		do
			Result := c_get_rlsd_hold (item)
		end

	is_xoff_hold: BOOLEAN
			-- Is transmission waiting because the XOFF character was received?
		do
			Result := c_get_xoff_hold (item)
		end

	is_xoff_sent: BOOLEAN
			-- Is transmission waiting because the XOFF character was transmitted?
		do
			Result := c_get_xoff_sent (item)
		end

	is_eof: BOOLEAN
			-- Has the EOF (end-of-file) character been received?
		do
			Result := c_get_eof (item)
		end

	is_tx_char_queued: BOOLEAN
			-- Is there a character queued for transmission that has come to the
			-- communications device by way of the transmit_comm_char function?
			-- The communications device transmits such a character ahead of other
			-- characters in the device's output buffer. 
		do
			Result := c_get_tx_char_queued (item)
		end

feature -- Element change

	get_comm_stat (comm: COM_DEVICE)
			-- Retrieve the current information about the `comm' device.
			-- This function has the unavoidable side effect of clearing any
			-- comm error.  Throws an exception if call fails.
		require
			exists: comm /= Void
			handle_available: comm.is_open
		do
			if not cwin_get_comm_stat (comm.handle, $last_error, item) then
				Exceptions.raise (comm_state_error(comm.name))
			end
		end

feature {NONE} -- Error

	comm_state_error (device_name: STRING): STRING
			-- An error message indicating a failure to retrieve
			-- the comm status from `device_name'
		require
			device_name_exists: device_name /= Void
		do
			Result := "Failed to obtain the status of device "
			Result.append_string (device_name)
			Result.append_string (": ")
			Result.append_string (Windows_error.last_error_string)
		ensure
			result_exists: Result /= Void
		end

feature {NONE} -- Measurement

	sizeof: INTEGER
			-- Size to allocate (in bytes)
		external
			"C inline use <windows.h>"
		alias
			"sizeof (struct _COMSTAT)"
		end

feature {NONE} -- Externals

	cwin_get_comm_stat (hFile, lpErrors, lpStat: POINTER): BOOLEAN
		external
			"C use <windows.h>"
		alias
			"ClearCommError"
		end

	c_get_cts_hold (an_item: POINTER): BOOLEAN
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMSTAT) $an_item)->fCtsHold"
		end

	c_get_dsr_hold (an_item: POINTER): BOOLEAN
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMSTAT) $an_item)->fDsrHold"
		end

	c_get_rlsd_hold (an_item: POINTER): BOOLEAN
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMSTAT) $an_item)->fRlsdHold"
		end

	c_get_xoff_hold (an_item: POINTER): BOOLEAN
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMSTAT) $an_item)->fXoffHold"
		end

	c_get_xoff_sent (an_item: POINTER): BOOLEAN
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMSTAT) $an_item)->fXoffSent"
		end

	c_get_eof (an_item: POINTER): BOOLEAN
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMSTAT) $an_item)->fEof"
		end

	c_get_tx_char_queued (an_item: POINTER): BOOLEAN
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMSTAT) $an_item)->fTxim"
		end

	c_get_in_queue_count (an_item: POINTER): INTEGER
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMSTAT) $an_item)->cbInQue"
		end

	c_get_out_queue_count (an_item: POINTER): INTEGER
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMSTAT) $an_item)->cbOutQue"
		end

end -- class COM_STATUS
