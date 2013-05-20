//
//  XOPushToRecommendView.m
//  Scooby
//
//  Created by Scott Petit on 1/18/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import "XOPushToRecommendView.h"
#include "XOToolKit.h"
#import "XOPushToRecommendDefaultContentView.h"

@interface XOPushToRecommendView()

@property (nonatomic, weak, readwrite) UIScrollView *scrollView;

@end

CGFloat const kExpandedHeight = 60.0f;

@implementation XOPushToRecommendView

@synthesize contentView = _contentView;

+ (XOPushToRecommendView *)pushToRecommendViewWithScrollView:(UIScrollView *)scrollView delegate:(id)delegate
{
    return [[self alloc] initWithScrollView:scrollView delegate:delegate];
}

- (id)initWithScrollView:(UIScrollView *)scrollView delegate:(id)delegate
{
    CGRect frame = CGRectMake(0.0f, scrollView.contentSize.height - height(scrollView.bounds), scrollView.bounds.size.width, scrollView.bounds.size.height);
    self = [super initWithFrame:frame];
    if (self)
    {
        self.delegate = delegate;
        self.scrollView = scrollView;
        
        for (UIView *view in self.scrollView.subviews)
        {
			if ([view isKindOfClass:[XOPushToRecommendView class]])
            {
				[[NSException exceptionWithName:@"XOPushToRecommendViewAlreadyAdded" reason:@"There is already a XOPushToRecommendView added to this scroll view. Unexpected things will happen. Don't do this." userInfo:nil] raise];
			}
		}

        [self.scrollView addSubview:self];
                
        [self setState:XOPushToRecommendViewStateNormal];
    }
    return self;
}

#pragma mark - Public

- (void)finishedRecommending
{
    if (_pushToRecommendState == XOPushToRecommendViewStateLoading)
    {
        [UIView animateWithDuration:0.3
                         animations:^{
                             [self setState:XOPushToRecommendViewStateClosing];
                         } completion:^(BOOL finished) {
                             [self setState:XOPushToRecommendViewStateNormal];
                         }];
    }
}

- (void)objectIsRecommended
{
    [self setState:XOPushToRecommendViewStateRecommended];
}

#pragma mark - Setters

- (void)setState:(XOPushToRecommendViewState)state
{
    _pushToRecommendState = state;
    
    [self.contentView setState:_pushToRecommendState withPushToRecommendView:self];
    
    switch (_pushToRecommendState) {
        case XOPushToRecommendViewStateLoading:
            self.scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 60.0f, 0.0f);
            break;
            
        default:
            self.scrollView.contentInset = UIEdgeInsetsZero;
            break;
    }
}

- (void)setScrollView:(UIScrollView *)scrollView
{
    if (_scrollView)
    {
		[_scrollView removeObserver:self forKeyPath:@"contentOffset"];
        [_scrollView removeObserver:self forKeyPath:@"contentSize"];
	}
    
	_scrollView = scrollView;
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
    [self.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:NULL];
}

- (UIView<XOPushToRecommendContentView> *)contentView
{
	// Use the default content view as the default
	if (!_contentView)
    {
		self.contentView = [[XOPushToRecommendDefaultContentView alloc] initWithFrame:CGRectZero];
	}
	return _contentView;
}

- (void)setContentView:(UIView<XOPushToRecommendContentView> *)contentView
{
	[_contentView removeFromSuperview];
	_contentView = contentView;
    
	_contentView.autoresizingMask = UIViewAutoresizingNone;
	[_contentView setState:_pushToRecommendState withPushToRecommendView:self];
	[self addSubview:_contentView];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"])
    {
        if (self.pushToRecommendState == XOPushToRecommendViewStateRecommended)
        {
            return;
        }
        
        if (self.scrollView.isDragging)
        {            
            switch (self.pushToRecommendState) {
                case XOPushToRecommendViewStateNormal:
                    if (self.scrollView.contentOffset.y + height(self.scrollView.frame) > self.scrollView.contentSize.height + kExpandedHeight)
                    {
                        [self setState:XOPushToRecommendViewStateReady];
                    }
                    break;
                    
                case XOPushToRecommendViewStateReady:
                    if (self.scrollView.contentOffset.y + height(self.scrollView.frame) < self.scrollView.contentSize.height + kExpandedHeight)
                    {
                        [self setState:XOPushToRecommendViewStateNormal];
                    }
                    break;
                    
                case XOPushToRecommendViewStateLoading:
                    [self setState:XOPushToRecommendViewStateLoading];
                    break;
                    
                default:
                    break;
            }
        }
        else
        {
            if (self.pushToRecommendState == XOPushToRecommendViewStateReady)
            {
                [UIView animateWithDuration:0.3 animations:^{
                    [self setState:XOPushToRecommendViewStateLoading];
                }];
                
                [self.delegate pushToRecommendViewShouldRecommend:self];
            }
        }
    }
    else if ([keyPath isEqualToString:@"contentSize"])
    {
        CGRect newFrame = self.frame;
        newFrame.origin.y = self.scrollView.contentSize.height;
        self.frame = newFrame;
    }
}

#pragma mark - Layout Subviews

- (void)layoutSubviews
{
	CGSize size = self.bounds.size;
	CGSize contentSize = [self.contentView sizeThatFits:size];
    
	if (contentSize.width < size.width)
    {
		contentSize.width = size.width;
	}
    
    if (contentSize.height < size.height)
    {
        contentSize.height = size.height;
    }
    
    self.contentView.frame = CGRectMake(0, 0, contentSize.width, contentSize.height);
}

#pragma mark - Dealloc

- (void)dealloc
{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    [_scrollView removeObserver:self forKeyPath:@"contentSize"];
}

@end
