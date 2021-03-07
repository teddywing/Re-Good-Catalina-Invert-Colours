#import <Carbon/Carbon.h>

#import "Invert.h"
#import "DDHotKeyCenter.h"

int main(int argc, const char * argv[]) {
    [NSAutoreleasePool new];

    [NSApplication sharedApplication];

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

    [NSApp run];

    return 0;
}
