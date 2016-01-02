//
//  TimeTool.m
//  QQ音乐
//
//  Created by nave on 15/5/3.
//  Copyright © 2015年 naveZhang. All rights reserved.
//

#import "TimeTool.h"

@implementation TimeTool

+ (NSString *)playMusicWithTiemer:(NSTimeInterval)timer
{
    double minute = timer / 60;
    NSInteger min = timer / 60;
    double sec = (minute - min) * 60;
    NSString *timerStr = [NSString stringWithFormat:@"%02ld:%02.0f",min,sec];
    return timerStr;
    
}

+ (float)timeWithString:(NSString *)timeString
{
    // 02:12.02
    NSArray *array = [timeString componentsSeparatedByString:@":"];
    NSString *min = [array firstObject];
    NSString *sec = [array lastObject];
    
    return (min.floatValue * 60) + sec.floatValue;
}

@end
