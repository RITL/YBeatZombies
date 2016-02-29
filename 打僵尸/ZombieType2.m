//
//  ZombieType2.m
//  打僵尸
//
//  Created by Ibokan on 15/10/6.
//  Copyright (c) 2015年 YueWen. All rights reserved.
//

#import "ZombieType2.h"

@implementation ZombieType2

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //为框架赋值
        self.zombiesFrameHeight = 109;
        self.zombiesFrameWidth = 174;
    
        //图片的数量
        self.zombiesFrameCount = 25;
    }
    return self;
}


@end
