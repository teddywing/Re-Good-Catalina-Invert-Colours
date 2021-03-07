SOURCES := $(shell ls *.{h,m})

DDHOTKEY_OBJ := $(patsubst %.m,%.o,$(wildcard lib/DDHotKey/*.m))


all: $(SOURCES) build/libddhotkey.a build/include/*.h
	clang -x objective-c \
		-framework Carbon \
		-framework Cocoa \
		-framework CoreGraphics \
		-framework Foundation \
		-fno-objc-arc \
		-I./build/include \
		-L./build \
		-lddhotkey \
		-o invert-catalina-invert \
		$(SOURCES)

build/include/*.h: lib/DDHotKey/*.h
	cp $^ build/include/

lib/DDHotKey/%.o: lib/DDHotKey/%.m
	clang -x objective-c \
		-w \
		-framework Carbon \
		-framework Cocoa \
		-framework Foundation \
		-fobjc-arc \
		-c \
		$<

	mv *.o lib/DDHotKey/

build/libddhotkey.a: $(DDHOTKEY_OBJ)
	libtool -static \
		-o $@ \
		$^
