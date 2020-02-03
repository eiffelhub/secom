indexing

	description:

		"External Garbage Collector routines"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see license.txt)"
	date: "$Date: 2006/03/26 05:07:52 $"
	revision: "$Revision: 1.3 $"


class EWG_EXTERNAL_GARBAGE_COLLECTOR_ROUTINES

feature


	eif_adopt (a_object: ANY): POINTER is
		require
			a_object_not_void: a_object /= Void
		external
			"C [macro <eif_macros.h>]"
		alias
			"eif_adopt"
		ensure
			eif_adopt_not_default_pointer: Result /= Default_pointer
		end

	eif_wean (a_pointer: POINTER) is
		require
			a_pointer_not_void: a_pointer /= Default_pointer
		external
			"C [macro <eif_macros.h>]"
		alias
			"eif_wean"
		end

	eif_access (a_pointer: POINTER): ANY is
		require
			a_pointer_not_void: a_pointer /= Default_pointer
		external
			"C [macro <eif_macros.h>]"
		alias
			"eif_access"
		ensure
			eif_access_not_void: Result /= Void
		end

























































































end
