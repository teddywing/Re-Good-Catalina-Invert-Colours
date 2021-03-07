#import "Invert.h"

#define MAX_DISPLAYS 8

@implementation Invert

- (id)init
{
    self = [super init];
    if (self) {
        _inverted = NO;
    }
    return self;
}

- (void)toggleInvertColors:(NSEvent *)event
{
    NSLog(@"Toggling");

    if (!_inverted) {
        [self invertColors];

        _inverted = YES;
    }
    else {
        [self restoreColors];

        _inverted = NO;
    }
}

- (void)invertColors
{
    const CGGammaValue inverted_gamma[2] = {1, 0};

    CGDirectDisplayID active_displays[MAX_DISPLAYS];
    uint32_t display_count;

    CGError error = CGGetActiveDisplayList(
        MAX_DISPLAYS,
        &active_displays[0],
        &display_count
    );
    if (error != kCGErrorSuccess) {
        // return 69;
    }

    for (int i = 0; i < display_count; i++) {
        error = CGSetDisplayTransferByTable(
            active_displays[i],
            2,
            inverted_gamma,
            inverted_gamma,
            inverted_gamma
        );
        if (error != kCGErrorSuccess) {
            // TODO: error handling
        }
    }
}

- (void)restoreColors
{
    CGDisplayRestoreColorSyncSettings();
}

@end
