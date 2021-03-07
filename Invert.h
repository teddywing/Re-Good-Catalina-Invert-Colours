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

#import <Cocoa/Cocoa.h>
#import <CoreGraphics/CoreGraphics.h>

@interface Invert : NSObject {
    BOOL _inverted;
}

- (void)toggleInvertColors:(NSEvent *)event;

@end
