//
//  UIColor+Utilities.m
//  calvetica
//
//  Created by Adam Kirk on 6/1/11.
//  Copyright 2011 Mysterious Trousers, LLC. All rights reserved.
//

#import "UIColor+Calvetica.h"

#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB(r, g, b) RGBA(r, g, b, 1.0f)

#define RGBAHex(rgbValue, a) RGBA( \
((float)((rgbValue & 0xFF0000) >> 16)), \
((float)((rgbValue & 0xFF00) >> 8)), \
((float)(rgbValue & 0xFF)), \
a \
)

#define RGBHex(rgbValue) RGBAHex(rgbValue, 1.0)

#define CV_PALETTE_1 [UIColor colorWithRed:0.937 green:0.631 blue:0.502 alpha:1.000]
#define CV_PALETTE_2 [UIColor colorWithRed:0.898 green:0.459 blue:0.310 alpha:1.000]
#define CV_PALETTE_3 [UIColor colorWithRed:0.835 green:0.122 blue:0.000 alpha:1.000]
#define CV_PALETTE_4 [UIColor colorWithRed:0.647 green:0.816 blue:0.863 alpha:1.000]
#define CV_PALETTE_5 [UIColor colorWithRed:0.478 green:0.710 blue:0.780 alpha:1.000]
#define CV_PALETTE_6 [UIColor colorWithRed:0.153 green:0.529 blue:0.643 alpha:1.000]
#define CV_PALETTE_7 [UIColor colorWithRed:0.702 green:0.718 blue:0.812 alpha:1.000]
#define CV_PALETTE_8 [UIColor colorWithRed:0.549 green:0.569 blue:0.702 alpha:1.000]
#define CV_PALETTE_9 [UIColor colorWithRed:0.267 green:0.298 blue:0.518 alpha:1.000]
#define CV_PALETTE_10 [UIColor colorWithRed:0.639 green:0.827 blue:0.741 alpha:1.000]
#define CV_PALETTE_11 [UIColor colorWithRed:0.467 green:0.725 blue:0.600 alpha:1.000]
#define CV_PALETTE_12 [UIColor colorWithRed:0.133 green:0.553 blue:0.349 alpha:1.000]
#define CV_PALETTE_13 [UIColor colorWithRed:0.765 green:0.824 blue:0.525 alpha:1.000]
#define CV_PALETTE_14 [UIColor colorWithRed:0.631 green:0.718 blue:0.333 alpha:1.000]
#define CV_PALETTE_15 [UIColor colorWithRed:0.400 green:0.541 blue:0.000 alpha:1.000]
#define CV_PALETTE_16 [UIColor colorWithRed:0.792 green:0.671 blue:0.827 alpha:1.000]
#define CV_PALETTE_17 [UIColor colorWithRed:0.675 green:0.506 blue:0.725 alpha:1.000]
#define CV_PALETTE_18 [UIColor colorWithRed:0.471 green:0.196 blue:0.553 alpha:1.000]
#define CV_PALETTE_19 [UIColor colorWithRed:0.925 green:0.792 blue:0.510 alpha:1.000]
#define CV_PALETTE_20 [UIColor colorWithRed:0.878 green:0.671 blue:0.318 alpha:1.000]
#define CV_PALETTE_21 [UIColor colorWithRed:0.804 green:0.467 blue:0.000 alpha:1.000]
#define CV_PALETTE_22 [UIColor colorWithRed:0.937 green:0.000 blue:0.000 alpha:1.000]
#define CV_PALETTE_23 [UIColor colorWithRed:0.961 green:0.596 blue:0.000 alpha:1.000]
#define CV_PALETTE_24 [UIColor colorWithRed:0.988 green:0.914 blue:0.000 alpha:1.000]
#define CV_PALETTE_25 [UIColor colorWithRed:0.549 green:1.000 blue:0.000 alpha:1.000]
#define CV_PALETTE_26 [UIColor colorWithRed:0.302 green:1.000 blue:0.325 alpha:1.000]
#define CV_PALETTE_27 [UIColor colorWithRed:0.298 green:0.996 blue:1.000 alpha:1.000]
#define CV_PALETTE_28 [UIColor colorWithRed:0.180 green:0.584 blue:1.000 alpha:1.000]
#define CV_PALETTE_29 [UIColor colorWithRed:0.051 green:0.067 blue:1.000 alpha:1.000]
#define CV_PALETTE_30 [UIColor colorWithRed:0.306 green:0.000 blue:1.000 alpha:1.000]
#define CV_PALETTE_31 [UIColor colorWithRed:0.482 green:0.000 blue:1.000 alpha:1.000]
#define CV_PALETTE_32 [UIColor colorWithRed:0.812 green:0.000 blue:1.000 alpha:1.000]
#define CV_PALETTE_33 [UIColor colorWithRed:0.937 green:0.000 blue:0.396 alpha:1.000]
#define CV_PALETTE_34 [UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:1.000]
#define CV_PALETTE_35 [UIColor colorWithRed:0.192 green:0.192 blue:0.192 alpha:1.000]
#define CV_PALETTE_36 [UIColor colorWithRed:0.427 green:0.427 blue:0.427 alpha:1.000]
#define CV_PALETTE_37 [UIColor colorWithRed:0.698 green:0.698 blue:0.698 alpha:1.000]
#define CV_PALETTE_38 [UIColor colorWithRed:0.706 green:0.000 blue:0.000 alpha:1.000]


@implementation UIColor (Calvetica)

+ (NSArray *)primaryPalette
{
    return @[CV_PALETTE_1,
             CV_PALETTE_2,
             CV_PALETTE_3,
             CV_PALETTE_4,
             CV_PALETTE_5,
             CV_PALETTE_6,
             CV_PALETTE_7,
             CV_PALETTE_8,
             CV_PALETTE_9,
             CV_PALETTE_10,
             CV_PALETTE_11,
             CV_PALETTE_12,
             CV_PALETTE_13,
             CV_PALETTE_14,
             CV_PALETTE_15,
             CV_PALETTE_16,
             CV_PALETTE_17,
             CV_PALETTE_18,
             CV_PALETTE_19,
             CV_PALETTE_20,
             CV_PALETTE_21];
}

+ (NSArray *)colorfulPalette
{
    return @[
             RGBHex(0xA2B659),
             RGBHex(0xE47452),
             RGBHex(0xA5D1DC),
             RGBHex(0xAB83B8),
             RGBHex(0xA2B659),
             RGBHex(0xE47452),
             RGBHex(0xA5D1DC),
             RGBHex(0xAB83B8),
             RGBHex(0xA2B659),
             RGBHex(0xE47452),
             RGBHex(0xA5D1DC),
             RGBHex(0xAB83B8)
             ];
}

+ (UIColor *)randomColorFromPalette:(NSArray *)palette
{
    int index = arc4random() % [palette count];
    return palette[index];
}





#pragma mark - Private

+ (UIColor *)customColor:(UIColor *)color title:(NSString *)title
{
    return color;
}

@end
