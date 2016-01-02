//
//  MusicLrcTVC.m
//  QQ音乐
//
//  Created by nave on 15/5/3.
//  Copyright © 2015年 naveZhang. All rights reserved.
//

#import "MusicLrcTVC.h"
#import "lrcModel.h"
#import "musicLrcCell.h"

@interface MusicLrcTVC ()

@end

@implementation MusicLrcTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tableView.contentInset = UIEdgeInsetsMake(self.tableView.height * 0.5, 0, self.tableView.height * 0.5, 0);
}

#pragma mark ------------------------------
#pragma mark lazyLoading
- (void)setModels:(NSArray *)models
{
    _models = models;
    [self.tableView reloadData];
}

- (void)setProgress:(double)progress
{
    
    _progress = progress;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.row inSection:0];
    musicLrcCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.progress = progress;
    
}

- (void)setRow:(NSInteger)row
{
    // 外面的定时器是一秒钟60次的 所以在同一行的时候是不需要在做任何事情的
    if (_row == row) {
        return;
    }
    
    _row = row;
    
    
   NSIndexPath *indexPath = [NSIndexPath indexPathForItem:row inSection:0];
    
    // 刷新表格  indexPathsForVisibleRows 可见的行数
    [self.tableView reloadRowsAtIndexPaths:[self.tableView indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationNone];
    
    // 滚动到哪一行
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
    
    
}

#pragma mark ------------------------------
#pragma mark UITableViewDateSoure
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    musicLrcCell *cell = [musicLrcCell musicLrcCellTableView:tableView];
    lrcModel *model = self.models[indexPath.row];
    cell.title_label.text = model.lyric;
    
    if (indexPath.row == self.row) {
        cell.progress = self.progress;
    }else
    {
        cell.progress = 0;
    }
    
    
    return cell;
}



@end
