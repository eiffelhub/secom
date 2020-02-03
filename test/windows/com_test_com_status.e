indexing

	description:
	
		"Test cases for the COM_STATUS class"

	library: "Serial Communications Library"
	copyright: "Copyright (c) 2005, Brian E. Heilig"
	license: "Eiffel Forum License v2 (see license.txt)"
	date: "$Date: 2006/03/26 05:07:58 $"
	revision: "$Revision: 1.3 $"

deferred class COM_TEST_COM_STATUS

inherit

	TS_TEST_CASE

	COM_ERROR_CONSTANTS
		export {NONE} all end

feature -- Test

	test_make is
			-- Test feature `make'.
		do
			assert ("COMSTAT exists", cs.exists)
			assert ("Not shared", not cs.is_shared)
		end

	test_read_write is
			-- Test features to set and read attributes
		do
			c_set_cts_hold (cs.item, True)
			assert ("CTS Hold", cs.is_cts_hold)

			c_set_dsr_hold (cs.item, False)
			assert ("DSR Hold", not cs.is_dsr_hold)

			c_set_rlsd_hold (cs.item, True)
			assert ("RLSD Hold", cs.is_rlsd_hold)

			c_set_xoff_hold (cs.item, False)
			assert ("Xoff hold", not cs.is_xoff_hold)

			c_set_xoff_sent (cs.item, True)
			assert ("Xoff sent", cs.is_xoff_sent)

			c_set_eof (cs.item, False)
			assert ("EOF", not cs.is_eof)

			c_set_tx_char_queued (cs.item, True)
			assert ("Tx char queued", cs.is_tx_char_queued)

			c_set_in_queue_count (cs.item, 5678)
			assert ("In queue count", cs.in_queue_count = 5678)

			c_set_out_queue_count (cs.item, 123456)
			assert ("Out queue count", cs.out_queue_count = 123456)
		end

feature -- Access

	cs: COM_STATUS is
			-- The test object
		once
			create Result.make
		end

feature {NONE} -- Externals

	c_set_cts_hold (an_item: POINTER; a_value: BOOLEAN) is
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMSTAT) $an_item)->fCtsHold = $a_value"
		end

	c_set_dsr_hold (an_item: POINTER; a_value: BOOLEAN) is
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMSTAT) $an_item)->fDsrHold = $a_value"
		end

	c_set_rlsd_hold (an_item: POINTER; a_value: BOOLEAN) is
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMSTAT) $an_item)->fRlsdHold = $a_value"
		end

	c_set_xoff_hold (an_item: POINTER; a_value: BOOLEAN) is
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMSTAT) $an_item)->fXoffHold = $a_value"
		end

	c_set_xoff_sent (an_item: POINTER; a_value: BOOLEAN) is
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMSTAT) $an_item)->fXoffSent = $a_value"
		end

	c_set_eof (an_item: POINTER; a_value: BOOLEAN) is
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMSTAT) $an_item)->fEof = $a_value"
		end

	c_set_tx_char_queued (an_item: POINTER; a_value: BOOLEAN) is
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMSTAT) $an_item)->fTxim = $a_value"
		end

	c_set_in_queue_count (an_item: POINTER; a_value: INTEGER) is
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMSTAT) $an_item)->cbInQue = $a_value"
		end

	c_set_out_queue_count (an_item: POINTER; a_value: INTEGER) is
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMSTAT) $an_item)->cbOutQue = $a_value"
		end

end -- COM_TEST_COM_STATUS
