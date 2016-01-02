//
//  MusicLrcTVC.h
//  QQ音乐
//
//  Created by nave on 15/5/3.
//  Copyright © 2015年 naveZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicLrcTVC : UITableViewController
/** models */
@property (nonatomic, strong) NSArray *models;
/** row */
@property (nonatomic, assign) NSInteger row;
/** 进度 */
@property (nonatomic, assign) double progress;
@end
