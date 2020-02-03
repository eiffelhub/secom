indexing

	description:
	
		"Test cases for COM_ERROR_CONSTANTS"

	library: "Serial Communications Library"
	copyright: "Copyright (c) 2005, Brian E. Heilig"
	license: "Eiffel Forum License v2 (see license.txt)"
	date: "$Date: 2006/03/26 05:07:58 $"
	revision: "$Revision: 1.3 $"

deferred class COM_TEST_COM_ERROR_CONSTANTS

inherit

	TS_TEST_CASE

feature -- Test

	test_error_constants is
			-- Ensure the com error constants are the expected values
		do
			assert ("No error", cec.Ce_error_none = 0)
			assert ("Rx overflow", cec.Ce_rx_overflow = 1)
			assert ("Overrun", cec.Ce_overrun = 2)
			assert ("Rx parity", cec.Ce_rx_parity = 4)
			assert ("Rx frame", cec.Ce_frame = 8)
			assert ("Break detect", cec.Ce_break = 16)
			assert ("Tx full", cec.Ce_tx_full = 256)
			assert ("Parallel time out", cec.Ce_parallel_time_out = 512)
			assert ("Parallel IO error", cec.Ce_io_error = 1024)
			assert ("Device not selected", cec.Ce_device_not_selected = 2048)
			assert ("Out of paper", cec.Ce_out_of_paper = 4096)
			assert ("Mode unsupported", cec.Ce_mode_unsupported = 32768)
		end

	test_is_known_error is
			-- Test feature `is_known_error'
		do
			assert ("No error", cec.is_known_error(cec.Ce_error_none))
			assert ("Rx overflow", cec.is_known_error(cec.Ce_rx_overflow))
			assert ("Overrun", cec.is_known_error(cec.Ce_overrun))
			assert ("Rx parity", cec.is_known_error(cec.Ce_rx_parity))
			assert ("Rx frame", cec.is_known_error(cec.Ce_frame))
			assert ("Break detect", cec.is_known_error(cec.Ce_break))
			assert ("Tx full", cec.is_known_error(cec.Ce_tx_full))
			assert ("Parallel time out", cec.is_known_error(cec.Ce_parallel_time_out))
			assert ("Parallel IO error", cec.is_known_error(cec.Ce_io_error))
			assert ("Device not selected", cec.is_known_error(cec.Ce_device_not_selected))
			assert ("Out of paper", cec.is_known_error(cec.Ce_out_of_paper))
			assert ("Mode unsupported", cec.is_known_error(cec.Ce_mode_unsupported))
		end

feature -- Access

	cec: COM_ERROR_CONSTANTS is
			-- The test object
		once
			create Result
		end

end -- class COM_TEST_COM_ERROR_CONSTANTS
