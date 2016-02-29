//
//  MusicManager.h
//  打僵尸
//
//  Created by Ibokan on 15/10/6.
//  Copyright (c) 2015年 YueWen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicManager : NSObject


/**
 *  获得单例的方法
 *
 *  @return 单例对象
 */
+(instancetype)shareMusicManager;

/**
 *  播放开始时的背景音乐
 */
-(void)playStartMusic;


/**
 *  播放结束的音乐
 */
-(void)playEndMusic;


/**
 *  播放失败的音乐
 */
-(void)playLoseMusic;


/**
 *  播放僵尸被敲打的声音
 */
-(void)playBeatMusic;

@end
