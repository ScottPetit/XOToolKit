//
//  UIColor+XO.m
//  XOToolKit
//
//  Created by Scott Petit on 3/8/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import "UIColor+XO.h"
#import "XOUtility.h"

@implementation UIColor (XO)

- (CGFloat)red
{
    CGColorRef color = self.CGColor;
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color)) != kCGColorSpaceModelRGB)
    {
        return -1.0f;
    }
    
    CGFloat const *components = CGColorGetComponents(color);
    return components[0];
}

- (CGFloat)green
{
    CGColorRef color = self.CGColor;
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color)) != kCGColorSpaceModelRGB)
    {
        return -1.0f;
    }
    
    CGFloat const *components = CGColorGetComponents(color);
    return components[1];
}

- (CGFloat)blue
{
    CGColorRef color = self.CGColor;
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color)) != kCGColorSpaceModelRGB)
    {
        return -1.0f;
    }
    
    CGFloat const *components = CGColorGetComponents(color);
    return components[2];
}

- (CGFloat)alpha
{
    return CGColorGetAlpha(self.CGColor);
}

#pragma mark - Flat Colors

+ (UIColor *)flatTurquoiseColor
{
    return RGB(26, 188, 156);
}

+ (UIColor *)flatGreenSeaColor
{
    return RGB(22, 160, 133);
}

+ (UIColor *)flatEmerlandColor
{
    return RGB(46, 204, 113);
}

+ (UIColor *)flatNephritisColor
{
    return RGB(39, 174, 96);
}

+ (UIColor *)flatPeterRiverColor
{
    return RGB(52, 152, 219);
}

+ (UIColor *)flatBelizeHoleColor
{
    return RGB(41, 128, 185);
}

+ (UIColor *)flatAmethystColor
{
    return RGB(155, 89, 182);
}

+ (UIColor *)flatWisteriaColor
{
    return RGB(142, 68, 173);
}

+ (UIColor *)flatWetAsphaltColor
{
    return RGB(52, 73, 94);
}

+ (UIColor *)flatMidnightBlueColor
{
    return RGB(44, 62, 80);
}

+ (UIColor *)flatSunflowerColor
{
    return RGB(241, 196, 15);
}

+ (UIColor *)flatOrangeColor
{
    return RGB(243, 156, 18);
}

+ (UIColor *)flatCarrotColor
{
    return RGB(230, 126, 34);
}

+ (UIColor *)flatPumpkinColor
{
    return RGB(211, 84, 0);
}

+ (UIColor *)flatAlizarinColor
{
    return RGB(231, 76, 60);
}

+ (UIColor *)flatPomegranateColor
{
    return RGB(192, 57, 43);
}

+ (UIColor *)flatCloudsColor
{
    return RGB(236, 240, 241);
}

+ (UIColor *)flatSilverColor
{
    return RGB(189, 195, 199);
}

+ (UIColor *)flatConcreteColor
{
    return RGB(149, 165, 166);
}

+ (UIColor *)flatAsbestosColor
{
    return RGB(127, 140, 141);
}

@end
