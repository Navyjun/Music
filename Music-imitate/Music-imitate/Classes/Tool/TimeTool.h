//
//  TimeTool.h
//  QQ音乐
//
//  Created by nave on 15/5/3.
//  Copyright © 2015年 naveZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeTool : NSObject

+ (NSString *)playMusicWithTiemer:(NSTimeInterval)timer;

+ (float)timeWithString:(NSString *)timeString;
@end
