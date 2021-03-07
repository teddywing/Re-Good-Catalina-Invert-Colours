#import <Cocoa/Cocoa.h>
#import <CoreGraphics/CoreGraphics.h>

@interface Invert : NSObject {
    BOOL _inverted;
}

- (void)toggleInvertColors:(NSEvent *)event;

@end
