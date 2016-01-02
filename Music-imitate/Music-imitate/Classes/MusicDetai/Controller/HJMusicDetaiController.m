//
//  HJMusicDetaiTVC.m
//  Music-imitate
//
//  Created by 张海军 on 15/5/3.
//  Copyright © 2015年 navyzhj. All rights reserved.
//

#import "HJMusicDetaiController.h"
#import "MusicOperationTool.h"
#import "MusicLrcTVC.h"
#import "lrcLabel.h"



#define kScreenW [UIScreen mainScreen].bounds.size.width

@interface HJMusicDetaiController () <UIScrollViewDelegate>
/// 底部大图片
@property (weak, nonatomic) IBOutlet UIImageView *BottomImage;
/// 歌手头像
@property (weak, nonatomic) IBOutlet HJImageView *singericon;
/// 用来显歌词的
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/// tableView
@property (nonatomic, weak) UITableView *tableView;
/// 歌曲名
@property (weak, nonatomic) IBOutlet UILabel *musicName;
/// 歌手名
@property (weak, nonatomic) IBOutlet UILabel *singetName;
/// 已经播放的时长
@property (weak, nonatomic) IBOutlet UILabel *costTime;
/// 总时长
@property (weak, nonatomic) IBOutlet UILabel *totalTime;
/// 歌词
@property (weak, nonatomic) IBOutlet lrcLabel *lyricLabel;
/// 播放按钮
@property (weak, nonatomic) IBOutlet UIButton *playBut;
/// 进度指示
@property (weak, nonatomic) IBOutlet UISlider *guage;


/// 定时器
@property (nonatomic, strong) NSTimer *time;
/// 总时长
@property (nonatomic, assign) NSTimeInterval totalTimer;
/// musicLrcTVC
@property (nonatomic, weak) MusicLrcTVC *musicLrc;
/// 牛逼的定时器
@property (nonatomic, strong) CADisplayLink *linkTime;

@end

@implementation HJMusicDetaiController
#pragma mark ------------------------------
#pragma mark lifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpInit];
    [self setUpOne];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self beginTimer];
    [self linkTime];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self endTimer];
    [self.linkTime invalidate];
    self.linkTime = nil;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.scrollView.contentSize = CGSizeMake(kScreenW * 2.0, 0);
    self.tableView.frame = self.scrollView.bounds;
    self.tableView.x = self.scrollView.width;
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark ------------------------------
#pragma mark Method
- (void)beginTimer
{
    NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(setUpTimes) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:time forMode:NSRunLoopCommonModes];
    self.time = time;
}
- (void)endTimer
{
    [self.time invalidate];
    self.time = nil;
}
/// 初始化的
- (void)setUpInit
{
    self.navigationController.hidesBottomBarWhenPushed = YES;
    // 添加歌词的tableView
    MusicLrcTVC *musicLrc = [[MusicLrcTVC alloc] init];
    [self addChildViewController:musicLrc];
    self.musicLrc = musicLrc;
    self.tableView = musicLrc.tableView;
    [self.scrollView addSubview:self.tableView];
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    
    self.playBut.selected = YES;
    [self.guage setThumbImage:[UIImage imageNamed:@"player_slider_playback_thumb"] forState:UIControlStateNormal];
    
}

/// 调用一次
- (void)setUpOne
{
    SongDetai *song = [[MusicOperationTool sharedMusicOperationTool] song];
    self.totalTimer = song.totalTimer;
    self.musicName.text = song.currentPlaySong.name;
    self.singetName.text = song.currentPlaySong.singer;
    self.singericon.image = [UIImage imageNamed:song.currentPlaySong.icon];
    self.BottomImage.image = [UIImage imageNamed:song.currentPlaySong.icon];
    self.totalTime.text = [TimeTool playMusicWithTiemer:song.totalTimer];
    self.musicLrc.models = song.lrcModels;
    [self beginRotate];
    
}

