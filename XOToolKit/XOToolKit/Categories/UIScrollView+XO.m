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

- (void)scrollToTop
{
    [self scrollToTopAnimated:NO];
}

- (void)scrollToTopAnimated:(BOOL)animated
{
    [self setContentOffset:CGPointZero animated:animated];
}

- (void)scrollToVerticalPercentage:(CGFloat)percentage animated:(BOOL)animated
{
    CGPoint scrollOffset = CGPointMake(self.contentOffset.x, self.contentSize.height * percentage);
    [self setContentOffset:scrollOffset animated:animated];
}

- (void)scrollToHorizontalPercentage:(CGFloat)percentage animated:(BOOL)animated
{
    CGPoint scrollOffset = CGPointMake(self.contentSize.width * percentage, self.contentOffset.y);
    [self setContentOffset:scrollOffset animated:animated];
}

@end
