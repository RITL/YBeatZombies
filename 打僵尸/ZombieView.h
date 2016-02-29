//
//  ZombieView.h
//  打僵尸
//
//  Created by Ibokan on 15/10/6.
//  Copyright (c) 2015年 YueWen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseZombie.h"

typedef void(^zombiePressedBlock)(void);


@interface ZombieView : UIImageView

/**
 *  存储展示的僵尸类型
 */
@property(nonatomic,strong,readonly)BaseZombie * zombie;

/**
 *  根据僵尸图片的大小进行创建
 *
 *  @param zombie 僵尸对象
 *  @param origin 中心店
 */
-(instancetype)initWithZombie:(BaseZombie *)zombie WithOrigin:(CGPoint)origin;


/**
 *  为回调赋值
 *
 *  @param zombiePressedBlock 回调代码块
 */
-(void)doneWithZombiePressedHandleBlock:(zombiePressedBlock)zombiePressedBlock;

@end
