//
//  MusicOperationTool.h
//  QQ音乐
//
//  Created by nave on 15/1/23.
//  Copyright © 2015年 naveZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJmusicItem.h"
#import "PlayMusic.h"
#import "lrcModel.h"
#import "TimeTool.h"
#import "lrcTool.h"
#import "Single.h"

@interface SongDetai :NSObject
/// 当前歌曲的已播放的时间
@property (nonatomic, assign) NSTimeInterval currentTime;
/// 当前歌曲的总时间
@property (nonatomic, assign) NSTimeInterval totalTimer;
/// 当前歌曲的信息
@property (nonatomic, weak) HJmusicItem *currentPlaySong;
/// 歌词模型数组
@property (nonatomic, strong) NSArray *lrcModels;
/// 当前歌词属于哪一行
@property (nonatomic, assign) NSInteger row;
/// 是否正在播放
@property (nonatomic, assign) BOOL isPlay;

@end

@interface MusicOperationTool : NSObject
SingleH(MusicOperationTool);
/// 歌曲详情模型
@property (nonatomic, strong) SongDetai *song;


/// 播放选中的音乐
- (void)playWithSelectMusic:(NSIndexPath *)indexPath list:(NSArray *)musics;
/// 锁屏界面信息
- (void)setUpLockScreenInfo;
/// 开始播放
- (void)beginMusic;
/// 暂停播放
- (void)pauseMusic;
/// 下一首
- (void)netxMusic;
/// 上一首
- (void)UpMusic;

@end
