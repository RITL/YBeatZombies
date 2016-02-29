//
//  ZombieType4.m
//  打僵尸
//
//  Created by Ibokan on 15/10/6.
//  Copyright (c) 2015年 YueWen. All rights reserved.
//

#import "ZombieType4.h"

@implementation ZombieType4

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //为框架赋值
        self.zombiesFrameHeight = 72;
        self.zombiesFrameWidth = 83;
        
        //图片的数量
        self.zombiesFrameCount = 15;
        
    }
    return self;
}

@end
