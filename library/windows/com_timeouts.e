note

	description:
	
		"Objects that set and query the timeout properties of a communications device."

	library: "Serial Communications Library"
	copyright: "Copyright (c) 2005, Brian E. Heilig"
	license: "Eiffel Forum License v2 (see license.txt)"
	date: "$Date: 2006/04/04 22:27:18 $"
	revision: "$Revision: 1.10 $"

class
	COM_TIMEOUTS

inherit

	EWG_STRUCT
		undefine is_equal end

	KL_SHARED_EXCEPTIONS
		export {NONE} all
		undefine is_equal end

	COM_ABSTRACT_TIMEOUTS
		rename
			overall_timer as read_total_constant,
			inter_character_timer as read_interval
		end

	COM_SHARED_WINDOWS_ERROR
		export {NONE} all
		undefine is_equal end

create

	make, make_existing

feature {NONE} -- Initialization

	make
			-- Create an un-initialized com timeouts structure.
		do
			make_new_unshared
			set_blocking
			set_write_total_multiplier (0)
			set_write_total_constant (0)
		ensure
			exists: exists
			not_shared: not is_shared
			blocking: is_blocking
		end

	make_existing (comm: COM_DEVICE)
			-- Create this structure from an extant, open communications device.
			-- Throws an exception if `GetCommTimeouts' fails.
		require
			exists: comm /= Void
			handle_available: comm.is_open
		do
			make_new_unshared
			get_comm_timeouts (comm)
		ensure
			exists: exists
			not_shared: not is_shared
		end

feature -- Access

	read_interval: INTEGER
			-- Maximum time allowed to elapse between the arrival of two
			-- characters on the communications line, in milliseconds.
			-- During a read operation, the time period begins when the
			-- first character is received. If the interval between the
			-- arrival of any two characters exceeds this amount, the
			-- read operation is completed and any buffered data is returned.
			-- A value of zero indicates that interval time-outs are not used. 
			-- A value of -1, combined with zero values for both the
			-- `read_total_constant' and `read_total_multiplier' specifies
			-- that the read operation is to return immediately with the
			-- characters that have already been received, even if no
			-- characters have been received.
		do
			Result := c_get_read_interval (item)
		end

	read_total_multiplier: INTEGER
			-- Multiplier used to calculate the total time-out period for read
			-- operations, in milliseconds. For each read operation, this value
			-- is multiplied by the requested number of bytes to be read.
		do
			Result := c_get_read_total_multiplier (item)
		end

	read_total_constant: INTEGER
			-- Constant used to calculate the total time-out period for read
			-- operations, in milliseconds. For each read operation, this value
			-- is added to the product of `read_total_multiplier' and the
			-- requested number of bytes. 
			-- A value of zero for both `read_total_multiplier' and this
			-- indicates that total time-outs are not used for read operations.
		do
			Result := c_get_read_total_constant (item)
		end

	write_total_multiplier: INTEGER
			-- Multiplier used to calculate the total time-out period for write
			-- operations, in milliseconds. For each write operation, this value
			-- is multiplied by the number of bytes to be written.
		do
			Result := c_get_write_total_multiplier (item)
		end

	write_total_constant: INTEGER
			-- Constant used to calculate the total time-out period for write
			-- operations, in milliseconds. For each write operation, this value
			-- is added to the product of `write_total_multiplier' member and
			-- the number of bytes to be written. 
			-- A value of zero for both the `write_total_multiplier' and this
			-- indicates that total time-outs are not used for write operations.
		do
			Result := c_get_write_total_constant (item)
		end

feature -- Status report

	is_blocking: BOOLEAN
			-- Indicates read operations block until the requested
			-- number of bytes have been read.
		do
			Result := read_interval = 0 and
				read_total_multiplier = 0 and
				read_total_constant = 0
		end

	is_non_blocking: BOOLEAN
			-- Indicates read operations return immediately with the number of
			-- bytes already received, even if no bytes have been received?
		do
			Result := read_interval = -1 and
				read_total_multiplier = 0 and
				read_total_constant = 0
		end

