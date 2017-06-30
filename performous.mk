PKG             := performous
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.1
$(PKG)_CHECKSUM := 17d47da4092ffa0dc2087f69b8b9d4f920aa7d16ee80020bb5445f95d22b6a71
$(PKG)_DEPS     := gettext sdl2 boost portaudio ffmpeg portmidi pango gdk-pixbuf librsvg libsigc++ libxml++ opencv libepoxy nsis cpp-netlib jsoncpp

define $(PKG)_BUILD
    mkdir '$(1)/build'
    cd '$(1)/build' && '$(TARGET)-cmake' -DCMAKE_INSTALL_PREFIX="$(1)/stage" "./../../../../../"
    $(MAKE) -C '$(1)/build' -j '$(JOBS)' install
    '$(TOP_DIR)/tools/copydlldeps.sh' --infile "$(1)/stage/Performous.exe" --destdir "$(1)/stage" --recursivesrcdir "$(PREFIX)/$(TARGET)" --copy --objdump "$(TARGET)-objdump"
    $(TARGET)-strip "$(1)/stage/"*.dll "$(1)/stage/"*.exe
    cd '$(1)' && MAKENSIS=$(TARGET)-makensis WINDRES=$(TARGET)-windres "./../../../make-installer.py"
    $(INSTALL) -m644 '$(1)/dist/'*.exe '$(PREFIX)/$(TARGET)/'
endef
