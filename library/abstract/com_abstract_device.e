note

	description:

		"Objects that perform I/O operations on a communications device."

	library: "Serial Communications Library"
	copyright: "Copyright (c) 2005, Brian E. Heilig"
	license: "Eiffel Forum License v2 (see license.txt)"
	date: "$Date: 2006/04/05 00:17:25 $"
	revision: "$Revision: 1.14 $"

deferred class
	COM_ABSTRACT_DEVICE

inherit

	EWG_IMPORTED_EXTERNAL_ROUTINES
		export {NONE} all end

	STRING_HANDLER
		export {NONE} all end

	KL_SHARED_PLATFORM
		export {NONE} all end

feature {NONE} -- Initialization

	make (a_name: STRING)
			-- Open the device `a_name'. Check `is_open' to
			-- ensure device opened correctly.
		require
			name_exists: a_name /= Void
		do
			create last_string.make (256)
			name := a_name.twin
			open
		ensure
			name_set: name /= Void and then name.is_equal (a_name)
		end

feature -- Access

	name: STRING
			-- Name of the communications device

	last_character: CHARACTER
			-- Last character read by the device.

	last_string: STRING
			-- Last string read by the device.

	last_integer: INTEGER
			-- Last integer read by the device

	last_real: REAL
			-- Last real read by the device

	last_double: DOUBLE
			-- Last double read by the device

	last_boolean: BOOLEAN
			-- Last Boolean read by the device

	last_read_count: INTEGER
			-- Number of bytes actually read during last read operation.

	last_write_count: INTEGER
			-- Number of bytes actually written during last write operation.

	control_settings: COM_ABSTRACT_SETTINGS
			-- Current control parameters for this device
		require
			handle_available: is_open
		deferred
		ensure
			exists: Result /= Void
		end

	timeouts: COM_ABSTRACT_TIMEOUTS
			-- Current timeout properties for this device
		require
			handle_available: is_open
		deferred
		ensure
			exists: Result /= Void
		end

feature -- Status report

	is_open: BOOLEAN
			-- Is the device open for reading and writing?
		deferred
		end

	timed_out: BOOLEAN
			-- Did the last read/write operation timeout?

