transparent-overlay: transparent-overlay.m
	cc -fobjc-arc -framework Cocoa -x objective-c -o $@ $^

clean:
	rm -f transparent-overlay
