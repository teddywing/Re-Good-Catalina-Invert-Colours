#import <CoreGraphics/CoreGraphics.h>

int main(int argc, const char * argv[]) {
    const CGGammaValue gamma[2] = {1, 0};

    CGSetDisplayTransferByTable(
        CGMainDisplayID(),
        2,
        gamma,
        gamma,
        gamma
    );

    for (;;) {}

    return 0;
}
