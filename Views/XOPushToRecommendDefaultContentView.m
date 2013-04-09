//
//  XOPushToRecommendDefaultContentView.m
//  Scooby
//
//  Created by Scott Petit on 1/22/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import "XOPushToRecommendDefaultContentView.h"

@interface XOPushToRecommendView()

@end

static NSString * const kPushToRecommendDefaultStateNormal = @"Push To Recommend";
static NSString * const kPushToRecommendDefaultStateReady = @"Release to Recommend";
static NSString * const kPushToRecommendDefaultStateLoading = @"Loading...";

@implementation XOPushToRecommendDefaultContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 14.0f, width(self.bounds), 20.0f)];
        _statusLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _statusLabel.font = [UIFont boldSystemFontOfSize:14];
        _statusLabel.textColor = [UIColor blackColor];
        _statusLabel.backgroundColor = [UIColor clearColor];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_statusLabel];
        
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		_activityIndicatorView.frame = CGRectMake(30.0f, 25.0f, 20.0f, 20.0f);
		[self addSubview:_activityIndicatorView];
    }
    return self;
}

- (void)layoutSubviews
{
    CGSize size = self.bounds.size;
	self.statusLabel.frame = CGRectMake(20.0f, roundf((size.height - 30.0f) / 2.0f), size.width - 40.0f, 30.0f);
	self.activityIndicatorView.frame = CGRectMake(roundf((size.width - 20.0f) / 2.0f), roundf((size.height - 20.0f) / 2.0f), 20.0f, 20.0f);
}

- (void)setState:(XOPushToRecommendViewState)state withPushToRecommendView:(XOPushToRecommendView *)view
{
    switch (state) {
        case XOPushToRecommendViewStateNormal:
            self.statusLabel.text = kPushToRecommendDefaultStateNormal;
            self.statusLabel.alpha = 1.0f;
            [self.activityIndicatorView stopAnimating];
            self.activityIndicatorView.alpha = 0.0f;
            break;
            
        case XOPushToRecommendViewStateReady:
            self.statusLabel.text = kPushToRecommendDefaultStateReady;
            self.statusLabel.alpha = 1.0f;
            
            [self.activityIndicatorView stopAnimating];
            self.activityIndicatorView.alpha = 0.0f;
            break;
            
        case XOPushToRecommendViewStateLoading:
            self.statusLabel.alpha = 0.0f;
            [self.activityIndicatorView startAnimating];
            self.activityIndicatorView.alpha = 1.0f;
            break;
            
        case XOPushToRecommendViewStateClosing:
            self.statusLabel.text = nil;
            self.activityIndicatorView.alpha = 0.0f;
            break;
            
        default:
            break;
    }
}

@end