/// 多次调用
- (void)setUpTimes
{
    SongDetai *song = [MusicOperationTool sharedMusicOperationTool].song;
    NSTimeInterval currenTimer = song.currentTime;
    self.costTime.text = [TimeTool playMusicWithTiemer:currenTimer];
    self.guage.value = currenTimer / song.totalTimer;
    
    if (!song.isPlay) {
        [[MusicOperationTool sharedMusicOperationTool] netxMusic];
        [self setUpOne];
    }
}

/// 刷新歌词
- (void)updateLyric
{
    SongDetai *song = [[MusicOperationTool sharedMusicOperationTool] song];
    NSTimeInterval currenTimer = song.currentTime;
    NSInteger row = song.row;
    self.musicLrc.row = row;
    
    lrcModel *model = song.lrcModels[row];
    self.lyricLabel.text = model.lyric;
    self.lyricLabel.progress = (currenTimer - model.beginTime) / (model.endTime - model.beginTime);
    self.musicLrc.progress = self.lyricLabel.progress;
    
    [[MusicOperationTool sharedMusicOperationTool] setUpLockScreenInfo];
}

/// 开始旋转
- (void)beginRotate
{
    [self.singericon.layer removeAnimationForKey:@"basicSinger"];
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.z";
    animation.fromValue = @(0);
    animation.toValue = @(M_PI * 2.0);
    animation.duration = 30;
    animation.repeatCount = MAXFLOAT;
    [self.singericon.layer addAnimation:animation forKey:@"basicSinger"];
}
/// 暂停
- (void)pauseRotate
{
    [self.singericon.layer pauseAnimate];
}
/// 恢复
- (void)resumeRotate
{
    [self.singericon.layer resumeAnimate];
}

#pragma mark ------------------------------
#pragma mark lazyLoading
- (CADisplayLink *)linkTime
{
    if (!_linkTime) {
        _linkTime = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateLyric)];
        [_linkTime addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    return _linkTime;
}


#pragma mark ------------------------------
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float scale =1 - scrollView.contentOffset.x / scrollView.width;
    self.singericon.alpha = scale;
    self.lyricLabel.alpha = scale;
}



#pragma mark ------------------------------
#pragma mark clickEvent
/// touchUpInsid
- (IBAction)moveClick:(UISlider *)sender
{
    [self beginTimer];
    NSTimeInterval time = self.totalTimer * sender.value;
    [MusicOperationTool sharedMusicOperationTool].song.currentTime = time;
    self.costTime.text = [TimeTool playMusicWithTiemer:time];
    
}
/// valueChange
- (IBAction)valueChange:(UISlider *)sender
{
    [self endTimer];
    NSTimeInterval time = self.totalTimer * sender.value;
    [MusicOperationTool sharedMusicOperationTool].song.currentTime = time;
    self.costTime.text = [TimeTool playMusicWithTiemer:time];
    
}

/// 返回按钮
- (IBAction)backBut
{
    [self.navigationController popViewControllerAnimated:YES];
}

/// 更多按钮
- (IBAction)moreBut
{
    
}

/// 开始和暂停按钮
- (IBAction)playAndPause:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [[MusicOperationTool sharedMusicOperationTool] beginMusic];
        [self beginTimer];
        [self resumeRotate];
    }
    else
    {
        [[MusicOperationTool sharedMusicOperationTool] pauseMusic];
        [self endTimer];
        [self pauseRotate];
    }
}
/// 上一首
- (IBAction)upSong
{
    [[MusicOperationTool sharedMusicOperationTool] UpMusic];
    [self setUpOne];
}
/// 下一首
- (IBAction)nextSong
{
    [[MusicOperationTool sharedMusicOperationTool] netxMusic];
    [self setUpOne];
}

#pragma mark ------------------------------
#pragma mark 远程事件

- (void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    switch (event.subtype) {
        case UIEventSubtypeRemoteControlPlay:
        { // 播放
            [self playAndPause:self.playBut];
            break;
        }case UIEventSubtypeRemoteControlPause:
        { // 暂停
            [self playAndPause:self.playBut];
            break;
        }case UIEventSubtypeRemoteControlNextTrack:
        { // 下一首
            [self nextSong];
            break;
        }case UIEventSubtypeRemoteControlPreviousTrack:
        { // 上一首
            [self upSong];
            break;
        }
            
        default:
            break;
    }
    
}


@end
