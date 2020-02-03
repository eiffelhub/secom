description: "Readme file for the write_port example."
copyright: "Copyright (c) 2005, Brian E. Heilig"
license: "Eiffel Forum License v2 (see license.txt)"
date: "$Date: 2006/03/26 05:07:50 $"
revision: "$Revision: 1.3 $"

The write_port example writes lines of data to the serial port.
To execute the program on Windows type:

write_port --device=COM1 data1 data2 ...

Or on Posix type:

write_port --device=/dev/ttyS0 data1 data2 ...

Or replace the device name with the appropriate device.
This will write data1%N data2%N etc to the device.

The default device settings are

--baud=57600
--parity=none
--data=8
--stop=1

You can override these with your own settings. For example:

write_port --baud=9600 --parity=odd --device=/dev/ttyS1 data1 data2
