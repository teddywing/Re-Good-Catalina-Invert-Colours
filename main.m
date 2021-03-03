#import <CoreGraphics/CoreGraphics.h>

int main(int argc, const char * argv[]) {
    const CGGammaValue gamma[2] = {1, 0};
    const CGGammaValue two[2] = {1, 0};
    const CGGammaValue three[2] = {0, 1};

    CGSetDisplayTransferByTable(
        CGMainDisplayID(),
        2,
        gamma,
        gamma,
        gamma
    );

    sleep(5);

    return 0;
}
