//
//  MusicManager.m
//  打僵尸
//
//  Created by Ibokan on 15/10/6.
//  Copyright (c) 2015年 YueWen. All rights reserved.
//

#import "MusicManager.h"
#import <AVFoundation/AVFoundation.h>

@interface MusicManager ()

@property(nonatomic,strong)AVAudioPlayer * backgrountPlayer;
@property(nonatomic,strong)AVAudioPlayer * endMusicPlayer;
@property(nonatomic,strong)AVAudioPlayer * loseMusicPlayer;
@property(nonatomic,strong)AVAudioPlayer * beatMusicPlayer;

//加载所有的音乐播放器
-(void)loadAllMusic;

@end

@implementation MusicManager



- (instancetype)init
{
    self = [super init];
    if (self) {
        //初始化音乐
        [self loadAllMusic];
    }
    return self;
}


//单例方法
+(instancetype)shareMusicManager
{
    static MusicManager * musicManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        musicManager = [[MusicManager alloc]init];
    });
    
    return musicManager;
}




/**
 *  加载所有的音乐器
 */
-(void)loadAllMusic
{
    self.backgrountPlayer = [self loadPlayWithMusicName:@"bg" Type:@"mp3" WithNumbersOfLoop:-1];
    self.endMusicPlayer = [self loadPlayWithMusicName:@"end" Type:@"mp3" WithNumbersOfLoop:0];
    self.loseMusicPlayer = [self loadPlayWithMusicName:@"lose" Type:@"mp3" WithNumbersOfLoop:0];
    self.beatMusicPlayer = [self loadPlayWithMusicName:@"shieldhit2" Type:@"caf" WithNumbersOfLoop:0];
}


/**
 *  加载播放器
 *
 *  @param musicName 音乐名称
 *  @param musicType 音乐类型
 *
 *  @return 播放器地址
 */
-(AVAudioPlayer *)loadPlayWithMusicName:(NSString *)musicName Type:(NSString *)musicType WithNumbersOfLoop:(NSInteger)loop
{
    NSString * path = [[NSBundle mainBundle]pathForResource:musicName ofType:musicType];
    
    //转成url
    NSURL * url = [NSURL fileURLWithPath:path];
    
    //加载播放器
    AVAudioPlayer * player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    
    //设置播放次数
    player.numberOfLoops = loop;
    
    //准备播放
    [player prepareToPlay];
    
    //返回加载好的播放器
    return player;
}



/******************** 播放音乐的方法 ************************/
-(void)playStartMusic
{
    //背景音乐开启
    [self.backgrountPlayer play];
    
}

-(void)playEndMusic
{
    //背景音乐关闭
    [self.backgrountPlayer stop];
    //开启结束音乐
    [self.endMusicPlayer play];
}

-(void)playLoseMusic
{
    //背景音乐关
    [self.backgrountPlayer stop];
    //开启失败音乐
    [self.loseMusicPlayer play];
}

-(void)playBeatMusic
{
    //开启敲打音乐
    [self.beatMusicPlayer play];
}



@end