feature -- Status setting

	close
			-- Close the device.
		deferred
		ensure
			closed:not is_open
			reset: last_read_count = 0 and last_write_count = 0
		end

	open
			-- Open the device. If open was successful set `is_open'.
		require
			closed: not is_open
		deferred
		end

feature -- Element change

	set_control_settings (a_settings: like control_settings)
			-- Configures the device according to the specifications in `a_settings'.
			-- Settings will be immediately applied; input and output queues will
			-- not be emptied.
		require
			exists: a_settings /= Void
			handle_available: is_open
		deferred
		ensure
			is_set: control_settings.is_equal (a_settings)
		end

	set_timeouts (a_timeouts: like timeouts)
			-- Configures the timeout properties according to `a_timeouts'
		require
			exists: a_timeouts /= Void
			handle_available: is_open
		deferred
		ensure
			timeouts_set: timeouts.is_equal (a_timeouts)
		end

feature -- Output

	put_character (c: CHARACTER)
			-- Write `c' to medium.
		require
			open: is_open
		do
			temp_character := c
			put_data ($temp_character, Platform.Character_bytes)
		ensure
			count: last_write_count = Platform.Character_bytes xor timed_out
		end

	put_integer (i: INTEGER)
			-- Write `i' to the device.
		require
			open: is_open
		do
			temp_integer := i
			put_data ($temp_integer, Platform.Integer_bytes)
		ensure
			count: last_write_count = Platform.Integer_bytes xor timed_out
		end

	put_boolean (b: BOOLEAN)
			-- Write `b' to the device.
		require
			open: is_open
		do
			temp_boolean := b
			put_data ($temp_boolean, Platform.Boolean_bytes)
		ensure
			count: last_write_count = Platform.Boolean_bytes xor timed_out
		end

	put_real (r: REAL)
			-- Write `r' to the device.
		require
			open: is_open
		do
			temp_real := r
			put_data ($temp_real, Platform.Real_bytes)
		ensure
			count: last_write_count = Platform.Real_bytes xor timed_out
		end

	put_double (d: DOUBLE)
			-- Write `d' to the device.
		require
			open: is_open
		do
			temp_double := d
			put_data ($temp_double, Platform.Double_bytes)
		ensure
			count: last_write_count = Platform.Double_bytes xor timed_out
		end

	put_stream (s: STRING; count: INTEGER)
			-- Write `count' bytes of `s' to medium.
		require
			open: is_open
			safe: count <= s.capacity
		local
			p: POINTER
		do
			p := external_string.string_to_pointer (s)
			put_data (p, count)
		ensure
			count: last_write_count = count xor timed_out
		end

	put_string (s: STRING)
			-- Write a null terminated string `s' to medium. All `count'
			-- characters of `s' will be written, followed by a null.
		require
			open: is_open
		local
			temp_count: INTEGER
		do
			put_stream (s, s.count)
			temp_count := last_write_count
			if not timed_out then
				put_character ('%U')
				last_write_count := last_write_count + temp_count
			end
		ensure
			count: last_write_count = s.count + Platform.Character_bytes xor timed_out
		end

	put_new_line
			-- Write a new line character to medium
		require
			open: is_open
		do
			put_character ('%N')
		ensure
			count: last_write_count = Platform.Character_bytes xor timed_out
		end

	put_data (data: POINTER; count: INTEGER)
			-- Write `data' to the device.  Set `last_write_count' with the
			-- number of bytes written. Set `timed_out' if the write operation
			-- timed out.
		require
			open: is_open
			valid_count: count > 0
		deferred
		ensure
			time_out: timed_out = (last_write_count < count)
			no_more: last_write_count <= count
		end

feature -- Input

	read_character
			-- Read a new character. Make result available in `last_character'.
		require
			open: is_open
		do
			read_data ($last_character, Platform.Character_bytes)
		ensure
			count: last_read_count = Platform.Character_bytes xor timed_out
		end

	read_integer
			-- Read a new integer. Make result available in `last_integer'.
		require
			open: is_open
		do
			read_data ($last_integer, Platform.Integer_bytes)
		ensure
			count: last_read_count = Platform.Integer_bytes xor timed_out
		end

	read_boolean
			-- Read a new Boolean. Make result available in `last_boolean'
		require
			open: is_open
		do
			read_data ($last_boolean, Platform.Boolean_bytes)
		ensure
			count: last_read_count = Platform.Boolean_bytes xor timed_out
		end

	read_real
			-- Read a new real. Make result available in `last_real'.
		require
			open: is_open
		do
			read_data ($last_real, Platform.Real_bytes)
		ensure
			count: last_read_count = Platform.Real_bytes xor timed_out
		end

	read_double
			-- Read a new double. Make result available in `last_double'.
		require
			open: is_open
		do
			read_data ($last_double, Platform.Double_bytes)
		ensure
			count: last_read_count = Platform.Double_bytes xor timed_out
		end

	read_stream (count: INTEGER)
			-- Read a string of `count' characters.
			-- Make result available in `last_string'.
		require
			open: is_open
			valid_count: count > 0
		local
			p: POINTER
		do
			last_string.resize (count)
			p := external_string.string_to_pointer(last_string)
			read_data (p, count)
			last_string.set_count (last_read_count)
		ensure
			count: last_read_count = count xor timed_out
		end

	read_string
			-- Read characters until a Nul character is received or
			-- a time out occurs. Make result available in
			-- `last_string'. Do not include the Nul character.
		require
			open: is_open
		local
			old_char: CHARACTER
		do
			from
				last_string.wipe_out
				old_char := last_character
				timed_out := False
				read_character
			until
				last_character = '%U' or timed_out
			loop
				last_string.extend (last_character)
				read_character
			end
			last_character := old_char
			last_read_count := last_string.count
			if not timed_out then
				last_read_count := last_read_count + 1
			end
		ensure
			count: last_string.count = last_read_count - 1 xor timed_out
			no_null: not last_string.has ('%U')
		end

	read_line
			-- Read characters until a new line is received or a time
			-- out occurs. Make result available in `last_string'.
		require
			open: is_open
		local
			old_char: CHARACTER
		do
			from
				last_string.wipe_out
				old_char := last_character
				timed_out := False
				last_character := ' '
			until
				last_character = '%N' or timed_out
			loop
				read_character
				if not timed_out then
					last_string.extend (last_character)
				end
			end
			last_character := old_char
			last_read_count := last_string.count
		ensure
			new_line_terminated_or_timeout:
				last_string.index_of ('%N', 1) = last_string.count xor timed_out
		end

	read_data (data: POINTER; count: INTEGER)
			-- Read `count' bytes into the `data' buffer.  Set `last_read_count'
			-- to the number of bytes read. Set `timed_out' if less than `count'
			-- bytes were read. See `timeouts' to determine when read will
			-- be completed.
		require
			open: is_open
			valid_count: count > 0
		deferred
		ensure
			time_out: timed_out = (last_read_count < count)
			no_more: last_read_count <= count
		end

feature {NONE} -- Implementation

	temp_boolean: BOOLEAN
	temp_character: CHARACTER
	temp_integer: INTEGER
	temp_real: REAL
	temp_double: DOUBLE
			-- Necessary because SmartEiffel does not allow the address of a local

invariant

	last_write_count_not_negative: last_write_count >= 0
	last_read_count_not_negative: last_read_count >= 0
	last_string_exists: last_string /= Void

end -- class COM_ABSTRACT_DEVICE
