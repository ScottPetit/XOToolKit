//
//  XOPullToRefreshView.m
//  XOToolKit
//
//  Created by Scott Petit on 11/22/12.
//  Copyright (c) 2012 Scott Petit. All rights reserved.
//

#import "XOPullToRefreshView.h"

@interface XOPullToRefreshView()

@property (nonatomic, strong) UILabel *lastUpdatedLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;

- (id) initWithScrollView:(UIScrollView *)scrollView delegate:(id)delegate style:(XOPullToRefreshViewStyle)style;

@end

#define TEXT_COLOR	 [UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:1.0]
#define kPullViewStateNormal @"Pull down to refresh"
#define kPullViewStateReady @"Release to refresh"
#define kPullViewStateLoading @"Loading..."

@implementation XOPullToRefreshView


+ (id)pullToRefreshViewWithScrollView:(UIScrollView *)scrollView delegate:(id)delegate
{
    return [[self alloc] initWithScrollView:scrollView delegate:delegate style:XOPullToRefreshViewStyleDefault];
}

+ (id)pullToRefreshViewWithScrollView:(UIScrollView *)scrollView delegate:(id)delegate style:(XOPullToRefreshViewStyle)style
{
    return [[self alloc] initWithScrollView:scrollView delegate:delegate style:style];
}

- (id) initWithScrollView:(UIScrollView *)scrollView delegate:(id)delegate style:(XOPullToRefreshViewStyle)style
{
    CGRect frame = CGRectMake(0.0f, 0.0f - scrollView.bounds.size.height, scrollView.bounds.size.width, scrollView.bounds.size.height);
    
    self = [super initWithFrame:frame];
    if (self)
    {
        _scrollView = scrollView;
        [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
        
        _pullToRefreshViewStyle = style;
        
        if (_pullToRefreshViewStyle == XOPullToRefreshViewStyleDefault)
        {            
            self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            self.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];
            
            self.normalText = kPullViewStateNormal;
            self.readyText = kPullViewStateReady;
            self.loadingText = kPullViewStateLoading;
            self.textColor = TEXT_COLOR;
            
            self.lastUpdatedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 30.0f, self.frame.size.width, 20.0f)];
            self.lastUpdatedLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            self.lastUpdatedLabel.font = [UIFont systemFontOfSize:12.0f];
            self.lastUpdatedLabel.textColor = self.textColor;
            self.lastUpdatedLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
            self.lastUpdatedLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
            self.lastUpdatedLabel.backgroundColor = [UIColor clearColor];
            self.lastUpdatedLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:self.lastUpdatedLabel];
            
            self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 48.0f, self.frame.size.width, 20.0f)];
            self.statusLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            self.statusLabel.font = [UIFont boldSystemFontOfSize:13.0f];
            self.statusLabel.textColor = self.textColor;
            self.statusLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
            self.statusLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
            self.statusLabel.backgroundColor = [UIColor clearColor];
            self.statusLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:self.statusLabel];
            
            self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            self.activityView.frame = CGRectMake(30.0f, frame.size.height - 38.0f, 20.0f, 20.0f);
            [self addSubview:self.activityView];
            
            [self setState:XOPullToRefreshViewStateNormal];
        }
        else //XOPullToRefreshViewStyleSimple
        {
            self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            self.backgroundColor = [UIColor whiteColor];
            
            self.lastUpdatedLabel = nil;
            
            self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 38.0f, self.frame.size.width, 20.0f)];
            self.statusLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            self.statusLabel.font = [UIFont boldSystemFontOfSize:13.0f];
            self.statusLabel.textColor = self.textColor;
            self.statusLabel.shadowOffset = CGSizeMake(0.0f, 0.0f);
            self.statusLabel.backgroundColor = [UIColor clearColor];
            self.statusLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:self.statusLabel];
            
            self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            self.activityView.frame = CGRectMake(self.frame.size.width / 2 - 20.0f, frame.size.height - 38.0f, 20.0f, 20.0f);
            [self addSubview:self.activityView];
            
            [self setState:XOPullToRefreshViewStateNormal];
        }
    }
    return self;
}

#pragma mark Setter Overrides

