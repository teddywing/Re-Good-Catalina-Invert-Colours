// Copyright (c) 2021  Teddy Wing
//
// This file is part of Re-Good Catalina Invert Colours.
//
// Re-Good Catalina Invert Colours is free software: you can
// redistribute it and/or modify it under the terms of the GNU General
// Public License as published by the Free Software Foundation, either
// version 3 of the License, or (at your option) any later version.
//
// Re-Good Catalina Invert Colours is distributed in the hope that it
// will be useful, but WITHOUT ANY WARRANTY; without even the implied
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
// the GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Re-Good Catalina Invert Colours. If not, see
// <https://www.gnu.org/licenses/>.

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
