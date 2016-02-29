//
//  ZombieType1.m
//  打僵尸
//
//  Created by Ibokan on 15/10/6.
//  Copyright (c) 2015年 YueWen. All rights reserved.
//

#import "ZombieType1.h"

@implementation ZombieType1

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //为框架赋值
        self.zombiesFrameHeight = 72;
        self.zombiesFrameWidth = 83;
        
        //图片的数量
        self.zombiesFrameCount = 31;
        
    }
    return self;
}

@end
