//
//  GCurlPageView.h
//  GCurlPageView
//
//  Created by gelosie.wang@gmail.com on 12-6-11.
//  Copyright (c) 2012年 gelosie.wang@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	GCurlPageViewDirectionLeft = 0,
	GCurlPageViewDirectionRight = 1
} GCurlPageViewDirection;

@class GCurlPageView;

@protocol GCurlPageViewDataSource
- (UIView *) nextView:(UIView *) currentView inCurlView:(GCurlPageView *) curlPage;
- (UIView *) prevView:(UIView *) currentView inCurlView:(GCurlPageView *) curlPage;
@end

@protocol GCurlPageViewDelegate <NSObject>
@optional;
- (void) pageViewWillCurl:(GCurlPageView *) curlPage;
- (void) pageViewDidCurl:(GCurlPageView *) curlPage;
@end

@interface GCurlPageView : UIView
{
    GCurlPageViewDirection direction;
    
    UIView *currentView;
    UIView *nextView;
    UIView *prevView;
    
    BOOL animating;
}

@property (nonatomic, assign) id<GCurlPageViewDataSource> dataSource;
@property (nonatomic, assign) id<GCurlPageViewDelegate> delegate;
@property (nonatomic, assign) BOOL disabled;

- (void) setCurrentPageView:(UIView *)view animated:(BOOL) animated;


@end