//
//  DataModelTool.m
//  QQ音乐
//
//  Created by nave on 15/5/3.
//  Copyright © 2015年 naveZhang. All rights reserved.
//

#import "DataModelTool.h"
#import "HJmusicItem.h"
#import "MJExtension.h"

@implementation DataModelTool

+ (void)dataModelWithMusicList:(void (^)(NSArray<HJmusicItem *> *))items
{
    NSArray *itemsArray = [HJmusicItem mj_objectArrayWithFilename:@"Musics.plist"];
    
    items(itemsArray);
    
}

@end
