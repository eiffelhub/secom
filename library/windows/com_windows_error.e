indexing

	description:

		"Objects that obtain error information from Windows."

	library: "Serial Communications Library"
	copyright: "Copyright (c) 2005, Brian E. Heilig"
	license: "Eiffel Forum License v2 (see license.txt)"
	date: "$Date: 2006/03/26 05:07:55 $"
	revision: "$Revision: 1.3 $"

class

	COM_WINDOWS_ERROR

inherit

	EWG_IMPORTED_EXTERNAL_ROUTINES
		export {NONE} all end

create

	make

feature {NONE} -- Initialization

	make is
			-- Create `pointer'
		do
			create pointer.make_new_unshared (Max_message_length)
		ensure
			exists: pointer /= Void and then pointer.exists
			not_shared: not pointer.is_shared
			capacity_set: pointer.capacity = Max_message_length
		end

feature -- Access

	last_error_string: STRING is
			-- A string version of the last Windows error
		do
			c_error_string (pointer.item, Max_message_length)
			Result := external_string.make_copy_from_c_zero_terminated_string (pointer.item)
		ensure
			exists: Result /= Void
		end

	last_error_code: INTEGER is
			-- The error code of the most recently called Windows function
		external
			"C use <windows.h>"
		alias
			"GetLastError"
		end

	Max_message_length: INTEGER is 256

feature {NONE} -- Implementation

	pointer: EWG_MANAGED_POINTER
			-- Used to store the last error message

feature {NONE} -- External

	c_error_string (ptr: POINTER; max_len: INTEGER) is
			-- Calls GetLastError and FormatMessage. Places the
			-- null-terminated error message in `ptr'.
		external
			"C inline use <windows.h>"
		alias
			"{%N%
			%%TDWORD err = GetLastError();%N%
			%%N%
			%%T(void)FormatMessage(%N%
			%%T%TFORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,%N%
			%%T%TNULL,%N%
			%%T%Terr,%N%
			%%T%TMAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),%N%
			%%T%T(LPTSTR)$ptr,%N%
			%%T%T$max_len,%N%
			%%T%TNULL);%N%
			%}%N"
		end

end -- class COM_WINDOWS_ERROR
