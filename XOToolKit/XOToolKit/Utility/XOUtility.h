//
//  XOUtility.h
//  XOToolKit
//
//  Created by Scott Petit on 11/1/12.
//  Copyright (c) 2012 Scott Petit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface XOUtility : NSObject

// Target > Get Info > Build > GCC_PREPROCESSOR_DEFINITIONS
// Configuration = Release: <empty>
//               = Debug:   DEBUG=1
#ifdef DEBUG
#define DebugLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DebugLog( s, ... )
#endif

//RGB Macro to return a UIColor
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//CGRectGet Macro to shorten length of calls
#define width(frame) CGRectGetWidth(frame)
#define height(frame) CGRectGetHeight(frame)
#define minX(frame) CGRectGetMinX(frame)
#define minY(frame) CGRectGetMinY(frame)
#define midX(frame) CGRectGetMidX(frame)
#define midY(frame) CGRectGetMidY(frame)
#define maxX(frame) CGRectGetMaxX(frame)
#define maxY(frame) CGRectGetMaxY(frame)

//Device Idiom
+ (BOOL)isPad;
+ (BOOL)isPhone;

//Retina
+ (BOOL)isRetina;
+ (CGFloat)scale;

//Orientation
+ (BOOL)isPortrait;
+ (BOOL)isLandscape;
+ (UIInterfaceOrientation)currentOrientation;

//Status Bar
+ (BOOL)isStatusBarVisible;
+ (CGRect)statusBarFrame;

//Screen
+ (CGFloat)screenHeight;
+ (CGFloat)screenWidth;

//Actual returns the screen height and width relative to the current orientation
+ (CGFloat)actualScreenHeight;
+ (CGFloat)actualScreenWidth;

@end
