//
//  XOPushToRecommendDefaultContentView.h
//  Scooby
//
//  Created by Scott Petit on 1/22/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import "XOPushToRecommendView.h"

@interface XOPushToRecommendDefaultContentView : UIView <XOPushToRecommendContentView>

@property (nonatomic, strong, readonly) UILabel *statusLabel;
@property (nonatomic, strong, readonly) UIActivityIndicatorView *activityIndicatorView;

@end
