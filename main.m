#import <Carbon/Carbon.h>

#import "Invert.h"
#import "DDHotKeyCenter.h"

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

    // for (;;) {}
    // sleep(4);

    // TODO: trap?
    // [invert release];

    [NSApp run];

    return 0;
}
