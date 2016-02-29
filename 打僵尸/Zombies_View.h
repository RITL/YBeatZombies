//
//  Zombies_View.h
//  打僵尸
//
//  Created by Ibokan on 15/10/6.
//  Copyright (c) 2015年 YueWen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef CGFloat Speed;

typedef void(^ZombiesBeatBlock)(void);
typedef void(^ZombiesIntoHomeBlock)(void);

@interface Zombies_View : UIView

/**
 *  加载僵尸视图
 *
 *  @param zombies 存储僵尸对象的数组
 */
-(void)startLoadZombiesView:(NSArray *)zombies;


/**
 *  设置僵尸被敲击的回调
 *
 *  @param zombieBeatBlock 被敲击时执行的方法
 */
-(void)zombiesBeatBlockHandle:(ZombiesBeatBlock)zombieBeatBlock;


/**
 *  设置僵尸进入家中的回调
 *
 *  @param zombieIntoHomeBlock 进入家中时执行的回调
 */
-(void)zombiesIntoHomeBlockHandle:(ZombiesIntoHomeBlock)zombieIntoHomeBlock;


/**
 *  计时器停止
 */
-(void)zombiesStopMove;


/**
 *  结束所有的僵尸视图的响应
 */
-(void)endAllZombiesEditing;

/**
 *  加快僵尸移动的速度
 *
 *  @param speed 加快的速度 */
-(void)addZombiesMoveSpeed:(Speed)speed;

@end
