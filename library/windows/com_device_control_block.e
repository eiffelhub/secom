indexing

	description:

		"Control settings for a serial communications device."

	library: "Serial Communications Library"
	copyright: "Copyright (c) 2005, Brian E. Heilig"
	license: "Eiffel Forum License v2 (see license.txt)"
	date: "$Date: 2006/04/05 00:27:57 $"
	revision: "$Revision: 1.17 $"

class
	COM_DEVICE_CONTROL_BLOCK

inherit

	EWG_STRUCT
		redefine is_equal end

	COM_ABSTRACT_SETTINGS
		rename
			fill_from_device as get_comm_state
		redefine
			is_equal
		end

	COM_DCB_CONSTANTS
		redefine is_equal end

	KL_SHARED_EXCEPTIONS
		export {NONE} all
		redefine is_equal
		end

	EWG_IMPORTED_EXTERNAL_ROUTINES
		export {NONE} all
		redefine is_equal
		end

	COM_SHARED_WINDOWS_ERROR
		export {NONE} all
		redefine is_equal
		end

create

	make_default, make_from_string, make_existing

feature {NONE} -- Initialization

	make_default is
			-- Fill with default values.
			-- Default is 9600 8N1 with flow control
			-- disabled
		do
			make_new_unshared
			c_set_dcb_length (item, sizeof)
			set_defaults
		ensure
			structure_exists: exists
			memory_not_shared: not is_shared
		end

	make_from_string (str: STRING) is
			-- Set defaults, then fill using a device control string.
			-- Throws an exception if `str' is not understood by BuildCommDCB
		require
			exists: str /= Void
		do
			make_default
			build_from_string (str)
		ensure
			structure_exists: exists
			memory_not_shared: not is_shared
			-- Structure has been populated using the contents of `str'.
		end

	make_existing (dev: COM_DEVICE) is
			-- Fill the structure with the control settings of an extant, open
			-- communications resource.  Throws an exception if failed.
		require
			exists: dev /= Void
			handle_available: dev.is_open
		do
			make_default
			get_comm_state (dev)
		ensure
			structure_exists: exists
			memory_not_shared: not is_shared
			filled_from_device: dev.control_settings.is_equal (Current)
		end

feature -- Access

	baud_rate: INTEGER is
			-- Baud rate at which the communications device operates
		do
			Result := c_get_baud_rate (item)
		end

	dtr_control: INTEGER is
			-- DTR (data-terminal-ready) flow control scheme to be used
		do
			Result := c_get_dtr_control (item)
		ensure
			valid_result: is_valid_dtr_control (Result)
		end

	rts_control: INTEGER is
			-- RTS (request-to-send) flow control scheme to be used
		do
			Result := c_get_rts_control (item)
		ensure
			valid_result: is_valid_rts_control (Result)
		end

	xon_lim: INTEGER_16 is
			-- Minimum number of bytes allowed in the input buffer before flow
			-- control is activated to inhibit the sender
		do
			Result := c_get_xon_lim (item)
		end

	xoff_lim: INTEGER_16 is
			-- Maximum number of bytes allowed in the input buffer before flow
			-- control is activated to allow transmission by the sender. The
			-- maximum number of bytes allowed is calculated by subtracting this
			-- value from the size, in bytes, of the input buffer. 
		do
			Result := c_get_xoff_lim (item)
		end

	data_bits: INTEGER is
			-- Number of bits in the bytes transmitted and received.
		do
			Result := c_get_byte_size (item)
		end
		
	parity: INTEGER is
			-- Parity scheme used for transmit and receive.
		do
			Result := c_get_parity (item)
		end

	stop_bits: INTEGER is
			-- Number of stop bits to be used.
		do
			Result := c_get_stop_bits (item)
		end

	xon_char: CHARACTER is
			-- XON character for both transmission and reception.
		do
			Result := c_get_xon_char (item)
		end

	xoff_char: CHARACTER is
			-- XOFF character for both transmission and reception.
		do
			Result := c_get_xoff_char (item)
		end

	error_char: CHARACTER is
			-- Character used to replace bytes received with a parity error. 
		do
			Result := c_get_error_char (item)
		end

	eof_char: CHARACTER is
			-- Character used to signal the end of data.
		do
			Result := c_get_eof_char (item)
		end

	event_char: CHARACTER is
			-- Character used to signal an event.
		do
			Result := c_get_event_char (item)
		end

