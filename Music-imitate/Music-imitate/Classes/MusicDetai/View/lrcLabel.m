//
//  lrcLabel.m
//  QQ音乐
//
//  Created by nave on 15/5/3.
//  Copyright © 2015年 naveZhang. All rights reserved.
//

#import "lrcLabel.h"

@implementation lrcLabel

- (void)setProgress:(double)progress
{
    _progress = progress;
    
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [super drawRect:rect];
    
    [[UIColor greenColor] set];
    
    UIRectFillUsingBlendMode(CGRectMake(0, 0, rect.size.width * self.progress, rect.size.height), kCGBlendModeSourceIn);
    
}


@end
