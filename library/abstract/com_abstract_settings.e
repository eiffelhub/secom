note

	description:

		"Control settings for an abstract serial communications device. Settings %
		%will not be applied until you call `set_control_settings' on the device."

	library: "Serial Communications Library"
	copyright: "Copyright (c) 2005, Brian E. Heilig"
	license: "Eiffel Forum License v2 (see license.txt)"
	date: "$Date: 2006/03/26 05:07:51 $"
	revision: "$Revision: 1.17 $"

deferred class

	COM_ABSTRACT_SETTINGS

inherit

	ANY
		redefine is_equal end

feature -- Access

	baud_rate: INTEGER
			-- Device baud rate
		deferred
		end

	data_bits: INTEGER
			-- Number of bits per data word
		deferred
		end

	parity: INTEGER
			-- Parity scheme in use for received and transmitted data
		deferred
		end

	stop_bits: INTEGER
			-- Number of stop bits per data word
		deferred
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered equal
			-- to current object?
		do
			Result := baud_rate = other.baud_rate and
				parity = other.parity and
				stop_bits = other.stop_bits and
				data_bits = other.data_bits
		ensure then
			definition: Result implies (
				baud_rate = other.baud_rate and
				parity = other.parity and
				stop_bits = other.stop_bits and
				data_bits = other.data_bits)
		end

feature -- Status report

	is_parity_checked: BOOLEAN
			-- Check receive data for parity errors?
		deferred
		end

	is_valid_baud (a_baud: INTEGER): BOOLEAN
			-- Is `a_baud' a valid baud rate? True only indicates the
			-- operating system supports this rate. The device may not.
		deferred
		end

	is_valid_parity (a_parity: INTEGER): BOOLEAN
			-- Is `a_parity' a valid parity setting?
		deferred
		end

	is_valid_stop_bits (a_stop_bit: INTEGER): BOOLEAN
			-- Is `a_stop_bit' a valid stop bits setting?
		deferred
		end

	is_valid_data_bits (a_data_bits: INTEGER): BOOLEAN
			-- Is `a_data_bits' a valid data bits setting?
		deferred
		end

feature -- Status setting

	set_parity_check (a_value: BOOLEAN)
			-- Set `is_parity_checked' to `a_value'
		deferred
		ensure
			parity_check_set: is_parity_checked = a_value
		end

feature -- Element Change

	fill_from_device (dev: COM_ABSTRACT_DEVICE)
			-- Initialize this object with settings from `dev'.
		require
			exists: dev /= Void
			handle_available: dev.is_open
		deferred
		ensure
			equal: dev.control_settings.is_equal (Current)
		end

	set_baud_rate (a_baud_rate: INTEGER)
			-- Set `baud_rate' with `a_baud_rate'
		require
			valid: is_valid_baud (a_baud_rate)
		deferred
		ensure
			baud_rate_set: baud_rate = a_baud_rate
		end

	set_parity (a_parity: INTEGER)
			-- Set `parity' to `a_parity'
		require
			valid: is_valid_parity (a_parity)
		deferred
		ensure
			parity_set: parity = a_parity
		end

	set_stop_bits (a_stop_bits: INTEGER)
			-- Set `stop_bits' to `a_stop_bits'
		require
			valid: is_valid_stop_bits (a_stop_bits)
		deferred
		ensure
			stop_bits_set: stop_bits = a_stop_bits
		end

	set_data_bits (a_data_bits: INTEGER)
			-- Set `data_bits' to `a_data_bits'
		require
			valid: is_valid_data_bits (a_data_bits)
		deferred
		ensure
			data_bits_set: data_bits = a_data_bits
		end

	set_defaults
			-- Change all settings to default values.
			-- Useful to remove any esoteric settings
			-- that might be effecting communication
		deferred
		end

feature -- Conversion

	to_baud_rate (a_baud_rate: INTEGER): INTEGER
			-- Converts `a_baud_rate' in symbols per second
			-- to a baud rate setting
		deferred
		end

	to_parity (a_parity_char: CHARACTER): INTEGER
			-- Converts `a_parity_char' to a parity setting
		deferred
		end

	to_stop_bits (a_stop_bits: INTEGER): INTEGER
			-- Converts `a_stop_bits' in number of stop bits to a stop bits setting
		deferred
		end

	to_data_bits (a_data_bits: INTEGER): INTEGER
			-- Converts `a_data_bits' in number of data bits to a data bits setting
		deferred
		end

end -- class COM_ABSTRACT_SETTINGS
