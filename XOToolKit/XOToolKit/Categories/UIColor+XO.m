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

+ (UIColor *)turquoiseColor
{
    return RGB(26, 188, 156);
}

+ (UIColor *)greenSeaColor
{
    return RGB(22, 160, 133);
}

+ (UIColor *)emerlandColor
{
    return RGB(46, 204, 113);
}

+ (UIColor *)nephritisColor
{
    return RGB(39, 174, 96);
}

+ (UIColor *)peterRiverColor
{
    return RGB(52, 152, 219);
}

+ (UIColor *)belizeHoleColor
{
    return RGB(41, 128, 185);
}

+ (UIColor *)amethystColor
{
    return RGB(155, 89, 182);
}

+ (UIColor *)wisteriaColor
{
    return RGB(142, 68, 173);
}

+ (UIColor *)wetAsphaltColor
{
    return RGB(52, 73, 94);
}

+ (UIColor *)midnightBlueColor
{
    return RGB(44, 62, 80);
}

+ (UIColor *)sunflowerColor
{
    return RGB(241, 196, 15);
}

+ (UIColor *)tangerineColor
{
    return RGB(243, 156, 18);
}

+ (UIColor *)carrotColor
{
    return RGB(230, 126, 34);
}

+ (UIColor *)pumpkinColor
{
    return RGB(211, 84, 0);
}

+ (UIColor *)alizarinColor
{
    return RGB(231, 76, 60);
}

+ (UIColor *)pomegranateColor
{
    return RGB(192, 57, 43);
}

+ (UIColor *)cloudsColor
{
    return RGB(236, 240, 241);
}

+ (UIColor *)silverColor
{
    return RGB(189, 195, 199);
}

+ (UIColor *)concreteColor
{
    return RGB(149, 165, 166);
}

+ (UIColor *)asbestosColor
{
    return RGB(127, 140, 141);
}

@end
