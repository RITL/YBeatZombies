//
//  GameOverView.h
//  打僵尸
//
//  Created by Ibokan on 15/10/7.
//  Copyright (c) 2015年 YueWen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^gameOverRestartBlock)(void);

@interface GameOverView : UIView


/**
 *  开始出现动画
 *
 *  @param superView 父视图
 */
-(void)startAnimateWithView:(UIView *)superView;


/**
 *  设置重新开始游戏的回调
 *
 *  @param gameOverRestartBlock 回调方法
 */
-(void)gameOverRestartBlockHandle:(gameOverRestartBlock)gameOverRestartBlock;

@end