feature -- Status report

	is_binary_mode: BOOLEAN is
			-- Binary mode enabled?.  Windows does not support
			-- non binary mode transfers, so this member must be TRUE. 
		do
			Result := c_get_binary_mode (item)
		ensure
			only_binary: Result
		end

	is_parity_checked: BOOLEAN is
			-- Check receive parity and report errors?
		do
			Result := c_get_parity_check (item)
		end

	is_cts_controlled: BOOLEAN is
			-- Monitor CTS (clear-to-send) for output flow control? When True
			-- and remote CTS is off, output is suspended until CTS is received. 
		do
			Result := c_get_cts_control (item)
		end

	is_dsr_controlled: BOOLEAN is
			-- Monitor DSR (data-set-ready) for output flow control? When True
			-- and remote DSR is off, output is suspended until DSR is received.
		do
			Result := c_get_dsr_control (item)
		end

	is_dsr_sensitive: BOOLEAN is
			-- Is the communications driver sensitive to the state of the DSR
			-- signal? The driver ignores any bytes received, unless the DSR
			-- modem input line is high.
		do
			Result := c_get_dsr_sensitivity (item)
		end

	is_tx_continued_on_xoff: BOOLEAN is
			-- Continue transmit when `xoff_char' is sent? When True
			-- transmission continues after the input buffer has come within
			-- `xoff_lim' bytes of being full and the driver has transmitted
			-- the `xoff_char' to stop receiving bytes. When False transmission
			-- does not continue until the input buffer is within `xon_lim'
			-- bytes of being empty and the driver has transmitted the
			-- `xon_char' to resume reception.
		do
			Result := c_get_tx_continue_on_xoff (item)
		end

	is_outx_controlled: BOOLEAN is
			-- Is output software flow control used?  When True transmission
			-- stops when the `xoff_char' is received and starts again when
			-- the `xon_char' is received.
		do
			Result := c_get_outx (item)
		end

	is_inx_controlled: BOOLEAN is
			-- Is input software flow control used?  When True the `xoff_char'
			-- is sent when the input buffer comes within `xoff_lim' bytes of
			-- capacity, and the `xon_char' is sent when the input buffer
			-- comes within `xon_lim' bytes of capacity.
		do
			Result := c_get_inx (item)
		end

	are_errors_replaced: BOOLEAN is
			-- Replace errors with `error_char'?
		do
			Result := c_get_replace_errors (item)
		end

	are_nulls_discarded: BOOLEAN is
			-- Discard received null characters?
		do
			Result := c_get_discard_nulls (item)
		end

	is_abort_on_error: BOOLEAN is
			-- Terminate all read and write operations when an error occurs?
			-- The driver will not accept any further communications operations
			-- until the comm error is cleared.
		do
			Result := c_get_abort_on_error (item)
		end

	is_valid_dtr_control (dtr: INTEGER): BOOLEAN is
			-- Is `dtr' a valid dtr control constant?
		do
			Result := dtr >= Dtr_control_disable and
				dtr <= Dtr_control_handshake
		ensure
			definition: Result implies (
				dtr = Dtr_control_disable or
				dtr = Dtr_control_enable or
				dtr = Dtr_control_handshake)
		end

	is_valid_rts_control (rts: INTEGER): BOOLEAN is
			-- Is `rts' a valid rts control constant?
		do
			Result := rts >= Rts_control_disable and
				rts <= Rts_control_toggle
		ensure
			definition: Result implies (
				rts = Rts_control_enable or
				rts = Rts_control_disable or
				rts = Rts_control_handshake or
				rts = Rts_control_toggle)
		end

	is_valid_baud (a_baud: INTEGER): BOOLEAN is
			-- Is `a_baud' a valid baud rate? True only indicates the
			-- operating system supports this rate. The device may not.
		do
			Result := a_baud = Baud_110 or
				a_baud = Baud_300 or
				a_baud = Baud_600 or
				a_baud = Baud_1200 or
				a_baud = Baud_2400 or
				a_baud = Baud_4800 or
				a_baud = Baud_9600 or
				a_baud = Baud_14400 or
				a_baud = Baud_19200 or
				a_baud = Baud_38400 or
				a_baud = Baud_56000 or
				a_baud = Baud_57600 or
				a_baud = Baud_115200 or
				a_baud = Baud_128000 or
				a_baud = Baud_256000
		end

	is_valid_parity (a_parity: INTEGER): BOOLEAN is
			-- Is `a_parity' a valid parity setting?
		do
			Result := a_parity = Odd_parity or
				a_parity = Even_parity or
				a_parity = No_parity or
				a_parity = Mark_parity or
				a_parity = Space_parity
		end

	is_valid_stop_bits (a_stop_bit: INTEGER): BOOLEAN is
			-- Is `a_stop_bit' a valid stop bits setting?
		do
			Result := a_stop_bit = One_stop_bit or
				a_stop_bit = Two_stop_bits or
				a_stop_bit = One_5_stop_bits
		end

	is_valid_data_bits (a_data_bits: INTEGER): BOOLEAN is
			-- Is `a_data_bits' a valid data bits setting?
		do
			Result := a_data_bits = Five_data_bits or
				a_data_bits = Six_data_bits or
				a_data_bits = Seven_data_bits or
				a_data_bits = Eight_data_bits
		end

