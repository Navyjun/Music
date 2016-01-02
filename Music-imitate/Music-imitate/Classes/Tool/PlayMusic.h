//
//  PlayMusic.h
//  QQ音乐
//
//  Created by nave on 15/1/23.
//  Copyright © 2015年 naveZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface PlayMusic : NSObject

- (AVAudioPlayer *)playMusicWithUrl:(NSString *)url;

- (void)seekToPlayWithCurrentTime:(NSTimeInterval)currentTimer;

- (void)playPause;

- (void)playStop;


@end
