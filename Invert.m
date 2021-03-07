#import "Invert.h"

#define MAX_DISPLAYS 8

static const CGGammaValue INVERTED_GAMMA[2] = {1, 0};

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
    CGDirectDisplayID active_displays[MAX_DISPLAYS];
    uint32_t display_count;

    CGError error = CGGetActiveDisplayList(
        MAX_DISPLAYS,
        &active_displays[0],
        &display_count
    );
    if (error != kCGErrorSuccess) {
        NSLog(@"Error getting active displays: %d", error);
    }

    for (int i = 0; i < display_count; i++) {
        error = CGSetDisplayTransferByTable(
            active_displays[i],
            2,
            INVERTED_GAMMA,
            INVERTED_GAMMA,
            INVERTED_GAMMA
        );
        if (error != kCGErrorSuccess) {
            NSLog(
                @"Error inverting display '%d': %d",
                active_displays[i],
                error
            );
        }
    }
}

- (void)restoreColors
{
    CGDisplayRestoreColorSyncSettings();
}

@end
