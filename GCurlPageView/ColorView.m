//
//  ColorView.m
//  GCurlPageView
//
//  Created by gelosie.wang@gmail.com on 12-6-11.
//  Copyright (c) 2012年 gelosie.wang@gmail.com. All rights reserved.
//

#import "ColorView.h"

@implementation ColorView
@synthesize index;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:(arc4random()%255/255.0) green:(arc4random()%255/255.0) blue:(arc4random()%255/255.0) alpha:1];
        
        label = [[UILabel alloc]initWithFrame:self.bounds];
        label.textColor = [UIColor redColor];
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 0;
        [self addSubview:label];
    }
    return self;
}

-(void) setIndex:(NSInteger)aindex
{
    index = aindex;
    //NSLog(@"----------------------%d",aindex);
    NSMutableString *str = [NSMutableString stringWithCapacity:1000];
    for (NSInteger i=0; i<1000; i++) {
        [str appendFormat:@"----------------------%d",aindex];
    }
    label.text = str;
}

@end
