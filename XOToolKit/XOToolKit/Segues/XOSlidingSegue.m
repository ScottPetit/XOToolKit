//
//  BSSlidingSegue.m
//  Scooby
//
//  Created by Scott Petit on 2/5/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import "XOSlidingSegue.h"
#include "XOToolKit.h"

@implementation XOSlidingSegue

- (void)perform
{
    UIViewController *sourceViewController = (UIViewController *)self.sourceViewController;
    UIViewController *destinationViewController = (UIViewController *)self.destinationViewController;
    
    UIView *sourceView = sourceViewController.view;
    UIView *destinationView = destinationViewController.view;
    
    CGRect destinationViewFrame = destinationView.frame;
    destinationViewFrame.origin.x = maxX(sourceView.frame);
    destinationView.frame = destinationViewFrame;

    [sourceView addSubview:destinationView];
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         CGRect destinationViewFrame = destinationView.frame;
                         destinationViewFrame.origin.x = 0;
                         destinationView.frame = destinationViewFrame;

                         CGRect sourceViewFrame = sourceView.frame;
                         sourceViewFrame.origin.x = minX(destinationView.frame) - width(sourceView.frame);
                         sourceView.frame = sourceViewFrame;

                         DebugLog(@"%f", minX(destinationView.frame));
                     } completion:^(BOOL finished) {
                         if (finished)
                         {
                            [sourceViewController presentViewController:destinationViewController animated:NO completion:nil];
                         }
                     }];
}

@end
