indexing

	description:
	
		"Test cases for Serial Communications Library"

	library: "Serial Communications Library"
	copyright: "Copyright (c) 2005, Brian E. Heilig"
	license: "Eiffel Forum License v2 (see license.txt)"
	date: "$Date: 2006/03/26 05:07:58 $"
	revision: "$Revision: 1.3 $"

deferred class COM_TEST_COM_PROPERTIES

inherit

	TS_TEST_CASE

	COM_PROP_CONSTANTS
		export {NONE} all end

feature -- Test

	test_make is
			-- Test feature `make'.
		do
			assert ("COMMPROP exists", cp.exists)
		end

	test_read_write is
			-- Test features to set and read attributes
		do
			c_set_packet_length (cp.item, 123)
			assert ("Set/get packet length", cp.packet_length = 123)
			
			c_set_packet_version (cp.item, 234)
			assert ("Set/get packet version", cp.packet_version = 234)
			
			c_set_service_mask (cp.item, 3012345)
			assert ("Set/get service mask", cp.service_mask = 3012345)
			
			c_set_max_tx_queue (cp.item, -3012345)
			assert ("Set/get max tx queue", cp.max_tx_queue = -3012345)
			
			c_set_max_rx_queue (cp.item, -31123)
			assert ("Set/get max rx queue", cp.max_rx_queue = -31123)

			c_set_max_baud (cp.item, Sb_57600)
			assert ("Set/get max baud", cp.max_baud = Sb_57600)

			c_set_prov_sub_type (cp.item, 23456)
			assert ("Set/get provider sub type", cp.provider_sub_type = 23456)

			c_set_prov_capabilities (cp.item, 234)
			assert ("Set/get provider capabilities", cp.provider_capabilities = 234)

			c_set_settable_params (cp.item, 4567)
			assert ("Set/get settable parameters", cp.settable_params = 4567)

			c_set_settable_baud (cp.item, Sb_user | Sb_56000)
			assert ("Set/get settable baud", cp.settable_baud = Sb_user | Sb_56000)

			c_set_settable_data (cp.item, 6789)
			assert ("Set/get settable data", cp.settable_data = 6789)

			c_set_settable_stop_parity (cp.item, 1234)
			assert ("Set/get settable stop/parity", cp.settable_stop_and_parity = 1234)

			c_set_current_tx_queue (cp.item, 12345678)
			assert ("Set/get current tx queue", cp.current_tx_queue = 12345678)

			c_set_current_rx_queue (cp.item, 98765432)
			assert ("Set/get current rx queue", cp.current_rx_queue = 98765432)

			c_set_prov_spec1 (cp.item, 87654321)
			assert ("Set/get provider specific 1", cp.provider_specific1 = 87654321)

			c_set_prov_spec2 (cp.item, 642938)
			assert ("Set/get provider specific 2", cp.provider_specific2 = 642938)
		end

feature -- Access

	cp: COM_PROPERTIES is
			-- The test object
		once
			create Result.make
		end

feature {NONE} -- Externals

	c_set_packet_length (an_item: POINTER; a_value: INTEGER_16) is
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMPROP) $an_item)->wPacketLength = $a_value"
		end

	c_set_packet_version (an_item: POINTER; a_value: INTEGER_16) is
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMPROP) $an_item)->wPacketVersion = $a_value"
		end

	c_set_service_mask (an_item: POINTER; a_value: INTEGER) is
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMPROP) $an_item)->dwServiceMask = $a_value"
		end

	c_set_max_tx_queue (an_item: POINTER; a_value: INTEGER) is
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMPROP) $an_item)->dwMaxTxQueue = $a_value"
		end

	c_set_max_rx_queue (an_item: POINTER; a_value: INTEGER) is
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMPROP) $an_item)->dwMaxRxQueue = $a_value"
		end

	c_set_max_baud (an_item: POINTER; a_value: INTEGER) is
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMPROP) $an_item)->dwMaxBaud = $a_value"
		end

	c_set_prov_sub_type (an_item: POINTER; a_value: INTEGER) is
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMPROP) $an_item)->dwProvSubType = $a_value"
		end

	c_set_prov_capabilities (an_item: POINTER; a_value: INTEGER) is
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMPROP) $an_item)->dwProvCapabilities = $a_value"
		end

	c_set_settable_params (an_item: POINTER; a_value: INTEGER) is
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMPROP) $an_item)->dwSettableParams = $a_value"
		end

	c_set_settable_baud (an_item: POINTER; a_value: INTEGER) is
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMPROP) $an_item)->dwSettableBaud = $a_value"
		end

	c_set_settable_data (an_item: POINTER; a_value: INTEGER_16) is
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMPROP) $an_item)->wSettableData = $a_value"
		end

	c_set_settable_stop_parity (an_item: POINTER; a_value: INTEGER_16) is
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMPROP) $an_item)->wSettableStopParity = $a_value"
		end

	c_set_current_tx_queue (an_item: POINTER; a_value: INTEGER) is
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMPROP) $an_item)->dwCurrentTxQueue = $a_value"
		end

	c_set_current_rx_queue (an_item: POINTER; a_value: INTEGER) is
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMPROP) $an_item)->dwCurrentRxQueue = $a_value"
		end

	c_set_prov_spec1 (an_item: POINTER; a_value: INTEGER) is
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMPROP) $an_item)->dwProvSpec1 = $a_value"
		end

	c_set_prov_spec2 (an_item: POINTER; a_value: INTEGER) is
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMPROP) $an_item)->dwProvSpec2 = $a_value"
		end

end -- COM_TEST_COM_PROPERTIES