- (void) setState:(XOPullToRefreshViewState) state
{
    _pullToRefreshViewState = state;
    
	switch (_pullToRefreshViewState)
    {
        case XOPullToRefreshViewStateReady:
            if (_pullToRefreshViewStyle == XOPullToRefreshViewStyleSimple)
                self.statusLabel.hidden = NO;
            
            self.statusLabel.text = self.readyText;
            [self showActivity:NO animated:NO];
            self.scrollView.contentInset = UIEdgeInsetsZero;
			break;
            
        case XOPullToRefreshViewStateNormal:
            if (_pullToRefreshViewStyle == XOPullToRefreshViewStyleSimple)
                self.statusLabel.hidden = NO;
            
            self.statusLabel.text = self.normalText;
            [self showActivity:NO animated:NO];
            [self refreshLastUpdatedDate];
            self.scrollView.contentInset = UIEdgeInsetsZero;
			break;
            
        case XOPullToRefreshViewStateLoading:
            if (_pullToRefreshViewStyle == XOPullToRefreshViewStyleSimple)
                self.statusLabel.hidden = YES;
            
            self.statusLabel.text = self.loadingText;
            [self showActivity:YES animated:YES];
            self.scrollView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
			break;
            
		default:
			break;
	}
}

- (void)setNormalText:(NSString *)normalText
{
    if (_normalText != normalText)
        _normalText = [normalText copy];
}

- (void)setReadyText:(NSString *)readyText
{
    if (_readyText != readyText)
        _readyText = [readyText copy];
}

- (void)setLoadingText:(NSString *)loadingText
{
    if (_loadingText != loadingText)
        _loadingText = [loadingText copy];
}

- (void)setTextColor:(UIColor *)textColor
{
    if (_textColor != textColor)
    {
        _textColor = [textColor copy];
        _lastUpdatedLabel.textColor = self.textColor;
        _statusLabel.textColor = self.textColor;
    }
}

#pragma mark UIScrollView Checking

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"])
    {

        if (self.scrollView.isDragging)
        {
            if (_pullToRefreshViewState == XOPullToRefreshViewStateReady)
            {
                if (self.scrollView.contentOffset.y > -65.0f && self.scrollView.contentOffset.y < 0.0f)
                    [self setState:XOPullToRefreshViewStateNormal];
            }
            else if (_pullToRefreshViewState == XOPullToRefreshViewStateNormal)
            {
                if (self.scrollView.contentOffset.y < -65.0f)
                    [self setState:XOPullToRefreshViewStateReady];
            }
            else if (_pullToRefreshViewState == XOPullToRefreshViewStateLoading)
            {
                if (self.scrollView.contentOffset.y >= 0)
                    self.scrollView.contentInset = UIEdgeInsetsZero;
                else
                    self.scrollView.contentInset = UIEdgeInsetsMake(MIN(-self.scrollView.contentOffset.y, 60.0f), 0, 0, 0);
            }
            else
            {
                if (_pullToRefreshViewState == XOPullToRefreshViewStateReady)
                {
                    [UIView animateWithDuration:0.2f animations:^
                     {
                         [self setState:XOPullToRefreshViewStateLoading];
                     }];
                    
                    if ([self.delegate respondsToSelector:@selector(pullToRefreshViewShouldRefresh:)])
                        [self.delegate pullToRefreshViewShouldRefresh:self];
                }
            }
        }
    }
}

- (void)refreshLastUpdatedDate
{
    if (_pullToRefreshViewStyle != XOPullToRefreshViewStyleSimple)
    {
        NSDate *date = [NSDate date];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setAMSymbol:@"AM"];
        [formatter setPMSymbol:@"PM"];
        [formatter setDateFormat:@"MM/dd/yy h:mm a"];
        self.lastUpdatedLabel.text = [NSString stringWithFormat:@"Last Updated: %@", [formatter stringFromDate:date]];
    }
}

- (void) showActivity:(BOOL)shouldShow animated:(BOOL)animated
{
    if (shouldShow)
        [self.activityView startAnimating];
    else
        [self.activityView stopAnimating];
}

- (void) finishedLoading
{
    if (_pullToRefreshViewState == XOPullToRefreshViewStateLoading)
    {
        [UIView animateWithDuration:0.3f animations:^
         {
             [self setState:XOPullToRefreshViewStateNormal];
         }];
    }
}

#pragma mark Dealloc

- (void) dealloc
{
	[_scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

@end


