//
//  BackgroundView.h
//  打僵尸
//
//  Created by Ibokan on 15/10/5.
//  Copyright (c) 2015年 YueWen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GameOverBlock)(void);//游戏结束的回调
typedef void(^AddZombiesMoveSpeed)(void);//需要增加速度的回调

@interface BackgroundView : UIView

/**
 *  增加得分
 */
-(void)addScore;

/**
 *  增加在家的僵尸
 */
-(void)addNumberOfZombieInHome;


/**
 *  初始化所有的数据
 */
-(void)clear;


/**
 *  设置游戏结束时候的回调
 *
 *  @param grameOverBlock 游戏结束的回调
 */
-(void)backgroundGameOverBlockHandle:(GameOverBlock)gameOverBlock;


/**
 *  设置加速的回调
 *
 *  @param addZombiesMoveSpeed 加速回调
 */
-(void)backgroundAddZombiesMoveSpeed:(AddZombiesMoveSpeed)addZombiesMoveSpeed;

@end
