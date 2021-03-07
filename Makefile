# SOURCES := $(shell find . -not -path './lib/*' -and \( -name '*.h' -or -name '*.m' \))
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

# build/libddhotkey.o: lib/DDHotKey/*.h lib/DDHotKey/*.m
lib/DDHotKey/%.o: lib/DDHotKey/%.m
	clang -x objective-c \
		-w \
		-framework Carbon \
		-framework Cocoa \
		-framework Foundation \
		-fobjc-arc \
		-c \
		$^

	mv *.o lib/DDHotKey/

lib/DDHotKey/*.o: lib/DDHotKey/*.m

build/libddhotkey.a: $(DDHOTKEY_OBJ)
# build/libddhotkey.a: lib/DDHotKey/*.o
	libtool -static \
		-o $@ \
		$^
