indexing

	description:

		"Objects that perform I/O operations on a communications device."

	library: "Serial Communications Library"
	copyright: "Copyright (c) 2005, Brian E. Heilig"
	license: "Eiffel Forum License v2 (see license.txt)"
	date: "$Date: 2006/03/27 18:39:05 $"
	revision: "$Revision: 1.15 $"

class
	COM_DEVICE

inherit

	KL_SHARED_EXCEPTIONS
		export {NONE} all end

	COM_ABSTRACT_DEVICE

	MEMORY
		redefine dispose end

	COM_SHARED_WINDOWS_ERROR
		export {NONE} all end

create
	make

feature -- Status report

	is_open: BOOLEAN
			-- Is the device open for reading and writing?

feature -- Status setting

	close is
			-- Close the device.
		local
			b: BOOLEAN
		do
			if is_open then
				is_open := False
				b := cwin_close_handle (handle)
			end
			last_write_count := 0
			last_read_count := 0
		end

	open is
			-- Open the device.
		local
			p: POINTER
		do
			p := External_string.string_to_pointer(name)
			handle := cwin_create_file (p, Generic_read | Generic_write,
				0, Default_pointer, Open_existing, 0, Default_pointer)

			if (handle = Invalid_handle_value) then
				is_open := False
			else
				is_open := True
			end
		ensure then
			handle_available_implies_open: handle /= Invalid_handle_value implies is_open
		end

feature -- Access

	handle: POINTER
			-- Handle to communications resource

	control_settings: COM_DEVICE_CONTROL_BLOCK is
			-- Current control parameters for this device
		do
			create Result.make_existing (Current)
		end

	timeouts: COM_TIMEOUTS is
			-- Current timeout properties for this device
		do
			create Result.make_existing (Current)
		end

	properties: COM_PROPERTIES is
			-- Information about the device driver
		require
			handle_available: is_open
			
		do
			create Result.make_existing (Current)
		ensure
			exists: Result /= Void
		end

	status: COM_STATUS is
			-- Line driver status parameters
		require
			handle_available: is_open
		do
			create Result.make_existing (Current)
		ensure
			exists: Result /= Void
		end

feature -- Element change

	set_control_settings (a_settings: COM_DEVICE_CONTROL_BLOCK) is
			-- Configures the device according to the specifications in `a_settings'.
		do
			if not cwin_set_comm_state (handle, a_settings.item) then
				Exceptions.raise (settings_error)
			end
		end

	set_control_string (a_control_string: STRING) is
			-- Configure the device using `a_control_string', e.g. "9600,n,8,1"
		require
			exists: a_control_string /= Void
			handle_available: is_open
		local
			settings: COM_DEVICE_CONTROL_BLOCK
		do
			create settings.make_existing (Current)
			settings.build_from_string (a_control_string)
			set_control_settings (settings)
		end

	set_timeouts (a_timeouts: COM_TIMEOUTS) is
			-- Sets the `timeouts' parameters to those in `a_timeouts'
		do
			if not cwin_set_comm_timeouts (handle, a_timeouts.item) then
				Exceptions.raise (timeouts_error)
			end
		end

feature -- Output

	put_data (data: POINTER; count: INTEGER) is
			-- Write `count' bytes of `data' to the device.  Set
			-- `last_write_count' to the number of bytes written.
		local
			b: BOOLEAN
		do
			last_write_count := 0
			timed_out := False
			b := cwin_write_file (handle, data, count,
								  $last_write_count,
								  default_pointer)

			if not b then
				Exceptions.raise (write_error)
			end

			if last_write_count < count then timed_out := True end
		end

feature -- Input

	read_data (data: POINTER; count: INTEGER) is
			-- Read `count' bytes into the `data' buffer.  Set `last_read_count'
			-- to the number of bytes read. Set `timed_out' if less than `count'
			-- bytes were read. See `timeouts' to determine when read will
			-- be completed.
		local
			b: BOOLEAN
		do
			last_read_count := 0
			timed_out := False
			b := cwin_read_file (handle, data, count,
				$last_read_count, default_pointer)

			if not b then
				Exceptions.raise (read_error)
			end
			
			if last_read_count < count then timed_out := True end
		end

feature -- Removal

	dispose is
			-- If the device is still open then close it
		do
			if is_open then
				close
			end
		end

feature {NONE} -- Errors

	settings_error: STRING is
			-- An error message indicating a failure to apply settings
			-- to the device
		do
			Result := "Failed to apply settings to device "
			Result.append_string (name)
			Result.append_string (": ")
			Result.append_string (Windows_error.last_error_string)
		ensure
			exists: Result /= Void
		end

	timeouts_error: STRING is
			-- An error message indicating a failure to apply timeout
			-- parameters to the device
		do
			Result := "Failed to apply timeouts to device "
			Result.append_string (name)
			Result.append_string (": ")
			Result.append_string (Windows_error.last_error_string)
		ensure
			exists: Result /= Void
		end

	write_error: STRING is
			-- An error message indicating a failure to write to
			-- the device
		do
			Result := "Failed to write to device "
			Result.append_string (name)
			Result.append_string (": ")
			Result.append_string (Windows_error.last_error_string)
		ensure
			exists: Result /= Void
		end

	read_error: STRING is
			-- An error message indicating a failure to read from
			-- the device
		do
			Result := "Failed to read from device "
			Result.append_string (name)
			Result.append_string (": ")
			Result.append_string (Windows_error.last_error_string)
		ensure
			exists: Result /= Void
		end

feature {NONE} -- Externals

	cwin_create_file (lpFileName: POINTER; dwDesiredAccess: INTEGER;
					  dwShareMode: INTEGER; lpSecurityAttributes: POINTER;
					  dwCreationDisposition, dwFlagsAndAttributes: INTEGER;
					  hTemplateFile: POINTER): POINTER is
		external
			"C use <windows.h>"
		alias
			"CreateFile"
		end

	cwin_write_file (hFile: POINTER; lpBuffer: POINTER;
					 nNumberOfBytesToWrite: INTEGER;
					 lpNumberOfBytesWritten: POINTER;
					 lpOverlapped: POINTER): BOOLEAN is
		external
			"C use <windows.h>"
		alias
			"WriteFile"
		end

	cwin_read_file (hFile: POINTER; lpBuffer: POINTER;
					nNumberOfBytesToRead: INTEGER;
					lpNumberOfBytesRead: POINTER;
					lpOverlapped: POINTER): BOOLEAN is
		external
			"C use <windows.h>"
		alias
			"ReadFile"
		end

	cwin_set_comm_state (hFile, lpDCB: POINTER): BOOLEAN is
		external
			"C use <windows.h>"
		alias
			"SetCommState"
		end

	cwin_set_comm_timeouts (hFile: POINTER; lpCommTimeouts: POINTER): BOOLEAN is
		external
			"C use <windows.h>"
		alias
			"SetCommTimeouts"
		end

	cwin_close_handle (hObject: POINTER): BOOLEAN is
		external
			"C use <windows.h>"
		alias
			"CloseHandle"
		end

	Open_existing: INTEGER is
		external
			"C inline use <windows.h>"
		alias
			"OPEN_EXISTING"
		end

	Generic_read: INTEGER is
		external
			"C inline use <windows.h>"
		alias
			"GENERIC_READ"
		end

	Generic_write: INTEGER is
		external
			"C inline use <windows.h>"
		alias
			"GENERIC_WRITE"
		end

	Invalid_handle_value: POINTER is
		external
			"C inline use <windows.h>"
		alias
			"INVALID_HANDLE_VALUE"
		end

end -- class COM_DEVICE
