//
//  AppDelegate.m
//  GCurlPageView
//
//  Created by gelosie.wang@gmail.com on 12-6-11.
//  Copyright (c) 2012年 gelosie.wang@gmail.com. All rights reserved.
//
#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize rootController = _rootController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[RootController alloc]init];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
