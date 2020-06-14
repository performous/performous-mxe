PKG             := performous
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.1+
$(PKG)_CHECKSUM := 17d47da4092ffa0dc2087f69b8b9d4f920aa7d16ee80020bb5445f95d22b6a71
$(PKG)_DEPS     := gettext glm sdl2 boost portaudiodev ffmpeg portmidi pango gdk-pixbuf librsvg libsigc++ libxml++ libepoxy nsis fftw openblas opencv

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' \
    -DCMAKE_INSTALL_PREFIX="$(BUILD_DIR)/stage" \
    -DENABLE_WEBSERVER=ON \
    -DENABLE_WEBCAM=ON \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
    -DCMAKE_VERBOSE_MAKEFILE=ON \
    -DCMAKE_BUILD_TYPE="$(if $(DEBUG),Debug,Release)" \
    -DCMAKE_C_FLAGS_DEBUG="-g -Og -Wa,-mbig-obj" \
    -DCMAKE_CXX_FLAGS_DEBUG="-g -Og -Wa,-mbig-obj" \
    -DCMAKE_C_FLAGS_RELEASE="-DNDEBUG -O3" \
    -DCMAKE_CXX_FLAGS_RELEASE="-DNDEBUG -O3" \
    "$(if $(PERFORMOUS_SOURCE),$(PERFORMOUS_SOURCE),$(HOME)/performous)"
    $(MAKE) -C '$(BUILD_DIR)' JOBS=$(JOBS) --jobs=$(JOBS) install
    '$(TOP_DIR)/tools/copydlldeps.sh' --indir "$(BUILD_DIR)/stage" --destdir "$(BUILD_DIR)/stage" --recursivesrcdir "$(PREFIX)/$(TARGET)" --copy --objdump "$(TARGET)-objdump"
    $(if $(DEBUG),,./usr/bin/$(TARGET)-strip "$(BUILD_DIR)/stage/"*.dll "$(BUILD_DIR)/stage/"*.exe)
    cd '$(BUILD_DIR)' && MAKENSIS=$(TARGET)-makensis WINDRES=$(TARGET)-windres "$(if $(PERFORMOUS_SOURCE),$(PERFORMOUS_SOURCE),$(HOME)/performous)/win32/mxe/make-installer.py"
    $(if $(DEBUG),INSTALLER_FILE="$(shell basename $$(ls '$(BUILD_DIR)/dist/Performous'*.exe))" && \
    mv "$(BUILD_DIR)/dist/$${INSTALLER_FILE}" "$(BUILD_DIR)/dist/$${INSTALLER_FILE%.exe}-DEBUG.exe")
    $(INSTALL) -m644 '$(BUILD_DIR)/dist/'*.exe '$(PREFIX)/$(TARGET)/'    
endef
