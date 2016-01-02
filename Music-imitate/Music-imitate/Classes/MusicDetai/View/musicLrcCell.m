//
//  musicLrcCell.m
//  QQ音乐
//
//  Created by nave on 15/5/3.
//  Copyright © 2015年 naveZhang. All rights reserved.
//

#import "musicLrcCell.h"

@interface musicLrcCell ()




@end

@implementation musicLrcCell
+ (instancetype)musicLrcCellTableView:(UITableView *)tableView
{
    static NSString *ID = @"musicLrcTVC";
    
    musicLrcCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"musicLrcCell" owner:nil options:nil] lastObject];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)setProgress:(double)progress
{
    _progress = progress;
    self.title_label.progress = progress;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
