note

	description:
	
		"Information about a given communications driver."

	library: "Serial Communications Library"
	copyright: "Copyright (c) 2005, Brian E. Heilig"
	license: "Eiffel Forum License v2 (see license.txt)"
	date: "$Date: 2006/04/04 22:27:18 $"
	revision: "$Revision: 1.6 $"

class
	COM_PROPERTIES

inherit

	EWG_STRUCT

	KL_SHARED_EXCEPTIONS
		export {NONE} all end

	COM_SHARED_WINDOWS_ERROR
		export {NONE} all end

create
	make, make_existing

feature {NONE} -- Initialization

	make
			-- Create an un-initialized comm properties structure.
		do
			make_new_unshared
		ensure
			exists: exists
			not_shared: not is_shared
		end

	make_existing (comm: COM_DEVICE)
			-- Create this structure from an extant, open communications device.
			-- Throws an exception if call to `GetCommProperties' fails.
		require
			exists: comm /= Void
			handle_available: comm.is_open
		do
			make_new_unshared
			get_comm_properties (comm)
		ensure
			exists: exists
			not_shared: not is_shared
		end

feature -- Access

	packet_length: INTEGER_16
			-- Size of the entire data packet, regardless of the amount
			-- of data requested, in bytes.
		do
			Result := c_get_packet_length (item)
		end

	packet_version: INTEGER_16
			-- Version of the structure.
		do
			Result := c_get_packet_version (item)
		end

	service_mask: INTEGER
			-- Bit mask indicating which services are implemented by this provider.
			-- Sp_serial_comm is always specified for communications providers,
			-- including modem providers.
		do
			Result := c_get_service_mask (item)
		end

	max_tx_queue: INTEGER
			-- Maximum size of the driver's internal output buffer, in bytes. A value
			-- of zero indicates that no maximum value is imposed by the serial provider.
		do
			Result := c_get_max_tx_queue (item)
		end

	max_rx_queue: INTEGER
			-- Maximum size of the driver's internal input buffer, in bytes. A value of
			-- zero indicates that no maximum value is imposed by the serial provider. 
		do
			Result := c_get_max_rx_queue (item)
		end

	max_baud: INTEGER
			-- Maximum allowable baud rate. See selectable baud rates in COM_PROP_CONSTANTS
			-- for possible values.
		do
			Result := c_get_max_baud (item)
		end

	provider_sub_type: INTEGER
			-- Communications-provider type. See provider sub types in COM_PROP_CONSTANTS
			-- for possible values.
		do
			Result := c_get_prov_sub_type (item)
		end

	provider_capabilities: INTEGER
			-- Capabilities offered by the provider. See provider capabilities in
			-- COM_PROP_CONSTANTS for possible values.
		do
			Result := c_get_prov_capabilities (item)
		end

	settable_params: INTEGER
			-- Communications parameters that can be changed. See settable parameters in
			-- COM_PROP_CONSTANTS for possible values.
		do
			Result := c_get_settable_params (item)
		end

	settable_baud: INTEGER
			-- A bit mask of baud rates that can be used. See selectable baud rates in 
			-- COM_PROP_CONSTANTS for possible values.
		do
			Result := c_get_settable_baud (item)
		end

	settable_data: INTEGER_16
			-- Bit mask of possible settings for data word size. See selectable data bits in
			-- COM_PROP_CONSTANTS for possible values.
		do
			Result := c_get_settable_data (item)
		end

	settable_stop_and_parity: INTEGER_16
			-- Stop bit and parity settings that can be selected. See selectable stop bits and
			-- selectable parity scheme in COM_PROP_CONSTANTS for possible values.
		do
			Result := c_get_settable_stop_parity (item)
		end

	current_tx_queue: INTEGER
			-- Size of the driver's internal output buffer, in bytes.
			-- A value of zero indicates that the value is unavailable.
		do
			Result := c_get_current_tx_queue (item)
		end

	current_rx_queue: INTEGER
			-- Size of the driver's internal input buffer, in bytes.
			-- A value of zero indicates that the value is unavailable. 
		do
			Result := c_get_current_rx_queue (item)
		end

	provider_specific1: INTEGER
			-- Provider-specific data. Clients should ignore this member
			-- unless they have detailed information about the format of
			-- the data required by the provider.
		do
			Result := c_get_prov_spec1 (item)
		end

	provider_specific2: INTEGER
			-- Provider-specific data. Clients should ignore this member
			-- unless they have detailed information about the format of
			-- the data required by the provider.
		do
			Result := c_get_prov_spec2 (item)
		end

feature -- Element change

	get_comm_properties (comm: COM_DEVICE)
			-- Fill this structure with `comm's most recent properties.
			-- Throws an exception if call to get comm properties fails.
		require
			exists: comm /= Void
			handle_available: comm.is_open
		do
			if not cwin_get_comm_properties (comm.handle, item) then
				Exceptions.raise (get_properties_error(comm.name))
			end
		end

feature {NONE} -- Error

	get_properties_error (device_name: STRING): STRING
			-- An error message indicating a failure to retrieve the
			-- properties of `device_name'
		require
			device_name_exists: device_name /= Void
		do
			Result := "Failed to obtain the properties of device "
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
			"sizeof (struct _COMMPROP)"
		end

feature {NONE} -- Externals

	cwin_get_comm_properties (hFile: POINTER; lpCommProp: POINTER): BOOLEAN
		external
			"C use <windows.h>"
		alias
			"GetCommProperties"
		end

	c_get_packet_length (an_item: POINTER): INTEGER_16
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMPROP) $an_item)->wPacketLength"
		end

	c_get_packet_version (an_item: POINTER): INTEGER_16
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMPROP) $an_item)->wPacketVersion"
		end

	c_get_service_mask (an_item: POINTER): INTEGER
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMPROP) $an_item)->dwServiceMask"
		end

	c_get_max_tx_queue (an_item: POINTER): INTEGER
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMPROP) $an_item)->dwMaxTxQueue"
		end

	c_get_max_rx_queue (an_item: POINTER): INTEGER
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMPROP) $an_item)->dwMaxRxQueue"
		end

	c_get_max_baud (an_item: POINTER): INTEGER
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMPROP) $an_item)->dwMaxBaud"
		end

	c_get_prov_sub_type (an_item: POINTER): INTEGER
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMPROP) $an_item)->dwProvSubType"
		end

	c_get_prov_capabilities (an_item: POINTER): INTEGER
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMPROP) $an_item)->dwProvCapabilities"
		end

	c_get_settable_params (an_item: POINTER): INTEGER
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMPROP) $an_item)->dwSettableParams"
		end

	c_get_settable_baud (an_item: POINTER): INTEGER
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMPROP) $an_item)->dwSettableBaud"
		end

	c_get_settable_data (an_item: POINTER): INTEGER_16
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMPROP) $an_item)->wSettableData"
		end

	c_get_settable_stop_parity (an_item: POINTER): INTEGER_16
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMPROP) $an_item)->wSettableStopParity"
		end

	c_get_current_tx_queue (an_item: POINTER): INTEGER
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMPROP) $an_item)->dwCurrentTxQueue"
		end

	c_get_current_rx_queue (an_item: POINTER): INTEGER
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMPROP) $an_item)->dwCurrentRxQueue"
		end

	c_get_prov_spec1 (an_item: POINTER): INTEGER
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMPROP) $an_item)->dwProvSpec1"
		end

	c_get_prov_spec2 (an_item: POINTER): INTEGER
		external
			"C inline use <windows.h>"
		alias
			"((LPCOMMPROP) $an_item)->dwProvSpec2"
		end

end -- class COM_PROPERTIES
