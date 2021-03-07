# Copyright (c) 2021  Teddy Wing
#
# This file is part of Re-Good Catalina Invert Colours.
#
# Re-Good Catalina Invert Colours is free software: you can
# redistribute it and/or modify it under the terms of the GNU General
# Public License as published by the Free Software Foundation, either
# version 3 of the License, or (at your option) any later version.
#
# Re-Good Catalina Invert Colours is distributed in the hope that it
# will be useful, but WITHOUT ANY WARRANTY; without even the implied
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
# the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Re-Good Catalina Invert Colours. If not, see
# <https://www.gnu.org/licenses/>.

SOURCES := $(shell ls *.{h,m})

DDHOTKEY_OBJ := $(patsubst %.m,%.o,$(wildcard lib/DDHotKey/*.m))

BUILD_DIR := $(abspath build)
LOCAL_INCLUDE_DIR := $(BUILD_DIR)/include

RELEASE_PRODUCT := invert-catalina-invert
LAUNCHD_PLIST := Library/LaunchAgents/com.teddywing.invert-catalina-invert.plist
VERSION := $(shell awk -F '"' '/static const char \*VERSION/ { print $$2 }' main.m)

DIST := $(abspath dist)
DIST_PRODUCT := $(DIST)/bin/$(RELEASE_PRODUCT)
DIST_LAUNCHD_PLIST := $(DIST)/$(LAUNCHD_PLIST)


.PHONY: all
all: $(RELEASE_PRODUCT)

$(RELEASE_PRODUCT): $(SOURCES) build/libddhotkey.a build/include/*.h
	clang -x objective-c \
		-mmacosx-version-min=10.7 \
		-framework Carbon \
		-framework Cocoa \
		-framework CoreGraphics \
		-framework CoreServices \
		-framework Foundation \
		-fno-objc-arc \
		-I./build/include \
		-L./build \
		-lddhotkey \
		-o invert-catalina-invert \
		$(SOURCES)

build/include/%.h: lib/DDHotKey/%.h | $(LOCAL_INCLUDE_DIR)
	cp $^ build/include/

lib/DDHotKey/%.o: lib/DDHotKey/%.m
	clang -x objective-c \
		-mmacosx-version-min=10.7 \
		-fobjc-arc \
		-c \
		$<

	mv *.o lib/DDHotKey/

build/libddhotkey.a: $(DDHOTKEY_OBJ) | $(BUILD_DIR)
	libtool -static \
		-o $@ \
		$^

$(BUILD_DIR):
	mkdir -p $@

$(LOCAL_INCLUDE_DIR): | $(BUILD_DIR)
	mkdir -p $@


.PHONY: clean
clean:
	rm -rf $(RELEASE_PRODUCT) \
		$(BUILD_DIR) \
		$(DDHOTKEY_OBJ) \
		$(DIST)


.PHONY: dist
dist: $(DIST_PRODUCT) $(DIST_LAUNCHD_PLIST)

$(DIST):
	mkdir -p $@

$(DIST)/bin: | $(DIST)
	mkdir -p $@

$(DIST)/Library/LaunchAgents: | $(DIST)
	mkdir -p $@

$(DIST_PRODUCT): $(DIST)/bin $(RELEASE_PRODUCT)
	cp $(RELEASE_PRODUCT) $<

$(DIST_LAUNCHD_PLIST): $(DIST)/Library/LaunchAgents $(LAUNCHD_PLIST)
	cp $(LAUNCHD_PLIST) $<


.PHONY: pkg
pkg: invert-catalina-invert_$(VERSION)_x86_64.tar.bz2

invert-catalina-invert_$(VERSION)_x86_64.tar.bz2: dist
	tar cjv -s /dist/invert-catalina-invert_$(VERSION)_x86_64/ -f $@ dist
