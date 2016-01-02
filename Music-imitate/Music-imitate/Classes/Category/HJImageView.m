//
//  HJImageView.m
//  QQ
//
//  Created by nave on 15/10/16.
//  Copyright © 2015年 naveZhang. All rights reserved.
//

#import "HJImageView.h"

@implementation HJImageView

- (void)awakeFromNib {
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置边框颜色
    // self.layer.borderColor = [UIColor whiteColor].CGColor;
    // 边框宽度
    // self.layer.borderWidth = 1;
    // 设置圆角半径
    self.layer.cornerRadius = self.frame.size.width * 0.5;
    
    self.clipsToBounds = YES;
    
}

@end
