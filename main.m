#import <Carbon/Carbon.h>
#import <CoreGraphics/CoreGraphics.h>

#import "Invert.h"
#import "DDHotKeyCenter.h"

#define MAX_DISPLAYS 8

int main(int argc, const char * argv[]) {
    [NSApplication sharedApplication];

    Invert *invert = [[Invert alloc] init];

    DDHotKeyCenter *c = [DDHotKeyCenter sharedHotKeyCenter];
    if (
        ![c registerHotKeyWithKeyCode:kVK_ANSI_8
            modifierFlags:
                (NSEventModifierFlagControl | NSEventModifierFlagOption | NSEventModifierFlagCommand)
            target:invert
            action:@selector(toggleInvertColors:)
            object:nil]
    ) {
        NSLog(@"Error registering hotkey");
    }

    const CGGammaValue inverted_gamma[2] = {1, 0};

    CGDirectDisplayID active_displays[MAX_DISPLAYS];
    uint32_t display_count;

    CGError error = CGGetActiveDisplayList(
        MAX_DISPLAYS,
        &active_displays[0],
        &display_count
    );
    if (error != kCGErrorSuccess) {
        return 69;
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

    // for (;;) {}
    // sleep(4);
    //
    // CGDisplayRestoreColorSyncSettings();

    // TODO: trap?
    // [invert release];

    [NSApp run];

    return 0;
}
