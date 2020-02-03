Serial Communications Library secom, version 0.9
Copyright Brian E. Heilig, 2005-2006 under the Eiffel Forum License, version 2
See license.txt for license details

****************
* INTRODUCTION *
****************

Thank you for your interest in the Serial Communications library secom. The aim
of secom is to provide you with a library of object-oriented components to
develop portable serial port applications. The two major goals to meet this
purpose are:

  Encapsulate the serial port APIs of Windows and Posix into a collection of
  classes.
  
  Ensure these classes conform to an interface that is common to both Posix and
  Windows operating systems.

The first goal simply states that a collection of classes is provided to make
developing serial port applications easier for you; it states nothing about
portability. The second goal states that applications that use the common
interface will be able to run on both Posix and Windows operating systems. This
is the strength of secom and what sets it above any other API: serial port
applications you develop will require minimal or no changes to be compiled and
executed across Posix and Windows platforms.

secom compiles with SmartEiffel 1.0, SmartEiffel 2.2 beta 1, and ISE Eiffel
version 5.5 and later. Visual Eiffel is not supported.

****************
* DEPENDENCIES *
****************

secom is dependent on the GOBO Eiffel library version 3.4 in that secom classes
inherit from GOBO classes, and the build process depends on GOBO tools. You can
download the GOBO Eiffel library from:

  http://www.gobosoft.com/eiffel/gobo/index.html


Please see the installation instructions provided with the GOBO package.

After installation you must set up some environment variables that are not well
documented in the GOBO documentation. These are :

GOBO_OS='windows' or 'unix'

You should also set the following environment variable (if you don't set it, it
will default to SmartEiffel).

GOBO_EIFFEL='se' or 'ise'

Option 've' for Visual Eiffel is not supported by secom

The documentation generation is done by a slightly modified version of EDOC.
EDOC was written by Julian Tschannen. The modification allows EDOC to know
about the GOBO_OS environment variable. If you have the release version of secom
then you already have the documentation. If you retrieved secom from the
sourceforge.net CVS repository then you might be able to retrieve EDOC from
Julian at juliant@student.ethz.ch. However, unless Julian took my advice you
will not see documentation for the posix or windows cluster.

In the future this library may also depend on ePosix.

****************
* INSTALLATION *
****************

Unpack the zip/tar.gz file into the directory of your choice. Set a SECOM
environment variable to the path where the secom directory is located (the
directory containing this file).

Windows XP example: set SECOM=C:\Eiffel\secom
Or right-click 'My Computer', select properties, Advanced tab, Environment
Variables to add the environment variable to all command prompt sessions.

Linux example: export SECOM=/usr/local/Eiffel/secom
Or add the preceding example to your .bashrc (or equivalent file) for all shell
prompts to include the environment variable.

If you have the released version of secom (zip or tar.gz file) then secom is
now ready to use. If you retrieved secom from the sourceforge.net CVS repository
then you will also need to install it. Change to the SECOM directory and type
the following command:

  geant install

The library is now ready to use. Please refer to the documentation contained in
the doc directory for details on how to use the library and information about
the classes.
