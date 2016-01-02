//
//  MusicCell.h
//  QQ音乐
//
//  Created by nave on 15/5/3.
//  Copyright © 2015年 naveZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJmusicItem;
@interface MusicCell : UITableViewCell

/** 模型 */
@property (nonatomic, strong) HJmusicItem *item;

+ (instancetype)musicCellTableView:(UITableView *)tableView;

@end
