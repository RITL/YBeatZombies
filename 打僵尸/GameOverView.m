//
//  GameOverView.m
//  打僵尸
//
//  Created by Ibokan on 15/10/7.
//  Copyright (c) 2015年 YueWen. All rights reserved.
//

#import "GameOverView.h"

@interface GameOverView ()

//显示失败头像的imageView
@property(nonatomic,strong)UIImageView * imageView;

//游戏结束的Block回调
@property(nonatomic,strong)gameOverRestartBlock b;

@end

@implementation GameOverView


//代码实现创建的方法
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self gameOverViewInit];
    }
    
    return self;
}

//xib和storyboard创建的方法
-(void)awakeFromNib
{
    [self gameOverViewInit];
}


/**
 *  自定义的创建方法
 */
-(void)gameOverViewInit
{
    //重置大小
    self.frame = CGRectMake(0, 0, 141, 180);
    
    //初始化imageView
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 141, 117)];

    //设置图片
    [self.imageView setImage:[UIImage imageNamed:@"ZombiesWon.png"]];
    
    //添加图片
    [self addSubview:self.imageView];

}

//设置回调代码块的方法
-(void)gameOverRestartBlockHandle:(gameOverRestartBlock)gameOverRestartBlock
{
    self.b = gameOverRestartBlock;
}


//最后失败跳出动画
-(void)startAnimateWithView:(UIView *)superView;
{
    //设置自己的中心点
    self.center = CGPointMake(superView.bounds.size.width / 2, superView.bounds.size.height / 2);
    
    //将自己添加到父视图上
    [superView addSubview:self];
    
    
    //实现动画
    [UIView animateWithDuration:1.0 animations:^{
        
        //创建一个仿射对象
        CGAffineTransform transform = CGAffineTransformMakeScale(2, 2);
        
        //赋值
        self.transform = transform;
        
    } completion:^(BOOL finished) {
        
        //创建一个重新来过的按钮
        UIButton * button = [self loadRestartButton];
        
        //添加button
        [self addSubview:button];
        
    }];
}

/**
 *  创建一个重新来过的按钮
 *
 *  @return 创建备好的按钮
 */
-(UIButton *)loadRestartButton
{
    //创建一个重新来过的button
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //设置frame
    button.frame = CGRectMake(0, 0, 126, 26);
    
    //设置图片
    [button setBackgroundImage:[UIImage imageNamed:@"a.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"aHighlight.png"] forState:UIControlStateHighlighted];
    
    //设置中心
    button.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2 + 50);
    
    //设置目标动作回调
    [button addTarget:self action:@selector(restartGame) forControlEvents:UIControlEventTouchUpInside];
    
    //设置title
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:10];
    [button setTitle:@"大侠请重新来过0.0" forState:UIControlStateNormal];
    
    return button;
    
}


//重新开始游戏
-(void)restartGame
{
    //回调方法
    if (self.b) {
        self.b();
    }
}

@end
