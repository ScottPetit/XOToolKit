//
//  XOUtility.m
//  XOToolKit
//
//  Created by Scott Petit on 11/1/12.
//  Copyright (c) 2012 Scott Petit. All rights reserved.
//

#import "XOUtility.h"

@implementation XOUtility

#pragma mark - Idiom

+ (BOOL)isPad
{
	return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}

+ (BOOL)isPhone
{
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
}

#pragma mark - Retina

+ (BOOL)isRetina
{
    return [[UIScreen mainScreen] scale] == 2.0;
}

+ (CGFloat)scale
{
    return [[UIScreen mainScreen] scale];;
}

#pragma mark - Orientation

+ (BOOL)isPortrait
{
    return UIDeviceOrientationIsPortrait([[UIDevice currentDevice] orientation]);
}

+ (BOOL)isLandscape
{
    return UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation]);
}

+ (UIInterfaceOrientation)currentOrientation
{
    return [[UIApplication sharedApplication] statusBarOrientation];
}

#pragma mark - Status Bar

+ (BOOL)isStatusBarVisible
{
    return ![UIApplication sharedApplication].statusBarHidden;
}

+ (CGRect)statusBarFrame
{
    return [[UIApplication sharedApplication] statusBarFrame];
}

#pragma mark - Screen

+ (CGFloat)screenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)screenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)actualScreenHeight
{
    return [XOUtility isPortrait] ? [XOUtility screenHeight] : [XOUtility screenWidth];
}

+ (CGFloat)actualScreenWidth
{
    return [XOUtility isPortrait] ? [XOUtility screenWidth] : [XOUtility screenHeight];
}

#pragma mark - Directories

+ (NSString *)applicationDocumentsDirectoryPath
{
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
												NSUserDomainMask,
												YES) lastObject];
}
+ (NSString *)applicationDocumentsDirectoryPathAppended:(NSString *)pathToAppend
{
	return [[XOUtility applicationDocumentsDirectoryPath] stringByAppendingPathComponent:pathToAppend];
}

@end
