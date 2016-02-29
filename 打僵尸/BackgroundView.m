//
//  BackgroundView.m
//  打僵尸
//
//  Created by Ibokan on 15/10/5.
//  Copyright (c) 2015年 YueWen. All rights reserved.
//

#import "BackgroundView.h"
#import "DEFINE.h"

@interface BackgroundView ()

@property (nonatomic,assign)NSInteger score;//得分
@property (nonatomic,assign)NSInteger bgTag;//得分速度的标志位

@property (nonatomic,assign)NSInteger numberOfZombiesInHome;//在家中的僵尸数量

@property (strong, nonatomic) IBOutlet UILabel *lblNumberOfZombiesInHome;

@property (strong, nonatomic) IBOutlet UILabel *lblScore;

@property (nonatomic,strong)GameOverBlock  gameOverBlock;
@property (nonatomic,strong)AddZombiesMoveSpeed addZombiesMoveSpeed;

@end

@implementation BackgroundView

//代码创建是运行的方法
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self backgroundViewInit];
    }
    return self;
}

//用xib或者stroyboard加载运行的方法
-(void)awakeFromNib
{
    [self backgroundViewInit];
}


//自定义的背景视图加载方法
-(void)backgroundViewInit
{
    self.bgTag = 0;//标志位为0
    self.score = 0;//初始化分数为0
    self.numberOfZombiesInHome = 0;//初始化进入房屋的僵尸个数为0
    
    /*********初始化标签的title*********/
    self.lblNumberOfZombiesInHome.text = [NSString stringWithFormat:@"家中的僵尸数量:   %ld",self.numberOfZombiesInHome];
    self.lblScore.text = [NSString stringWithFormat:@"得分:   %ld",self.score];

}

//为游戏结束代码块赋值
-(void)backgroundGameOverBlockHandle:(GameOverBlock)gameOverBlock
{
    self.gameOverBlock = gameOverBlock;
}

//为增加僵尸速度代码块赋值
-(void)backgroundAddZombiesMoveSpeed:(AddZombiesMoveSpeed)addZombiesMoveSpeed
{
    self.addZombiesMoveSpeed = addZombiesMoveSpeed;
}


/**
 *  加分的方法
 */
-(void)addScore
{
    self.score ++;
    self.lblScore.text = [NSString stringWithFormat:@"得分是:   %ld",self.score];
    
    //如果满 宏 定义的数量，那么取余必然会与标志位不符合
    if (self.score % ADD_SPEED_STAND != self.bgTag)
    {
        //重置标志位
        self.bgTag = self.score % ADD_SPEED_STAND;
        
        //回调加速
        if (self.addZombiesMoveSpeed)
        {
            self.addZombiesMoveSpeed();
        }
    }
    
}

-(void)addNumberOfZombieInHome
{
    self.numberOfZombiesInHome++;
    self.lblNumberOfZombiesInHome.text = [NSString stringWithFormat:@"家中的僵尸数量:   %ld",self.numberOfZombiesInHome];
    
    //在家的僵尸等于游戏结束的数值的时候
    if (self.numberOfZombiesInHome == GAMEOVERCOUNT)
    {
        //执行回调
        if (self.gameOverBlock)
        {
            self.gameOverBlock();
        }
    }
}

-(void)clear
{
    [self backgroundViewInit];
}

@end
