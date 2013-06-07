//
//  UIScrollView+XO.m
//  Scooby
//
//  Created by Scott Petit on 1/14/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import "UIScrollView+XO.h"

@implementation UIScrollView (XO)

- (CGFloat)xPercentageOffset
{
    return self.contentOffset.x / self.contentSize.width;
}

- (CGFloat)yPercentageOffset
{
    return self.contentOffset.y / self.contentSize.height;
}

- (void)xo_scrollToTop
{
    [self xo_scrollToTopAnimated:NO];
}

- (void)xo_scrollToTopAnimated:(BOOL)animated
{
    [self setContentOffset:CGPointZero animated:animated];
}

- (void)xo_scrollToVerticalPercentage:(CGFloat)percentage animated:(BOOL)animated
{
    CGPoint scrollOffset = CGPointMake(self.contentOffset.x, self.contentSize.height * percentage);
    [self setContentOffset:scrollOffset animated:animated];
}

- (void)xo_scrollToHorizontalPercentage:(CGFloat)percentage animated:(BOOL)animated
{
    CGPoint scrollOffset = CGPointMake(self.contentSize.width * percentage, self.contentOffset.y);
    [self setContentOffset:scrollOffset animated:animated];
}

@end
