Re-Good Catalina Invert Colours
===============================

On Mac OS X 10.15 Catalina (or perhaps in 10.14 or 10.13), inverting display
colours broke. After a few hours of normal computing, pressing
`<Control+Option+Apple-8>` no longer inverts display colours. This can be reset
with the Accessibility Controls window by pressing: `Option+Apple-F5`,
`<Shift><Tab><Tab><Tab><Tab><Tab>`, `<Space>`, `<Enter>`. As you might imagine,
that’s completely ridiculous, and it’s even more idiotic that I’d been doing it
from 2019 until the first release of this program in 2021. Furthermore, after
toggling the inversion, the machine always locks up for a few seconds.

This program makes inverting screen colours good again, restoring the old
behaviour: the keyboard shortcut always works and inverting doesn’t freeze the
machine.


## Usage
Toggle inverted colours with either of the following global keyboard shortcuts:

* `<Control+Option+Apple-8>`
* `<F8>`


## Install

	$ brew install teddywing/formulae/invert-catalina-invert
	$ brew services start teddywing/formulae/invert-catalina-invert


## Build

	$ git submodule init && git submodule update
	$ make


## License
Copyright © 2021 Teddy Wing. Licensed under the GNU GPLv3+ (see the included
COPYING file).
