#import <CoreGraphics/CoreGraphics.h>

int main(int argc, const char * argv[]) {
    const CGGammaValue inverted_gamma[2] = {1, 0};

    CGError error = CGSetDisplayTransferByTable(
        CGMainDisplayID(),
        2,
        inverted_gamma,
        inverted_gamma,
        inverted_gamma
    );

    if (error != kCGErrorSuccess) {
        // TODO: error handling
    }

    for (;;) {}

    return 0;
}
