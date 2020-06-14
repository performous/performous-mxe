# Performous-mxe
This repo contains the recipe needed for making a windows release of Performous by crosscompiling through MXE. It has currently been tested to work in Linux and macOS hosts.

You need MXE (Check Lord-Kamina's performous branch on his fork); the `settings.mk`from this repo goes in the main mxe folder, and both the `performous-1-fixes.patch` and `performous.mk`go in plugins/performous under mxe.

Once you're set-up, you just run `make performous`

Of note, the recipe by default expects performous to be located in `~/`(your home directory), if that is not the case, append `PERFORMOUS_SOURCE="path/to/performous/source"` to the make command. Additionally, it's possible to create an executable with gdb-compatible debug symbols by adding `DEBUG=1`to the make command.

Both 32-bit and 64-bit builds are supported, you can find how to produce each one in the mxe documentation.
