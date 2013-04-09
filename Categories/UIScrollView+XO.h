//
//  UIScrollView+XO.h
//  Scooby
//
//  Created by Scott Petit on 1/14/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (XO)

@property (nonatomic, readonly) CGFloat xPercentageOffset;
@property (nonatomic, readonly) CGFloat yPercentageOffset;

- (void)scrollToTop;
- (void)scrollToTopAnimated:(BOOL)animated;

- (void)scrollToVerticalPercentage:(CGFloat)percentage animated:(BOOL)animated;
- (void)scrollToHorizontalPercentage:(CGFloat)percentage animated:(BOOL)animated;

@end
