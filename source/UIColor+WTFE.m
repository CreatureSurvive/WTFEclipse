#include <UIColor+WTFE.h>

@implementation UIColor (WTFE)

- (BOOL)_wtf_isBrightColor {
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];

    return ((((red * 255) * 299) + ((green * 255) * 587) + ((blue * 255) * 114)) / 1000) >= 128.0;
}

@end