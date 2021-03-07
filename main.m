#import <Carbon/Carbon.h>

#include <sysexits.h>

#import "Invert.h"
#import "DDHotKeyCenter.h"

#define E_REGISTER_HOTKEY 5

int register_hotkeys();

int main(int argc, const char * argv[]) {
    [NSAutoreleasePool new];

    [NSApplication sharedApplication];

    int error_code = register_hotkeys();
    if (error_code == E_REGISTER_HOTKEY) {
        return EX_SOFTWARE;
    }

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
        NSLog(@"Error registering hotkey Apple+Option+Control-8");

        return E_REGISTER_HOTKEY;
    }

    if (
        ![c registerHotKeyWithKeyCode:kVK_F8
            modifierFlags:0
            target:invert
            action:@selector(toggleInvertColors:)
            object:nil]
    ) {
        NSLog(@"Error registering hotkey F8");

        return E_REGISTER_HOTKEY;
    }

    return 0;
}
