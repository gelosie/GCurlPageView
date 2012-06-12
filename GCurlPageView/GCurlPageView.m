//
//  GCurlPageView.m
//  GCurlPageView
//
//  Created by gelosie.wang@gmail.com on 12-6-11.
//  Copyright (c) 2012年 gelosie.wang@gmail.com. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "GCurlPageView.h"

@interface GCurlPageView(PrivateGCurlPageView)
- (void) loadPrevView;
- (void) loadNextView;

- (void) swiped:(UISwipeGestureRecognizer *)recognizer;
- (void) tapped:(UITapGestureRecognizer *) recognizer;
- (void) exchangeView;
@end

@implementation GCurlPageView

@synthesize dataSource;
@synthesize delegate;
@synthesize disabled;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
		UISwipeGestureRecognizer *leftSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiped:)];
        leftSwipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        UISwipeGestureRecognizer *rightSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiped:)];
        rightSwipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:tapRecognizer];
        [self addGestureRecognizer:leftSwipeRecognizer];
        [self addGestureRecognizer:rightSwipeRecognizer];
        
        animating = NO;
    }
    return self;
}

- (void) setCurrentPageView:(UIView *)view animated:(BOOL) animated
{
    if (currentView != nil) {
        [currentView removeFromSuperview];
        currentView = nil;
    }
    if (prevView != nil) {
        [prevView removeFromSuperview];
        prevView = nil;
    }
    if (nextView != nil) {
        [nextView removeFromSuperview];
        nextView = nil;
    }
    
    currentView = view;
    currentView.frame = self.bounds;
    [self addSubview:currentView];
    
    if (animated) {
        currentView.alpha = 0.0;
        [UIView animateWithDuration:1.0 animations:^{
            currentView.alpha = 1.0;
        } completion:^(BOOL finished) {
            
        }];
    }
    [self loadNextView];
    [self loadPrevView];
}

- (void) loadPrevView
{
    if (prevView != nil) {
        [prevView removeFromSuperview];
        prevView = nil;
    }
    prevView = [dataSource prevView:currentView inCurlView:self];
    if (prevView != nil) {
        prevView.frame = self.bounds;
        
        prevView.alpha = 0.0;
        [self addSubview:prevView];
        [self sendSubviewToBack:prevView];
        prevView.alpha = 1.0;
        
    }
    
}

- (void) loadNextView
{
    if (nextView != nil) {
        [nextView removeFromSuperview];
        nextView = nil;
    }
    nextView = [dataSource nextView:currentView inCurlView:self];
    if (nextView != nil) {
        nextView.frame = self.bounds;
        
        nextView.alpha = 0.0;
        [self addSubview:nextView];
        [self sendSubviewToBack:nextView];
        nextView.alpha = 1.0;
        
    }
    
}

- (void) tapped:(UITapGestureRecognizer *) recognizer
{
    if (animating || self.disabled ) {
		return;
	}
    
	if (recognizer.state == UIGestureRecognizerStateRecognized) {
		if ([recognizer locationInView:self].x < (self.bounds.size.width - self.bounds.origin.x) / 2) {
            direction = GCurlPageViewDirectionRight;
            if (prevView == nil) {
                return;
            }
		} else {
            direction = GCurlPageViewDirectionLeft;
            if (nextView == nil) {
                return;
            }
		}
	}
    animating = YES;
    [self exchangeView];
}


-(void)swiped:(UISwipeGestureRecognizer *)recognizer{
    
    if (animating || self.disabled) {
		return;
	}
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        direction = GCurlPageViewDirectionLeft;
        if (nextView == nil) {
            return;
        }
    }else if(recognizer.direction == UISwipeGestureRecognizerDirectionRight){
        direction = GCurlPageViewDirectionRight;
        if (prevView == nil) {
            return;
        }
    }
    animating = YES;
    [self exchangeView];
}

- (void) exchangeView
{   
   // [UIView beginAnimations:@"CurlAnimation" context:nil];
	//[UIView setAnimationDuration:0.5f];
	//[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	//[UIView setAnimationRepeatAutoreverses:NO];
    
    [UIView animateWithDuration:0.5f animations:^{
        if (delegate != nil && [delegate respondsToSelector:@selector(pageScrollViewWillScroll:)]) {
            [delegate pageViewWillCurl:self];
        }
        if (direction == GCurlPageViewDirectionLeft) {
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self cache:YES];
            [self bringSubviewToFront:nextView];
        }else{
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self cache:YES];
            [self bringSubviewToFront:prevView];
        }
        self.userInteractionEnabled = NO;
    } completion:^(BOOL finished) {
        if (direction == GCurlPageViewDirectionLeft) {
            UIView *temp = currentView;
            currentView = nextView;
            nextView = nil;
            [self loadNextView];
            [prevView removeFromSuperview];
            prevView = temp;
        }else{
            UIView *temp = currentView;
            currentView = prevView;
            prevView = nil;
            [self loadPrevView];
            [nextView removeFromSuperview];
            nextView = temp;
        }
        animating = NO;
        if (delegate != nil && [delegate respondsToSelector:@selector(pageScrollViewDidScroll:)]) {
            [delegate pageViewDidCurl:self];
        }
        self.userInteractionEnabled = YES;
    }];
}

@end
