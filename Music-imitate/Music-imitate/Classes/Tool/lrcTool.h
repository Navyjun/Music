//
//  lrcTool.h
//  QQ音乐
//
//  Created by nave on 15/5/3.
//  Copyright © 2015年 naveZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class lrcModel;

@interface lrcTool : NSObject

- (NSArray *)lrcToStringArray:(NSString *)lrcName ;

- (NSInteger)lrcReturnRowWithCurrentTime:(NSTimeInterval)currentTime currentLrc:(NSArray <lrcModel *> *)lrcs;

@end
