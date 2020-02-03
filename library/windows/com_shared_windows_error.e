indexing

	description:

		"Shared Windows error."

	library: "Serial Communications Library"
	copyright: "Copyright (c) 2005, Brian E. Heilig"
	license: "Eiffel Forum License v2 (see license.txt)"
	date: "$Date: 2006/03/26 05:07:55 $"
	revision: "$Revision: 1.2 $"

class

	COM_SHARED_WINDOWS_ERROR

feature -- Access

	Windows_error: COM_WINDOWS_ERROR is
			-- Windows error
		once
			create Result.make
		ensure
			exists: Result /= Void
		end

end -- class COM_SHARED_WINDOWS_ERROR
