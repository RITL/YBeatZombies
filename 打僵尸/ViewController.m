//
//  ViewController.m
//  打僵尸
//
//  Created by Ibokan on 15/10/5.
//  Copyright (c) 2015年 YueWen. All rights reserved.
//

#import "ViewController.h"
#import "MusicManager.h"
#import "ZombieManager.h"
#import "Zombies_View.h"
#import "BackgroundView.h"
#import "GameOverView.h"
#import "DEFINE.h"

@interface ViewController ()

@property(nonatomic,strong)BackgroundView * backgroundView;//背景view,负责报告加速以及结束游戏
@property(nonatomic,strong)MusicManager * musicManager;//负责控制播放音乐
@property(nonatomic,strong)ZombieManager * zombieManager;//负责控制僵尸对象
@property(nonatomic,strong)Zombies_View * zombies_view;//负责显示显示僵尸对象以及敲击事件
@property(nonatomic,strong)GameOverView * gameOverView;//负责显示结束游戏界面以及重新游戏的回调

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    //加载音乐管理器
    self.musicManager = [MusicManager shareMusicManager];
    
    //加载僵尸管理器
    self.zombieManager = [ZombieManager shareZombieManager];
    
    //加载除了管理器的其他组件
    [self loadExceptManager];

}

/**
 *  加载除了管理器的其他组件
 */
-(void)loadExceptManager
{
    //加载背景视图
    self.backgroundView = [[[NSBundle mainBundle] loadNibNamed:@"BackgroundView" owner:nil options:nil] lastObject];
    self.backgroundView.frame = self.view.bounds;
    
    //加载僵尸管理控制器
    self.zombies_view = [[Zombies_View alloc]initWithFrame:self.view.bounds];
    
    //加载结束视图
    self.gameOverView = [[GameOverView alloc]initWithFrame:CGRectZero];
    
    //避免强引用循环
    __block __weak ViewController * copy_self = self;
    
    //僵尸视图被点击的时候回调
    [self.zombies_view zombiesBeatBlockHandle:^{
        
        //音乐管理器播放被敲击的声音
        [copy_self.musicManager playBeatMusic];
        
        //背景分数增加
        [copy_self.backgroundView addScore];
        
    }];
    
    //僵尸进入家进行的回调
    [self.zombies_view zombiesIntoHomeBlockHandle:^{
        
        //背景进入家中的僵尸数量增加
        [copy_self.backgroundView addNumberOfZombieInHome];
        
    }];
    
    //加载完毕僵尸后的回调
    [self.zombieManager setZombieManagerLoadFinishHandleBlock:^(NSArray *zombies) {
        
        //开始转换成视图僵尸
        [copy_self.zombies_view startLoadZombiesView:zombies];
    }];
    
    //游戏加速的回调
    [self.backgroundView backgroundAddZombiesMoveSpeed:^{
       
        //僵尸视图加速
        [copy_self.zombies_view addZombiesMoveSpeed:ZOMBIE_ADD_SPEED];
        
    }];
    
    
    //游戏结束时候的回调
    [self.backgroundView backgroundGameOverBlockHandle:^{
        
        //结束游戏音乐开启
        [copy_self.musicManager playLoseMusic];
        
        //僵尸原地不动
        [copy_self.zombies_view zombiesStopMove];
        
        //结束僵尸视图的响应
        [copy_self.zombies_view endAllZombiesEditing];
        
        //结束视图播放
        [copy_self.gameOverView startAnimateWithView:copy_self.view];
    }];
    
    
    //结束后点击重新开始的方法
    [self.gameOverView gameOverRestartBlockHandle:^{
        
        [self loadExceptManager];
        
    }];
    
    [self.musicManager playStartMusic];
    
    //添加控件
    [self.view addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.zombies_view];

}

/**
 *  隐藏偏好状态栏
 *
 *  @return YES表示隐藏，默认为NO
 */
-(BOOL)prefersStatusBarHidden
{
    return YES;
}


//禁止横屏
-(BOOL)shouldAutorotate
{
    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
