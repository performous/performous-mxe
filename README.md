# Performous plugins for MXE

This repository adds receipes for Performous to MXE using MXE's plugin system.
To build a Performous release, just add this directory to the MXE_PLUGIN_DIRS
variable while building MXE (you can add MXE_PLUGIN_DIRS to settings.mk).

Running

    make performous MXE_TARGETS=i686-w64-mingw32.shared

in the MXE directory and you should find a finished installer in
usr/i686-w64-mingw32.shared after the build is finished. Be aware that the
build is only tested with the i686-w64-mingw32.shared target.
