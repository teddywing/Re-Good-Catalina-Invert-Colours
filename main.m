#import <Carbon/Carbon.h>

#import "Invert.h"
#import "DDHotKeyCenter.h"

int register_hotkeys();

int main(int argc, const char * argv[]) {
    [NSAutoreleasePool new];

    [NSApplication sharedApplication];

    int error_code = register_hotkeys();

    [NSApp run];

    return 0;
}

int register_hotkeys() {
    Invert *invert = [[[Invert alloc] init] autorelease];

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

    if (
        ![c registerHotKeyWithKeyCode:kVK_F8
            modifierFlags:0
            target:invert
            action:@selector(toggleInvertColors:)
            object:nil]
    ) {
        NSLog(@"Error registering hotkey");
    }

    return 0;
}