feature -- Status setting

	set_parity_check (a_value: BOOLEAN) is
			-- Set `is_parity_checked' to `a_value'
		do
			c_set_parity_check (item, a_value)
		end

	set_cts_control (a_value: BOOLEAN) is
			-- Set `is_cts_controlled' to `a_value'
		do
			c_set_cts_control (item, a_value)
		ensure
			cts_control_set: is_cts_controlled = a_value
		end

	set_dsr_control (a_value: BOOLEAN) is
			-- Set `is_dsr_controlled' to `a_value'
		do
			c_set_dsr_control (item, a_value)
		ensure
			dsr_control_set: is_dsr_controlled = a_value
		end

	set_dsr_sensitive (a_value: BOOLEAN) is
			-- Set `is_dsr_sensitive' to `a_value'
		do
			c_set_dsr_sensitivity (item, a_value)
		ensure
			dsr_sensitivity_set: is_dsr_sensitive = a_value
		end

	set_tx_continue_on_xoff (a_value: BOOLEAN) is
			-- Set `is_tx_continued_on_xoff' to `a_value'
		do
			c_set_tx_continue_on_xoff (item, a_value)
		ensure
			tx_continue_on_xoff_set: is_tx_continued_on_xoff = a_value
		end

	set_outx_control (a_value: BOOLEAN) is
			-- Set `is_outx_controlled' to `a_value'
		do
			c_set_outx (item, a_value)
		ensure
			outx_set: is_outx_controlled = a_value
		end

	set_inx_control (a_value: BOOLEAN) is
			-- Set `is_inx_controlled' to `a_value'
		do
			c_set_inx (item, a_value)
		ensure
			inx_set: is_inx_controlled = a_value
		end

	set_error_replacement (a_value: BOOLEAN) is
			-- Set `are_errors_replaced' to `a_value'
		do
			c_set_replace_errors (item, a_value)
		ensure
			replace_errors_set: are_errors_replaced = a_value
		end

	set_null_discard (a_value: BOOLEAN) is
			-- Set `are_nulls_discarded' to `a_value'
		do
			c_set_discard_nulls (item, a_value)
		ensure
			discard_nulls_set: are_nulls_discarded = a_value
		end

	set_abort_on_error (a_value: BOOLEAN) is
			-- Set `is_abort_on_error' to `a_value'
		do
			c_set_abort_on_error (item, a_value)
		ensure
			abort_on_error_set: is_abort_on_error = a_value
		end

