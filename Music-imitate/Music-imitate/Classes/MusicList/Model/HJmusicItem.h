//
//  HJmusicItem.h
//  QQ音乐
//
//  Created by nave on 15/5/3.
//  Copyright © 2015年 naveZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJmusicItem : NSObject
/// 歌名
@property (nonatomic, copy) NSString *name;
/// 文件名
@property (nonatomic, copy) NSString *filename;
/// 歌词
@property (nonatomic, copy) NSString *lrcname;
/// 歌手名
@property (nonatomic, copy) NSString *singer;
/// 歌手头像
@property (nonatomic, copy) NSString *singerIcon;
/// 背景图片
@property (nonatomic, copy) NSString *icon;




@end
