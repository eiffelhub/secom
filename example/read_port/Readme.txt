description: "Readme file for the read_port example."
copyright: "Copyright (c) 2005, Brian E. Heilig"
license: "Eiffel Forum License v2 (see license.txt)"
date: "$Date: 2006/03/26 05:07:50 $"
revision: "$Revision: 1.3 $"

The read_port example reads lines of data from the serial port
and prints them to stdout. To execute the program on Windows type:

read_port --device=COM1

Or on Posix type:

read_port --device=/dev/ttyS0

Or replace the device name with the appropriate device.
This will read from COM1 or ttyS0. The program is exited
by typing Ctrl-c.

The default device settings are

--baud=57600
--parity=none
--data=8
--stop=1

You can override these with your own settings. For example:

read_port --baud=9600 --parity=odd --device=/dev/ttyS1
