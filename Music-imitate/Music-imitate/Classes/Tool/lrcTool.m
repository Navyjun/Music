//
//  lrcTool.m
//  QQ音乐
//
//  Created by nave on 15/5/3.
//  Copyright © 2015年 naveZhang. All rights reserved.
//

#import "lrcTool.h"
#import "lrcModel.h"
#import "TimeTool.h"

@interface lrcTool ()
/** lrc */
@property (nonatomic, strong) NSMutableArray *lrcArray;

@end

@implementation lrcTool

- (NSArray *)lrcToStringArray:(NSString *)lrcName 
{
    NSString *lrcPath = [[NSBundle mainBundle] pathForResource:lrcName ofType:nil];
    NSString *string = [NSString stringWithContentsOfFile:lrcPath encoding:NSUTF8StringEncoding error:nil];
   
    
    // 分解字符串 去掉左边的中括号
    NSString *replacingStr = [string stringByReplacingOccurrencesOfString:@"[" withString:@""];
    // 通过换行符
    NSArray *arrayLrc = [replacingStr componentsSeparatedByString:@"\n"];
    
    
    for (NSInteger i = 0; i < arrayLrc.count; i++) {
        
        NSString *timeAndText = arrayLrc[i];
        
        // 过滤不需要的字符串
        if ([timeAndText containsString:@"ti:"]||[timeAndText containsString:@"ar:"]|| [timeAndText containsString:@"al:"]  ) {
            continue;
        }
        
        // 通过右边的中括号分解
        NSArray *timeAndLrc = [timeAndText componentsSeparatedByString:@"]"];
        
        // NSLog(@"%@",[timeAndLrc firstObject]);
        // 创建模型
        lrcModel *model = [[lrcModel alloc] init];
        model.lyric = [timeAndLrc lastObject];
        
        // 开始时间
        model.beginTime = [TimeTool timeWithString:[timeAndLrc firstObject]];
        
        [self.lrcArray addObject:model];
    }
    
    
    for (NSInteger i = 0; i < self.lrcArray.count; i++) {
        if (i == self.lrcArray.count - 1) {
            break;
        }
        
        lrcModel *model = self.lrcArray[i];
        lrcModel *nextModel = self.lrcArray[i + 1];
        model.endTime = nextModel.beginTime;
        
    }
    
    return self.lrcArray;
    
}

- (NSInteger)lrcReturnRowWithCurrentTime:(NSTimeInterval)currentTime currentLrc:(NSArray <lrcModel *> *)lrcs
{
    NSInteger count = lrcs.count;
    for (NSInteger i = 0; i < count; i++) {
        lrcModel *model = lrcs[i];
        if (currentTime < model.endTime && currentTime > model.beginTime)
        {
            return i;
        }
    }
    
    return 0;
}

#pragma mark ------------------------------
#pragma mark lazyLoading

- (NSMutableArray *)lrcArray
{
    if (!_lrcArray) {
        _lrcArray = [NSMutableArray array];
    }
    return _lrcArray;
}


@end
