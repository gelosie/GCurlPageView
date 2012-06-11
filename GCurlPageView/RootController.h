//
//  RootController.h
//  GCurlPageView
//
//  Created by gelosie.wang@gmail.com on 12-6-11.
//  Copyright (c) 2012年 gelosie.wang@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCurlPageView.h"

@interface RootController : UIViewController<GCurlPageViewDelegate,GCurlPageViewDataSource>

@property (retain, nonatomic) GCurlPageView *page;

@end
