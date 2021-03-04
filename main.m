#import <CoreGraphics/CoreGraphics.h>

int main(int argc, const char * argv[]) {
    const CGGammaValue gamma[2] = {1, 0};

    CGError error = CGSetDisplayTransferByTable(
        CGMainDisplayID(),
        2,
        gamma,
        gamma,
        gamma
    );

    if (error != kCGErrorSuccess) {
        // TODO: error handling
    }

    for (;;) {}

    return 0;
}
