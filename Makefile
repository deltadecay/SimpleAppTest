TARGETAPP=SimpleAppTest

build:
	mkdir -p build
	clang -g -o build/$(TARGETAPP) main.m -lobjc -framework Foundation -framework AppKit -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk


bundle: build
	mkdir -p $(TARGETAPP).app/Contents/MacOS
	cp build/$(TARGETAPP) $(TARGETAPP).app/Contents/MacOS
	cp Info.plist $(TARGETAPP).app/Contents/MacOS


all: clean build bundle

clean:
	rm -rf build

