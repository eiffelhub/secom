note

	description:

		"Read timeout settings for an abstract serial communications device. %
		%Settings will not be applied until you call `set_timeouts' on the device."

	library: "Serial Communications Library"
	copyright: "Copyright (c) 2005, Brian E. Heilig"
	license: "Eiffel Forum License v2 (see license.txt)"
	date: "$Date: 2006/03/26 05:07:51 $"
	revision: "$Revision: 1.8 $"

deferred class

	COM_ABSTRACT_TIMEOUTS

inherit

	ANY
		redefine is_equal end

feature -- Access

	overall_timer: INTEGER
			-- Total read timer, in milliseconds.
		deferred
		end

	inter_character_timer: INTEGER
			-- Inter-character read timer, in milliseconds.
		deferred
		end

feature -- Status report

	is_blocking: BOOLEAN
			-- Indicates read operations block until the requested
			-- number of bytes have been read.
		deferred
		ensure
			not_non_blocking: Result implies not is_non_blocking
			no_inter_character_timer: Result implies not has_inter_character_timer
			no_overall_timer: Result implies not has_overall_timer
		end

	is_non_blocking: BOOLEAN
			-- Indicates read operations return immediately with the number of
			-- bytes already received, even if no bytes have been received.
		deferred
		ensure
			not_blocking: Result implies not is_blocking
			no_inter_character_timer: Result implies not has_inter_character_timer
			no_overall_timer: Result implies not has_overall_timer
		end

	has_overall_timer: BOOLEAN
			-- Indicates read operations return when either the
			-- requested number of bytes have been received, or when
			-- `overall_timer' milliseconds have elapsed.
			-- Can be combined with an inter-character timer.
		do
			Result := overall_timer > 0
		ensure
			definition: Result = (overall_timer > 0)
			not_non_blocking: Result implies not is_non_blocking
			not_blocking: Result implies not is_blocking
		end

	has_inter_character_timer: BOOLEAN
			-- Indicates read operations return when either the
			-- requested number of bytes have been received, or when
			-- `inter_character_timer' milliseconds have elapsed between
			-- successive characters. At least one character must be
			-- received to satisfy a read operation.
			-- Can be combined with an overall timer.
		do
			Result := inter_character_timer > 0
		ensure
			definition: Result = (inter_character_timer > 0)
			not_non_blocking: Result implies not is_non_blocking
			not_blocking: Result implies not is_blocking
		end

feature -- Element Change

	set_blocking
			-- Set the timeout properties to be a pure blocking read.
		deferred
		ensure
			is_blocking: is_blocking
		end

	set_non_blocking
			-- Set the timeout properties to be a non-blocking read.
		deferred
		ensure
			is_non_blocking: is_non_blocking
		end

	set_overall_timer (time: INTEGER)
			-- Set the timeout properties to be an overall timed read. The timer
			-- may be altered to meet operating system constraints.
			-- Set the timer to 0 to indicate the timer is not used.
		require
			valid_time: time >= 0 and time <= 2147483
		deferred
		ensure
			timer_cleared: time = 0 implies not has_overall_timer
		end

	set_inter_character_timer (time: INTEGER)
			-- Set the timeout properties to be an inter-character timed read.
			-- The timer may be altered to meet operating system constraints.
			-- Set the timer to 0 to indicate the timer is not used.
		require
			valid_time: time >= 0 and time <= 25500
		deferred
		ensure
			timer_cleared: time = 0 implies not has_inter_character_timer
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered equal
			-- to current object?
		do
			Result :=
				overall_timer = other.overall_timer and
				inter_character_timer = other.inter_character_timer and
				is_blocking = other.is_blocking and
				is_non_blocking = other.is_non_blocking
		ensure then
			definition: Result implies (
				overall_timer = other.overall_timer and
				inter_character_timer = other.inter_character_timer and
				is_blocking = other.is_blocking and
				is_non_blocking = other.is_non_blocking)
		end

end -- class COM_ABSTRACT_TIMEOUTS
