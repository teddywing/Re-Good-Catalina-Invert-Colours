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