feature -- Element change

	get_comm_state (comm: COM_DEVICE) is
			-- Fill the structure with the current state of `comm'.
			-- Throws an exception if failed.
		do
			if not cwin_get_comm_state (comm.handle, item) then
				Exceptions.raise (get_state_error(comm.name))
			end
		end

	build_from_string (str: STRING) is
			-- Fill the DCB using `str' which conforms to the mode
			-- command line parameter structure.
			-- [baud=b] [parity=p] [data=d] [stop=s] [to={on|off}]
			-- [xon={on|off}] [odsr={on|off}] [octs={on|off}]
			-- [dtr={on|off|hs}] [rts={on|off|hs|tg}] [idsr={on|off}]
			-- Obsolete format is still supported. Example, "9600,n,8,1"
			-- Throws an exception if BuildCommDCB fails.
		require
			exists: str /= Void
		do
			if not cwin_build_comm_dcb (External_string.string_to_pointer(str), item) then
				Exceptions.raise (build_from_string_error(str))
			end
		ensure
			-- Structure has been populated using the contents of `str'.
		end

	set_baud_rate (a_baud_rate: INTEGER) is
			-- Set `baud_rate' with `a_baud_rate'
		do
			c_set_baud_rate (item, a_baud_rate)
		end
	
	set_dtr_control (a_dtr_control: INTEGER) is
			-- Set `dtr_control' to `a_dtr_control'
		require
			valid: is_valid_dtr_control (a_dtr_control)
		do
			c_set_dtr_control (item, a_dtr_control)
		ensure
			dtr_control_set: dtr_control = a_dtr_control
		end

	set_rts_control (a_rts_control: INTEGER) is
			-- Set `rts_control' to `a_rts_control'
		require
			valid: is_valid_rts_control (a_rts_control)
		do
			c_set_rts_control (item, a_rts_control)
		ensure
			rts_control_set: rts_control = a_rts_control
		end

	set_xon_lim (a_xon_lim: INTEGER_16) is
			-- Set `xon_lim' to `a_xon_lim'
		do
			c_set_xon_lim (item, a_xon_lim)
		ensure
			xon_lim_set: xon_lim = a_xon_lim
		end
		
	set_xoff_lim (a_xoff_lim: INTEGER_16) is
			-- Set `xoff_lim' to `a_xoff_lim'
		do
			c_set_xoff_lim (item, a_xoff_lim)
		ensure
			xoff_lim_set: xoff_lim = a_xoff_lim
		end

	set_data_bits (a_byte_size: INTEGER) is
			-- Set `byte_size' to `a_byte_size'
		do
			c_set_byte_size (item, a_byte_size.to_integer_8)
		end

	set_parity (a_parity: INTEGER) is
			-- Set `parity' to `a_parity'
		do
			c_set_parity (item, a_parity.to_integer_8)
		end

	set_stop_bits (a_stop_bits: INTEGER) is
			-- Set `stop_bits' to `a_stop_bits'
		do
			c_set_stop_bits (item, a_stop_bits.to_integer_8)
		end

	set_xon_char (a_xon_char: CHARACTER) is
			-- Set `xon_char' to `a_xon_char'
		require
			not_same: a_xon_char /= xoff_char
		do
			c_set_xon_char (item, a_xon_char)
		ensure
			xon_char_set: xon_char = a_xon_char
		end

	set_xoff_char (a_xoff_char: CHARACTER) is
			-- Set `xoff_char' to `a_xoff_char'
		require
			not_same: a_xoff_char /= xon_char
		do
			c_set_xoff_char (item, a_xoff_char)
		ensure
			xoff_char_set: xoff_char = a_xoff_char
		end

	set_error_char (a_error_char: CHARACTER) is
			-- Set `error_char' to `a_error_char'
		do
			c_set_error_char (item, a_error_char)
		ensure
			error_char_set: error_char = a_error_char
		end
		
	set_eof_char (a_eof_char: CHARACTER) is
			-- Set `eof_char' to `a_eof_char'
		do
			c_set_eof_char (item, a_eof_char)
		ensure
			eof_char_set: eof_char = a_eof_char
		end

	set_event_char (a_event_char: CHARACTER) is
			-- Set `event_char' to `a_event_char'
		do
			c_set_event_char (item, a_event_char)
		ensure
			event_char_set: event_char = a_event_char
		end

	set_defaults is
			-- Change all settings to default values.
			-- Default is 9600 8N1 with flow control
			-- disabled
		do
			set_baud_rate (Baud_9600)
			c_set_binary_mode (item, True)
			set_parity_check (False)
			set_cts_control (False)
			set_dsr_control (False)
			set_dtr_control (Dtr_control_disable)
			set_dsr_sensitive (False)
			set_tx_continue_on_xoff (False)
			set_outx_control (False)
			set_inx_control (False)
			set_error_replacement (False)
			set_null_discard (False)
			set_rts_control (Rts_control_disable)
			set_abort_on_error (False)
			c_set_dummy2 (item, 17)
			set_xon_lim (1)
			set_data_bits (Eight_data_bits)
			set_parity (No_parity)
			set_stop_bits (One_stop_bit)
			set_xon_char ('%/17/') -- DC1
			set_xoff_char ('%/19/') -- DC3
			set_error_char ('%/26/') -- SUB
			set_eof_char ('%/4/') -- EOT
			set_event_char ('%/7/') -- BEL
		ensure then
			defaults_set: baud_rate = Baud_9600 and
				data_bits = Eight_data_bits and
				parity = No_parity and
				stop_bits = One_stop_bit and
				xon_char = '%/17/' and
				xoff_char = '%/19/' and
				error_char = '%/26/' and
				eof_char = '%/4/' and
				event_char = '%/7/'
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered equal
			-- to current object?
		do
			Result := baud_rate = other.baud_rate and
				dtr_control = other.dtr_control and
				rts_control = other.rts_control and
				xon_lim = other.xon_lim and
				xoff_lim = other.xoff_lim and
				data_bits = other.data_bits and
				parity = other.parity and
				stop_bits = other.stop_bits and
				xon_char = other.xon_char and
				xoff_char = other.xoff_char and
				error_char = other.error_char and
				eof_char = other.eof_char and
				event_char = other.event_char and
				is_parity_checked = other.is_parity_checked and
				is_cts_controlled = other.is_cts_controlled and
				is_dsr_controlled = other.is_dsr_controlled and
				is_dsr_sensitive = other.is_dsr_sensitive and
				is_tx_continued_on_xoff = other.is_tx_continued_on_xoff and
				is_outx_controlled = other.is_outx_controlled and
				is_inx_controlled = other.is_inx_controlled and
				are_errors_replaced = other.are_errors_replaced and
				are_nulls_discarded = other.are_nulls_discarded and
				is_abort_on_error = other.is_abort_on_error
		end

