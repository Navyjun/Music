//
//  MusicCell.m
//  QQ音乐
//
//  Created by nave on 15/5/3.
//  Copyright © 2015年 naveZhang. All rights reserved.
//

#import "MusicCell.h"
#import "HJmusicItem.h"

@interface MusicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *musicTitle;

@property (weak, nonatomic) IBOutlet UILabel *singerNme;

@end

@implementation MusicCell
+ (instancetype)musicCellTableView:(UITableView *)tableView
{
    static NSString *ID = @"MusicCell";
    
    MusicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MusicCell" owner:nil options:nil] lastObject];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;

}


- (void)awakeFromNib
{
    
    self.icon.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void)setItem:(HJmusicItem *)item {
    _item = item;
    
    _icon.image = [UIImage imageNamed:item.singerIcon];
    _musicTitle.text = item.name;
    _singerNme.text = item.singer;
}

@end
