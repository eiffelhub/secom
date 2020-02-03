indexing

	description:
	
		"Test cases for the COM_STATUS class"

	library: "Serial Communications Library"
	copyright: "Copyright (c) 2005, Brian E. Heilig"
	license: "Eiffel Forum License v2 (see license.txt)"
	date: "$Date: 2006/03/26 05:07:58 $"
	revision: "$Revision: 1.2 $"

deferred class COM_TEST_COM_TIMEOUTS

inherit

	TS_TEST_CASE

feature -- Test

	test_make is
			-- Test feature `make'.
		do
			assert ("COMMTIMEOUTS exists", ct.exists)
			assert ("Not shared", not ct.is_shared)
		end

	test_read_write is
			-- Test features to set and read attributes
		do
			ct.set_read_interval (-1)
			assert ("Read interval", ct.read_interval = -1)
			ct.set_read_total_multiplier (12345)
			assert ("Read total multiplier", ct.read_total_multiplier = 12345)
			ct.set_read_total_constant (23456)
			assert ("Read total constant", ct.read_total_constant = 23456)
			ct.set_write_total_multiplier (345678)
			assert ("Write total multiplier", ct.write_total_multiplier = 345678)
			ct.set_write_total_constant (98765432)
			assert ("Write total constant", ct.write_total_constant = 98765432)
		end

feature -- Access

	ct: COM_TIMEOUTS is
			-- The test object
		once
			create Result.make
		end

end -- COM_TEST_COM_TIMEOUTS
