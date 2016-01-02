//
//  MusicOperationTool.m
//  QQ音乐
//
//  Created by nave on 15/1/23.
//  Copyright © 2015年 naveZhang. All rights reserved.
//

#import "MusicOperationTool.h"
#import "HJmusicItem.h"
#import <MediaPlayer/MediaPlayer.h>

@interface SongDetai ()
/// playMusic
@property (nonatomic, weak) PlayMusic *playM;

@end

@implementation SongDetai

- (void)setCurrentTime:(NSTimeInterval)currentTime
{
    _currentTime = currentTime;
    [self.playM seekToPlayWithCurrentTime:currentTime];
}

@end


@interface MusicOperationTool ()
/// music模型数组
@property (nonatomic, strong) NSArray *musics;
/// 当前播放的music
@property (nonatomic, copy) NSString *currentMusicUrl;
/// fileNames
@property (nonatomic, strong) NSMutableArray *fileNames;
/// 当前播放歌曲
@property (nonatomic, assign) NSInteger countNumber;
/// playMusic 
@property (nonatomic, strong) PlayMusic *playM;
/// 播放器
@property (nonatomic, strong) AVAudioPlayer *player;


@end

@implementation MusicOperationTool
SingleM(MusicOperationTool);
- (void)playWithSelectMusic:(NSIndexPath *)indexPath list:(NSArray *)musics
{
    self.countNumber = indexPath.row;
    HJmusicItem *item = musics[self.countNumber];
    NSString *url = item.filename;
    
    [self playMusic:url];
    
    self.currentMusicUrl = item.filename;
    self.musics = musics;
}

- (void)playMusic:(NSString *)fileName
{
    self.playM = [[PlayMusic alloc] init];
    self.player = [self.playM playMusicWithUrl:fileName];
}

- (void)beginMusic
{
    [self.player play];
}

- (void)pauseMusic
{
    [self.player pause];
}


- (void)netxMusic
{
    self.countNumber -= 1;
    self.currentMusicUrl = self.fileNames[self.countNumber];
    [self playMusic:self.currentMusicUrl];
}

- (void)UpMusic
{
    self.countNumber -= 1;
    self.currentMusicUrl = self.fileNames[self.countNumber];
    [self playMusic:self.currentMusicUrl];
}


#pragma mark ------------------------------
#pragma mark lazyLoading
- (void)setMusics:(NSArray *)musics
{
    _musics = musics;
    
    for (HJmusicItem *item in musics) {
        
        [self.fileNames addObject:item.filename];
       
    }
   
}

- (NSMutableArray *)fileNames
{
    if (!_fileNames) {
        _fileNames = [NSMutableArray array];
    }
    return _fileNames;
}

- (void)setCountNumber:(NSInteger)countNumber
{
    if (countNumber < 0) {
        countNumber = self.musics.count - 1;
    }
    else if (countNumber == self.musics.count)
    {
        countNumber = 0;
    }
        
    _countNumber = countNumber;
}



- (SongDetai *)song
{
    HJmusicItem *item = self.musics[self.countNumber];
    SongDetai *song = [[SongDetai alloc] init];
    song.currentPlaySong = item;
    
    song.currentTime = self.player.currentTime;
    song.totalTimer = self.player.duration;
    song.isPlay = self.player.isPlaying;
    
    lrcTool *tool = [[lrcTool alloc] init];
    song.lrcModels = [tool lrcToStringArray:item.lrcname];
    
    song.row = [tool lrcReturnRowWithCurrentTime:self.player.currentTime currentLrc:song.lrcModels];
    song.playM = self.playM;
    return song;
}

#pragma mark ------------------------------
#pragma mark 锁屏界面的信息
- (void)setUpLockScreenInfo
{
    HJmusicItem *item = self.song.currentPlaySong;
    lrcModel *lrc = self.song.lrcModels[self.song.row];
    
    // 1.获取锁屏中心
    MPNowPlayingInfoCenter *infoCenter = [MPNowPlayingInfoCenter defaultCenter];
    
    // MPMediaItemPropertyAlbumTitle
    // MPMediaItemPropertyAlbumTrackCount
    // MPMediaItemPropertyAlbumTrackNumber
    // MPMediaItemPropertyArtist   艺术家
    // MPMediaItemPropertyArtwork
    // MPMediaItemPropertyComposer
    // MPMediaItemPropertyDiscCount
    // MPMediaItemPropertyDiscNumber
    // MPMediaItemPropertyGenre
    // MPMediaItemPropertyPersistentID
    // MPMediaItemPropertyPlaybackDuration
    // MPMediaItemPropertyTitle
    // MPNowPlayingInfoPropertyElapsedPlaybackTime
    
    NSString *currentLrc = lrc.lyric;
    UIImage *image = [UIImage image:[UIImage imageNamed:item.icon] andText:currentLrc];
    // 2.设置锁屏界面的信息
    NSMutableDictionary *playInfoDic = [NSMutableDictionary dictionary];
    playInfoDic[MPMediaItemPropertyAlbumTitle] = item.name;
    playInfoDic[MPMediaItemPropertyArtist] = item.singer;
    playInfoDic[MPMediaItemPropertyArtwork] = [[MPMediaItemArtwork alloc] initWithImage:image];
    playInfoDic[MPMediaItemPropertyPlaybackDuration] = @(self.song.totalTimer);
    playInfoDic[MPNowPlayingInfoPropertyElapsedPlaybackTime] = @(self.song.currentTime);
    
    
    infoCenter.nowPlayingInfo = playInfoDic;
    
    // 3.让应用程序可以接受远程时间
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
}


@end
