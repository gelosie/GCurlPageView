//
//  RootController.m
//  GCurlPageView
//
//  Created by gelosie.wang@gmail.com on 12-6-11.
//  Copyright (c) 2012年 gelosie.wang@gmail.com. All rights reserved.
//

#import "RootController.h"
#import "ColorView.h"

@implementation RootController
@synthesize page;

- (id) init {
	if ((self = [super init])) {

	}
	
	return self;
}


- (void)dealloc {
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    self.view.autoresizesSubviews = YES;
	self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    

    
    ColorView *iv = [[ColorView alloc]initWithFrame:page.bounds];
    [iv  setIndex : 10];
    
    page = [[ GCurlPageView alloc]initWithFrame:CGRectMake(100.0, 500.0, 300.0, 300.0)];
    page.dataSource = self;
    [self.view addSubview:page];
    [page setCurrentPageView:iv animated:YES];
    
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


- (UIView *) nextView:(UIView *) currentView inCurlView:(GCurlPageView *) curlPage
{
    NSInteger i = ((ColorView *)currentView).index;
    i++;
    ColorView *cv = [[ColorView alloc]initWithFrame:curlPage.bounds];
    [cv  setIndex :i];
    return  cv;
}


- (UIView *) prevView:(UIView *) currentView inCurlView:(GCurlPageView *) curlPage
{
    NSInteger i = ((ColorView *)currentView).index;
    if (i <= 0) {
        return nil;
    }
    i--;
    ColorView *cv = [[ColorView alloc]initWithFrame:curlPage.bounds];
    [cv  setIndex :i];
    return  cv;
}


@end
