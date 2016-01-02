//
//  lrcModel.h
//  QQ音乐
//
//  Created by nave on 15/5/3.
//  Copyright © 2015年 naveZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface lrcModel : NSObject

/** 开始时间 */
@property (nonatomic, assign) float beginTime;
/** 结束时间 */
@property (nonatomic, assign) float endTime;
/** 歌词 */
@property (nonatomic, copy) NSString *lyric;

@end