feature -- Conversion

	to_baud_rate (a_baud_rate: INTEGER): INTEGER is
			-- Converts `a_baud_rate' in symbols per second
			-- to a baud rate setting
		do
			-- This feature is dependent on the fact that in Windows the
			-- settings are the actual values. This fact is verified by
			-- the tests in COM_TEST_COM_DCB_CONSTANTS
			if is_valid_baud (a_baud_rate) then
				Result := a_baud_rate
			else
				Result := -1
			end
		end

	to_parity (a_parity_char: CHARACTER): INTEGER is
			-- Converts `a_parity_char' to a parity setting
		do
			inspect a_parity_char
			when 'e', 'E' then Result := Even_parity
			when 'o', 'O' then Result := Odd_parity
			when 'n', 'N' then Result := No_parity
			when 'm', 'M' then Result := Mark_parity
			when 's', 'S' then Result := Space_parity
			else Result := -1
			end
		end

	to_stop_bits (a_stop_bits: INTEGER): INTEGER is
			-- Converts `a_stop_bits' in number of stop bits to a stop bits setting
		do
			if a_stop_bits = 1 then Result := One_stop_bit
			elseif a_stop_bits = 2 then Result := Two_stop_bits
			else Result := -1
			end
		end

	to_data_bits (a_data_bits: INTEGER): INTEGER is
			-- Converts `a_data_bits' in number of data bits to a data bits setting
		do
			-- This feature is dependent on the fact that in Windows the
			-- settings are the actual values. This fact is verified by
			-- the tests in COM_TEST_COM_DCB_CONSTANTS
			if is_valid_data_bits (a_data_bits) then
				Result := a_data_bits
			else
				Result := -1
			end
		end

