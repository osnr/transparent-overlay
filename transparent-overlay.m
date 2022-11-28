#import <Cocoa/Cocoa.h>

@interface TransparentOverlayWindowView: NSView
- (void)drawStuff;
@end

@implementation TransparentOverlayWindowView
- (void)drawStuff {
    [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];

    [[NSColor clearColor] set];
    NSRectFill([self bounds]);

    CGContextRef context = [NSGraphicsContext currentContext].CGContext;
    
    [[NSColor redColor] set];
    [NSBezierPath fillRect:NSMakeRect(10, 20, 200, 200)];
}
@end

@interface TransparentOverlayApplication: NSApplication
@end
@implementation TransparentOverlayApplication
@end

NSWindow* overlayWindow;
TransparentOverlayWindowView* overlayWindowView;

int main() {
    @autoreleasepool {
        [TransparentOverlayApplication sharedApplication];
        [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];

        NSRect contentFrame = [[NSScreen mainScreen] frame];
        overlayWindow = [[NSWindow alloc]
                              initWithContentRect:contentFrame
                              styleMask:0
                              backing:NSBackingStoreBuffered
                              defer:NO];
        overlayWindow.backgroundColor = NSColor.clearColor;
        overlayWindowView = [[TransparentOverlayWindowView alloc] init];
        [overlayWindow setContentView:overlayWindowView];
        overlayWindow.hasShadow = NO;
        [overlayWindow setOpaque:NO];
        [overlayWindow orderFront:nil];
        overlayWindow.level = CGWindowLevelForKey(kCGMaximumWindowLevelKey);

        [NSApp run];
    }
    return 0;
}