feature -- Element change

	get_comm_timeouts (comm: COM_DEVICE)
			-- Fill this structure with the timeout properties of an extant,
			-- open communications device.  Throw an exception if call to
			-- GetCommTimeouts fails.
		require
			exists: comm /= Void
			is_open: comm.is_open
		do
			if not (cwin_get_comm_timeouts (comm.handle, item)) then
				Exceptions.raise (timeouts_error(comm.name))
			end
		end

	set_read_interval (an_interval: INTEGER)
			-- Set `read_interval' with `an_interval'
		require
			valid_setting: an_interval >= -1
		do
			c_set_read_interval (item, an_interval)
		ensure
			read_interval_set: read_interval = an_interval
		end

	set_read_total_multiplier (a_multiplier: INTEGER)
			-- Set `read_total_multiplier' with `a_multiplier'
		require
			not_negative: a_multiplier >= 0
		do
			c_set_read_total_multiplier (item, a_multiplier)
		ensure
			read_total_multiplier_set: read_total_multiplier = a_multiplier
		end

	set_read_total_constant (a_constant: INTEGER)
			-- Set `read_total_constant' with `a_constant'
		require
			not_negative: a_constant >= 0
		do
			c_set_read_total_constant (item, a_constant)
		ensure
			read_total_constant_set: read_total_constant = a_constant
		end

	set_blocking
			-- Set the timeout properties to be a pure blocking read.
		do
			set_read_interval (0)
			set_read_total_multiplier (0)
			set_read_total_constant (0)
		ensure then
			definition: read_interval = 0 and
				read_total_multiplier = 0 and
				read_total_constant = 0
		end

	set_non_blocking
			-- Set the timeout properties to be a non-blocking read.
		do
			set_read_interval (-1)
			set_read_total_multiplier (0)
			set_read_total_constant (0)
		ensure then
			definition: read_interval = -1 and
				read_total_multiplier = 0 and
				read_total_constant = 0
		end

	set_overall_timer (time: INTEGER)
			-- Set the timeout properties to include an overall timer.
		do
			set_read_total_multiplier (0)
			set_read_total_constant (time)
		ensure then
			definition: read_total_multiplier = 0 and
				read_total_constant = time
		end

	set_inter_character_timer (time: INTEGER)
			-- Set the timeout properties to include an inter-character
			-- timer.
		do
			set_read_interval (time)
		ensure then
			definition: read_interval = time
		end

	set_write_total_multiplier (a_multiplier: INTEGER)
			-- Set `write_total_multiplier' with `a_multiplier'
		require
			not_negative: a_multiplier >= 0
		do
			c_set_write_total_multiplier (item, a_multiplier)
		ensure
			write_total_multiplier_set: write_total_multiplier = a_multiplier
		end

	set_write_total_constant (a_constant: INTEGER)
			-- Set `write_total_constant' with `a_constant'
		require
			not_negative: a_constant >= 0
		do
			c_set_write_total_constant (item, a_constant)
		ensure
			write_total_constant_set: write_total_constant = a_constant
		end

feature {NONE} -- Error

	timeouts_error (device_name: STRING): STRING
			-- An error message indicating a failure to retrieve
			-- the timeout properties of `device_name'
		require
			device_name_exists: device_name /= Void
		do
			Result := "Failed to obtain the timeout properties of device "
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
			"sizeof (struct _COMMTIMEOUTS)"
		end

feature {NONE} -- Externals

	cwin_get_comm_timeouts (hFile: POINTER; lpCommTimeouts: POINTER): BOOLEAN
		external
			"C use <windows.h>"
		alias
			"GetCommTimeouts"
		end

	c_get_read_interval (an_item: POINTER): INTEGER
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMTIMEOUTS) $an_item)->ReadIntervalTimeout"
		end

	c_set_read_interval (an_item: POINTER; a_value: INTEGER)
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMTIMEOUTS) $an_item)->ReadIntervalTimeout = $a_value"
		end

	c_get_read_total_multiplier (an_item: POINTER): INTEGER
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMTIMEOUTS) $an_item)->ReadTotalTimeoutMultiplier"
		end

	c_set_read_total_multiplier (an_item: POINTER; a_value: INTEGER)
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMTIMEOUTS) $an_item)->ReadTotalTimeoutMultiplier = $a_value"
		end

	c_get_read_total_constant (an_item: POINTER): INTEGER
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMTIMEOUTS) $an_item)->ReadTotalTimeoutConstant"
		end

	c_set_read_total_constant (an_item: POINTER; a_value: INTEGER)
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMTIMEOUTS) $an_item)->ReadTotalTimeoutConstant = $a_value"
		end

	c_get_write_total_multiplier (an_item: POINTER): INTEGER
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMTIMEOUTS) $an_item)->WriteTotalTimeoutMultiplier"
		end

	c_set_write_total_multiplier (an_item: POINTER; a_value: INTEGER)
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMTIMEOUTS) $an_item)->WriteTotalTimeoutMultiplier = $a_value"
		end

	c_get_write_total_constant (an_item: POINTER): INTEGER
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMTIMEOUTS) $an_item)->WriteTotalTimeoutConstant"
		end

	c_set_write_total_constant (an_item: POINTER; a_value: INTEGER)
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMTIMEOUTS) $an_item)->WriteTotalTimeoutConstant = $a_value"
		end

end -- class COM_TIMEOUTS
