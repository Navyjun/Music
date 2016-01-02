//
//  TableViewController.m
//  Music-imitate
//
//  Created by 张海军 on 15/5/3.
//  Copyright © 2015年 navyzhj. All rights reserved.
//

#import "HJMusicListTVC.h"
#import "HJmusicItem.h"
#import "DataModelTool.h"
#import "MusicCell.h"
#import "MusicOperationTool.h"
#import "PlayMusic.h"
#import <AVFoundation/AVFoundation.h>

@interface HJMusicListTVC ()
{
    /** 模型数组 */
    NSArray *_musicModels;
}

/** <#注释#> */
@property (nonatomic, strong) PlayMusic *play;

/** plaer */
@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation HJMusicListTVC
#pragma mark ------------------------------
#pragma mark life circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpInit];
    
    [self dataload];
    
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // 背景图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"QQListBack"];
    self.tableView.backgroundView = imageView;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark ------------------------------
#pragma mark Method
- (void)setUpInit
{
    // 隐藏导航栏
    self.navigationController.navigationBarHidden = YES;
    self.tableView.rowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)dataload
{
    [DataModelTool dataModelWithMusicList:^(NSArray<HJmusicItem *> *items) {
        self.musicModels = items;
    }];
}


#pragma mark ------------------------------
#pragma mark UItableViewDateSoure
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.musicModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MusicCell *cell = [MusicCell musicCellTableView:tableView];
    cell.item = _musicModels[indexPath.row];
    
    // 添加一些动画
    [cell.layer removeAnimationForKey:@"cell"];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.rotation.y";
    animation.values = @[@(M_PI * 0.5),@(0)]; // ,@(-1),@(0)
    animation.duration = 0.5;
    [cell.layer addAnimation:animation forKey:@"cell"];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [[MusicOperationTool sharedMusicOperationTool] playWithSelectMusic:indexPath list:_musicModels];
    
    [self performSegueWithIdentifier:@"toMusicDetail" sender:nil];
   
}

#pragma mark ------------------------------
#pragma mark lazy loading
- (NSArray *)musicModels
{
    if (!_musicModels) {
        _musicModels = [NSArray array];
    }
    return _musicModels;
    
}
- (void)setMusicModels:(NSArray *)musicModels
{
    _musicModels = musicModels;
    [self.tableView reloadData];
}



@end
