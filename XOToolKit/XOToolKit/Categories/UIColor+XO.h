//
//  UIColor+XO.h
//  XOToolKit
//
//  Created by Scott Petit on 3/8/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (XO)

/**
 The receiver's red component value. (read-only)
 
 The value of this property is a floating-point number in the range `0.0` to `1.0`. `-1.0` is returned if the color is
 not in the RGB colorspace.
 */
@property (nonatomic, assign, readonly) CGFloat red;

/**
 The receiver's green component value. (read-only)
 
 The value of this property is a floating-point number in the range `0.0` to `1.0`. `-1.0` is returned if the color is
 not in the RGB colorspace.
 */
@property (nonatomic, assign, readonly) CGFloat green;

/**
 The receiver's blue component value. (read-only)
 
 The value of this property is a floating-point number in the range `0.0` to `1.0`. `-1.0` is returned if the color is
 not in the RGB colorspace.
 */
@property (nonatomic, assign, readonly) CGFloat blue;

/**
 The receiver's alpha value. (read-only)
 
 The value of this property is a floating-point number in the range `0.0` to `1.0`, where `0.0` represents totally
 transparent and `1.0` represents totally opaque.
 */
@property (nonatomic, assign, readonly) CGFloat alpha;

+ (UIColor *)flatTurquoiseColor;
+ (UIColor *)flatGreenSeaColor;
+ (UIColor *)flatEmerlandColor;
+ (UIColor *)flatNephritisColor;
+ (UIColor *)flatPeterRiverColor;
+ (UIColor *)flatBelizeHoleColor;
+ (UIColor *)flatAmethystColor;
+ (UIColor *)flatWisteriaColor;
+ (UIColor *)flatWetAsphaltColor;
+ (UIColor *)flatMidnightBlueColor;
+ (UIColor *)flatSunflowerColor;
+ (UIColor *)flatOrangeColor;
+ (UIColor *)flatCarrotColor;
+ (UIColor *)flatPumpkinColor;
+ (UIColor *)flatAlizarinColor;
+ (UIColor *)flatPomegranateColor;
+ (UIColor *)flatCloudsColor;
+ (UIColor *)flatSilverColor;
+ (UIColor *)flatConcreteColor;
+ (UIColor *)flatAsbestosColor;

@end
