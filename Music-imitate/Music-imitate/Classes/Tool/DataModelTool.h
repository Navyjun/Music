//
//  DataModelTool.h
//  QQ音乐
//
//  Created by nave on 15/5/3.
//  Copyright © 2015年 navyZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HJmusicItem;
@interface DataModelTool : NSObject

+ (void)dataModelWithMusicList:(void(^)(NSArray <HJmusicItem *> *items))items;

@end
