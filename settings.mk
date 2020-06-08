# This variable controls the number of compilation processes
# within one package ("intra-package parallelism").
JOBS := 0
# This variable controls the targets that will build.
MXE_TARGETS := i686-w64-mingw32.shared
MXE_GCC_THREADS := posix
MXE_PLUGIN_DIRS := plugins/performous
# This variable controls the download mirror for SourceForge,
# when it is used. Enabling the value below means auto.
#SOURCEFORGE_MIRROR := downloads.sourceforge.net
# The three lines below makes `make` build these "local
# packages" instead of all packages.
LOCAL_PKG_LIST := gettext glm sdl2 boost portaudiodev ffmpeg portmidi pango gdk-pixbuf librsvg libsigc++ libxml++ libepoxy nsis fftw openblas opencv
.DEFAULT local-pkg-list:
local-pkg-list: $(LOCAL_PKG_LIST)