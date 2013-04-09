//
//  XOPushToRecommendView.h
//  Scooby
//
//  Created by Scott Petit on 1/18/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
   	XOPushToRecommendViewStateNormal = 1,
	XOPushToRecommendViewStateReady,
	XOPushToRecommendViewStateLoading,
    XOPushToRecommendViewStateClosing,
    XOPushToRecommendViewStateRecommended
} XOPushToRecommendViewState;

@protocol XOPushToRecommendViewDelegate;
@protocol XOPushToRecommendContentView;

@interface XOPushToRecommendView : UIView

@property (nonatomic, weak) id <XOPushToRecommendViewDelegate> delegate;
@property (nonatomic, strong) UIView <XOPushToRecommendContentView> *contentView;
@property (nonatomic, weak, readonly) UIScrollView *scrollView;
@property (nonatomic, assign, readonly) XOPushToRecommendViewState pushToRecommendState;

+ (XOPushToRecommendView *)pushToRecommendViewWithScrollView:(UIScrollView *)scrollView delegate:(id)delegate;

- (void)objectIsRecommended;
- (void)finishedRecommending;

@end

@protocol XOPushToRecommendViewDelegate <NSObject>

@required
- (void)pushToRecommendViewShouldRecommend:(XOPushToRecommendView *)view;

@end

@protocol XOPushToRecommendContentView <NSObject>

@required
- (void)setState:(XOPushToRecommendViewState)state withPushToRecommendView:(XOPushToRecommendView *)view;

@end
