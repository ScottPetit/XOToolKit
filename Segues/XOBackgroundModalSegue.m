//
//  XOBackgroundModalSegue.m
//  XOToolKit
//
//  Created by Scott Petit on 3/13/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import "XOBackgroundModalSegue.h"
#include "XOToolKit.h"
#import <QuartzCore/QuartzCore.h>

#define kModalSeguePushedBackAnimationDuration 0.1
#define kModalSegueBringForwardAnimationDuration 0.3

@interface XOModalViewController : UIViewController

- (id)initWithScreenshot:(UIImageView *)screenShot destination:(UIViewController *)destinationViewController source:(UIViewController *)sourceViewController;

@property (nonatomic, strong) UIImageView *screenshot;
@property (nonatomic, strong) UIViewController *destinationViewController;
@property (nonatomic, strong) UIViewController *sourceViewController;

@end

@implementation XOModalViewController

- (id)initWithScreenshot:(UIImageView *)screenShot destination:(UIViewController *)destinationViewController source:(UIViewController *)sourceViewController
{
    self = [super init];
    if (self)
    {
        self.screenshot = screenShot;
        self.destinationViewController = destinationViewController;
        self.sourceViewController = sourceViewController;
    }
    return self;
}

- (void)oldDismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    [super dismissViewControllerAnimated:flag completion:completion];
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    [self.screenshot.layer addAnimation:[self animationGroupBringForward] forKey:nil];
    [UIView animateWithDuration:kModalSegueBringForwardAnimationDuration delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.screenshot.alpha = 1.0;
    } completion:^(BOOL finished) {
        // Dismiss the presented / destination controller
        [super dismissViewControllerAnimated:YES completion:^{
            // And then dismiss DCModalViewController
            [self oldDismissViewControllerAnimated:NO completion:nil];
        }];
    }];
}

#pragma mark Animation Group

-(CAAnimationGroup*)animationGroupPushedBackward {
    CATransform3D t1 = CATransform3DIdentity;
    t1.m34 = 1.0 / -900;
    t1 = CATransform3DScale(t1, 0.90, 0.90, 1);
    t1 = CATransform3DRotate(t1, 15.0f * M_PI/180.0f, 1, 0, 0);
    
    CATransform3D t2 = CATransform3DIdentity;
    t2.m34 = 1.0 / -900;
    t2 = CATransform3DTranslate(t2, 0.0, -20.0, 0.0);
    t2 = CATransform3DScale(t2, 0.85, 0.85, 1);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:t1];
    animation.duration = 2 * kModalSeguePushedBackAnimationDuration / 3;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation2.toValue = [NSValue valueWithCATransform3D:t2];
    animation2.beginTime = animation.duration;
    animation2.duration = kModalSeguePushedBackAnimationDuration / 3;
    animation2.fillMode = kCAFillModeForwards;
    [animation2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    animation2.removedOnCompletion = NO;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    [group setDuration:animation.duration * 2];
    [group setAnimations:[NSArray arrayWithObjects:animation,animation2, nil]];
    return group;
}

-(CAAnimationGroup*)animationGroupBringForward {
    CATransform3D t1 = CATransform3DIdentity;
    t1.m34 = 1.0 / -900;
    t1 = CATransform3DScale(t1, 0.90, 0.90, 1);
    t1 = CATransform3DRotate(t1, 15.0f * M_PI/180.0f, 1, 0, 0);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:t1];
    animation.duration = kModalSegueBringForwardAnimationDuration / 2;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation2.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation2.beginTime = animation.duration;
    animation2.duration = kModalSegueBringForwardAnimationDuration / 2;
    animation2.fillMode = kCAFillModeForwards;
    [animation2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    
    animation2.removedOnCompletion = NO;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    [group setDuration:animation.duration * 2];
    [group setAnimations:[NSArray arrayWithObjects:animation,animation2, nil]];
    return group;
}

@end

@implementation XOBackgroundModalSegue

- (void)perform
{
    XOModalViewController *modalViewController = [[XOModalViewController alloc]
                                                  initWithScreenshot:[self screenshotForView:[UIApplication sharedApplication].keyWindow]
                                                  destination:self.destinationViewController
                                                  source:self.sourceViewController];
    
    [self.sourceViewController presentViewController:modalViewController animated:NO completion:nil];
}

- (UIImageView *)screenshotForView:(UIView *)view
{
	UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [[UIScreen mainScreen] scale]);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if ([XOUtility isStatusBarVisible])
    {
        CGFloat barHeight = height([XOUtility statusBarFrame]);        
        CGFloat scale = [XOUtility scale];
        CGRect rect = CGRectMake(0, barHeight * scale, view.bounds.size.width * scale, (view.bounds.size.height - barHeight) * scale);
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
        image = [UIImage imageWithCGImage:imageRef scale:image.scale orientation:image.imageOrientation];
    }
    
	UIImageView* screenshot = [[UIImageView alloc] initWithImage:image];
    screenshot.frame = CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height);
    return screenshot;
}

@end
