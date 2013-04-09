//
//  XOPullToRefreshView.h
//  XOToolKit
//
//  Created by Scott Petit on 11/22/12.
//  Copyright (c) 2012 Scott Petit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    XOPullToRefreshViewStyleDefault,
    XOPullToRefreshViewStyleSimple
} XOPullToRefreshViewStyle;

typedef enum
{
   	XOPullToRefreshViewStateNormal = 0,
	XOPullToRefreshViewStateReady,
	XOPullToRefreshViewStateLoading
} XOPullToRefreshViewState;

@protocol  XOPullToRefreshViewDelegate;

@interface XOPullToRefreshView : UIView

@property (nonatomic, assign, readonly) UIScrollView *scrollView;
@property (nonatomic, assign) id <XOPullToRefreshViewDelegate> delegate;
@property (nonatomic, assign, readonly) XOPullToRefreshViewStyle pullToRefreshViewStyle;
@property (nonatomic, assign, readonly) XOPullToRefreshViewState pullToRefreshViewState;

@property (nonatomic, copy) NSString *normalText;
@property (nonatomic, copy) NSString *readyText;
@property (nonatomic, copy) NSString *loadingText;
@property (nonatomic, strong) UIColor *textColor;

+ (id)pullToRefreshViewWithScrollView:(UIScrollView *)scrollView delegate:(id)delegate;
+ (id)pullToRefreshViewWithScrollView:(UIScrollView *)scrollView delegate:(id)delegate style:(XOPullToRefreshViewStyle)style;

- (void)refreshLastUpdatedDate;
- (void)finishedLoading;

@end

@protocol  XOPullToRefreshViewDelegate <NSObject>

- (void)pullToRefreshViewShouldRefresh:(XOPullToRefreshView *)pullToRefreshView;

@end




