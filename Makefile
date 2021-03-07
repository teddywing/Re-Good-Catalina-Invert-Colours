SOURCES := $(shell ls *.{h,m})

DDHOTKEY_OBJ := $(patsubst %.m,%.o,$(wildcard lib/DDHotKey/*.m))

BUILD_DIR := $(abspath build)
LOCAL_INCLUDE_DIR := $(BUILD_DIR)/include

RELEASE_PRODUCT := invert-catalina-invert


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