feature {NONE} -- Error

	get_state_error (device_name: STRING): STRING is
			-- An error message indicating a failure to retrieve
			-- the current state of `device_name'
		require
			device_name_exists: device_name /= Void
		do
			Result := "Failed to retrieve settings for device "
			Result.append_string (device_name)
			Result.append_string (": ")
			Result.append_string (Windows_error.last_error_string)
		ensure
			result_exists: Result /= Void
		end

	build_from_string_error (str: STRING): STRING is
			-- An error message indicating a failure to build the
			-- device control block from the contents of `str'
		require
			str_exists: str /= Void
		do
			Result := "Failed to build the control settings from '"
			Result.append_string (str)
			Result.append_string ("': ")
			Result.append_string (Windows_error.last_error_string)
		ensure
			result_exists: Result /= Void
		end

feature {NONE} -- Measurement

	sizeof: INTEGER is
			-- Size to allocate (in bytes)
		external
			"C inline use <windows.h>"
		alias
			"sizeof (struct _DCB)"
		end

feature {NONE} -- Externals

	cwin_build_comm_dcb (lpDef, lpDCB: POINTER): BOOLEAN is
		external
			"C use <windows.h>"
		alias
			"BuildCommDCB"
		end

	cwin_get_comm_state (hFile, lpDCB: POINTER): BOOLEAN is
		external
			"C use <windows.h>"
		alias
			"GetCommState"
		end

	c_get_dcb_length (an_item: POINTER): INTEGER is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->DCBlength"
		end

	c_set_dcb_length (an_item: POINTER; a_value: INTEGER) is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->DCBlength = $a_value"
		end

	c_get_baud_rate (an_item: POINTER): INTEGER is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->BaudRate"
		end

	c_set_baud_rate (an_item: POINTER; a_value: INTEGER) is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->BaudRate = $a_value"
		end

	c_get_binary_mode (an_item: POINTER): BOOLEAN is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->fBinary"
		end

	c_set_binary_mode (an_item: POINTER; a_value: BOOLEAN) is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->fBinary = $a_value"
		end

	c_get_parity_check (an_item: POINTER): BOOLEAN is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->fParity"
		end

	c_set_parity_check (an_item: POINTER; a_value: BOOLEAN) is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->fParity = $a_value"
		end

	c_get_cts_control (an_item: POINTER): BOOLEAN is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->fOutxCtsFlow"
		end

	c_set_cts_control (an_item: POINTER; a_value: BOOLEAN) is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->fOutxCtsFlow = $a_value"
		end

	c_get_dsr_control (an_item: POINTER): BOOLEAN is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->fOutxDsrFlow"
		end

	c_set_dsr_control (an_item: POINTER; a_value: BOOLEAN) is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->fOutxDsrFlow = $a_value"
		end

	c_get_dtr_control (an_item: POINTER): INTEGER is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->fDtrControl"
		end

	c_set_dtr_control (an_item: POINTER; a_value: INTEGER) is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->fDtrControl = $a_value"
		end

	c_get_dsr_sensitivity (an_item: POINTER): BOOLEAN is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->fDsrSensitivity"
		end

	c_set_dsr_sensitivity (an_item: POINTER; a_value: BOOLEAN) is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->fDsrSensitivity = $a_value"
		end

	c_get_tx_continue_on_xoff (an_item: POINTER): BOOLEAN is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->fTXContinueOnXoff"
		end

	c_set_tx_continue_on_xoff (an_item: POINTER; a_value: BOOLEAN) is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->fTXContinueOnXoff = $a_value"
		end

	c_get_outx (an_item: POINTER): BOOLEAN is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->fOutX"
		end

	c_set_outx (an_item: POINTER; a_value: BOOLEAN) is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->fOutX = $a_value"
		end

	c_get_inx (an_item: POINTER): BOOLEAN is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->fInX"
		end

	c_set_inx (an_item: POINTER; a_value: BOOLEAN) is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->fInX = $a_value"
		end

	c_get_replace_errors (an_item: POINTER): BOOLEAN is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->fErrorChar"
		end

	c_set_replace_errors (an_item: POINTER; a_value: BOOLEAN) is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->fErrorChar = $a_value"
		end

	c_get_discard_nulls (an_item: POINTER): BOOLEAN is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->fNull"
		end

	c_set_discard_nulls (an_item: POINTER; a_value: BOOLEAN) is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->fNull = $a_value"
		end

	c_get_rts_control (an_item: POINTER): INTEGER is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->fRtsControl"
		end

	c_set_rts_control (an_item: POINTER; a_value: INTEGER) is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->fRtsControl = $a_value"
		end

	c_get_abort_on_error (an_item: POINTER): BOOLEAN is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->fAbortOnError"
		end

	c_set_abort_on_error (an_item: POINTER; a_value: BOOLEAN) is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->fAbortOnError = $a_value"
		end

	c_set_dummy2 (an_item: POINTER; a_value: INTEGER) is
			-- Only used to initialize the structure.  Set to 17.
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->fDummy2 = $a_value"
		end

	c_get_xon_lim (an_item: POINTER): INTEGER_16 is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->XonLim"
		end

	c_set_xon_lim (an_item: POINTER; a_value: INTEGER_16) is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->XonLim = $a_value"
		end

	c_get_xoff_lim (an_item: POINTER): INTEGER_16 is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->XoffLim"
		end

	c_set_xoff_lim (an_item: POINTER; a_value: INTEGER_16) is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->XoffLim = $a_value"
		end

	c_get_byte_size (an_item: POINTER): INTEGER_8 is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->ByteSize"
		end

	c_set_byte_size (an_item: POINTER; a_value: INTEGER_8) is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->ByteSize = $a_value"
		end

	c_get_parity (an_item: POINTER): INTEGER_8 is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->Parity"
		end

	c_set_parity (an_item: POINTER; a_value: INTEGER_8) is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->Parity = $a_value"
		end

	c_get_stop_bits (an_item: POINTER): INTEGER_8 is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->StopBits"
		end

	c_set_stop_bits (an_item: POINTER; a_value: INTEGER_8) is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->StopBits = $a_value"
		end

	c_get_xon_char (an_item: POINTER): CHARACTER is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->XonChar"
		end

	c_set_xon_char (an_item: POINTER; a_value: CHARACTER) is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->XonChar = $a_value"
		end

	c_get_xoff_char (an_item: POINTER): CHARACTER is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->XoffChar"
		end

	c_set_xoff_char (an_item: POINTER; a_value: CHARACTER) is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->XoffChar = $a_value"
		end

	c_get_error_char (an_item: POINTER): CHARACTER is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->ErrorChar"
		end

	c_set_error_char (an_item: POINTER; a_value: CHARACTER) is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->ErrorChar = $a_value"
		end

	c_get_eof_char (an_item: POINTER): CHARACTER is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->EofChar"
		end

	c_set_eof_char (an_item: POINTER; a_value: CHARACTER) is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->EofChar = $a_value"
		end

	c_get_event_char (an_item: POINTER): CHARACTER is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->EvtChar"
		end

	c_set_event_char (an_item: POINTER; a_value: CHARACTER) is
		external
			"C inline use <windows.h>"
		alias
			"((LPDCB) $an_item)->EvtChar = $a_value"
		end

end -- class COM_DEVICE_CONTROL_BLOCK
