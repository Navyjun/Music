//
//  UIImage+textImage.m
//  QQ音乐
//
//  Created by nave on 15/1/25.
//  Copyright © 2015年 naveZhang. All rights reserved.
//

#import "UIImage+textImage.h"

@implementation UIImage (textImage)

+ (UIImage *)image:(UIImage *)image andText:(NSString *)text
{
    // 1.开启位图上下文
    UIGraphicsBeginImageContext(image.size);
    
    // 2.把图片绘制进去
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    // 3.绘制文字
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    
    NSDictionary *dic = @{
                          NSForegroundColorAttributeName : [UIColor whiteColor],
                          NSParagraphStyleAttributeName : style,
                          NSFontAttributeName : [UIFont systemFontOfSize:17]
                          };
    
    [text drawInRect:CGRectMake(0, 0, image.size.width, 26) withAttributes:dic];
    
    // 取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭位图上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
