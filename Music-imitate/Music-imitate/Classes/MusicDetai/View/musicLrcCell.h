//
//  musicLrcCell.h
//  QQ音乐
//
//  Created by nave on 15/5/3.
//  Copyright © 2015年 naveZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lrcLabel.h"

@interface musicLrcCell : UITableViewCell

@property (weak, nonatomic) IBOutlet lrcLabel *title_label;

+ (instancetype)musicLrcCellTableView:(UITableView *)tableView;

/** 进度 */
@property (nonatomic, assign) double progress;

@end
