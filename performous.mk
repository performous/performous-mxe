PKG             := performous
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.1+
$(PKG)_CHECKSUM := 17d47da4092ffa0dc2087f69b8b9d4f920aa7d16ee80020bb5445f95d22b6a71
$(PKG)_DEPS     := gettext glm sdl2 boost portaudiodev ffmpeg portmidi pango gdk-pixbuf librsvg libsigc++ libxml++ libepoxy nsis fftw openblas opencv

define $(PKG)_BUILD
    mkdir '$(1)/build'
    cd '$(1)/build' && '$(TARGET)-cmake' -DCMAKE_INSTALL_PREFIX="$(1)/stage" -DENABLE_WEBSERVER=ON -DENABLE_WEBCAM=ON -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_VERBOSE_MAKEFILE=ON "$(if $(PERFORMOUS_SOURCE),$(PERFORMOUS_SOURCE),$(HOME)/performous)"
    $(MAKE) -C '$(1)/build' JOBS=$(JOBS) --jobs=$(JOBS) install
    '$(TOP_DIR)/tools/copydlldeps.sh' --indir "$(1)stage" --destdir "$(1)stage" --recursivesrcdir "$(PREFIX)/$(TARGET)" --copy --objdump "$(TARGET)-objdump"
    ./usr/bin/$(TARGET)-strip "$(1)stage/"*.dll "$(1)stage/"*.exe
    cd '$(1)' && MAKENSIS=$(TARGET)-makensis WINDRES=$(TARGET)-windres "$(if $(PERFORMOUS_SOURCE),$(PERFORMOUS_SOURCE),$(HOME)/performous)/win32/mxe/make-installer.py"
    $(INSTALL) -m644 '$(1)dist/'*.exe '$(PREFIX)/$(TARGET)/'
endef
