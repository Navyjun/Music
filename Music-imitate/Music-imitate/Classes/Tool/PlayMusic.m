//
//  PlayMusic.m
//  QQ音乐
//
//  Created by nave on 15/1/23.
//  Copyright © 2015年 naveZhang. All rights reserved.
//

#import "PlayMusic.h"


@interface PlayMusic ()

/** plaer */
@property (nonatomic, strong) AVAudioPlayer *player;

/** 当期播放的 */
@property (nonatomic, strong) NSURL *currentUrl;

@end

@implementation PlayMusic

- (AVAudioPlayer *)playMusicWithUrl:(NSString *)url
{
    NSURL *URLPath = [[NSBundle mainBundle] URLForResource:url withExtension:nil];
    
    // 容错出来
    if (URLPath == nil) {
        return nil;
    }
    
    // 如果是同一首继续播放
    if ([self.currentUrl.absoluteString isEqualToString:URLPath.absoluteString]) {
        [self.player play];
        return self.player;
    }
    self.currentUrl = URLPath;
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:URLPath error:nil];
    
    [self.player prepareToPlay];
    
    [self.player play];
    
    return self.player;
    
}

- (void)seekToPlayWithCurrentTime:(NSTimeInterval)currentTimer
{
    self.player.currentTime = currentTimer;
}

- (void)playPause
{
    [self.player pause];
}

- (void)playStop
{
    [self.player stop];
}



@end
