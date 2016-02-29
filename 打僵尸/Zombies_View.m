//
//  Zombies_View.m
//  打僵尸
//
//  Created by Ibokan on 15/10/6.
//  Copyright (c) 2015年 YueWen. All rights reserved.
//

#import "Zombies_View.h"
#import "ZombieView.h"
#import "BaseZombie.h"
#import "DEFINE.h"


@interface Zombies_View ()

@property(nonatomic,strong)NSMutableArray * zombieViews;//里面存的是僵尸view对象
@property(nonatomic,strong)NSTimer * timer;//计时器
@property(nonatomic,assign)Speed speed;//控制僵尸移动的速度

@property(nonatomic,strong)ZombiesBeatBlock zombiesBeatBlock;
@property(nonatomic,strong)ZombiesIntoHomeBlock zombiesIntoHomeBlock;
@end

@implementation Zombies_View

#pragma mark - 相关属性的赋值

-(void)zombiesBeatBlockHandle:(ZombiesBeatBlock)zombieBeatBlock
{
    self.zombiesBeatBlock = zombieBeatBlock;
}

-(void)zombiesIntoHomeBlockHandle:(ZombiesIntoHomeBlock)zombieIntoHomeBlock
{
    self.zombiesIntoHomeBlock = zombieIntoHomeBlock;
}



#pragma mark - 相关创建的方法
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //初始化数组
        self.zombieViews = [NSMutableArray array];
        
        //初始化僵尸的速度
        self.speed = ZOMBIE_MOVE_SPEED;

    }
    return self;
}

/**
 *  根据僵尸类型创建随机点
 *
 *  @param zombie 僵尸对象
 *
 *  @return 随机创建的点
 */
-(CGPoint)randomPointWithZombieView:(BaseZombie *)zombie
{
    
    //屏幕的宽
    NSInteger width = self.bounds.size.width;
    //屏幕的高
    NSInteger height = self.bounds.size.height;
    
    //获得随机的center
    NSInteger x = arc4random()%(width - zombie.zombiesFrameWidth) + width;//让其移动到右侧屏幕外
    NSInteger y = arc4random()%(height - zombie.zombiesFrameHeight) + zombie.zombiesFrameHeight/2;
    
    return CGPointMake(x, y);
}


#pragma mark - 功能方法

/**
 *  开始加载僵尸视图
 *
 *  @param zombies 存僵尸对象的数组
 */
-(void)startLoadZombiesView:(NSArray *)zombies
{
    
    //加载僵尸视图对象
    [self loadZombiesViewsWithArray:zombies];
    
    //启动定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:TIMER_SPEED target:self selector:@selector(moveAllZombie) userInfo:nil repeats:YES];
}


/**
 *  根据存放僵尸对象数组 处理成 存储僵尸视图的 数组
 *
 *  @param zombies 存放僵尸对象的数组
 */
-(void)loadZombiesViewsWithArray:(NSArray *)zombies
{
    for (NSInteger i = 0; i < zombies.count; i++)
    {
        //初始化一个僵尸视图
        ZombieView * zombieView = [[ZombieView alloc]initWithZombie:zombies[i] WithOrigin:[self randomPointWithZombieView:zombies[i]]];
        
        //报告VC已经被敲击
        [zombieView doneWithZombiePressedHandleBlock:^{
       
            //实现回调，敲击声音
            if (self.zombiesBeatBlock)
            {
                self.zombiesBeatBlock();
            }
                
            //被点击之后的动画效果
            [self zombiesDidBeat:zombieView];
            
        }];
         
        //添加视图数组
        [self.zombieViews addObject:zombieView];
        
        //添加视图
        [self addSubview:zombieView];

    }
}


/**
 *  单个僵尸移动
 *
 *  @param zombieView 移动的僵尸视图对象
 */
-(void)moveZombie:(ZombieView *)zombieView
{
    //首先获得视图的中心点
    CGPoint point = zombieView.center;
    
    //说明已经进入了家，重新分配位置
    if (point.x <= -1 * zombieView.bounds.size.width / 2)
    {
        //重新分配位置
        zombieView.center = [self randomPointWithZombieView:zombieView.zombie];
        
        //并且执行进入家的回调方法
        if (self.zombiesIntoHomeBlock)
        {
            self.zombiesIntoHomeBlock();
        }
    }
    //前进
    else
    {
        //point坐标减
        point.x -= self.speed;
        
        zombieView.center = point;
    }
}

/**
 *  所有的僵尸视图移动
 */
-(void)moveAllZombie
{
    for (ZombieView * zombieView in self.zombieViews)
    {
        [self moveZombie:zombieView];
    }
}

/**
 *  僵尸被点击的时候实现的动画效果
 *
 *  @param zombieView 被点击的僵尸
 */
-(void)zombiesDidBeat:(ZombieView *)zombieView
{
    //实现缩放2倍大小.0.25秒之内完成
    [UIView animateWithDuration:0.25 animations:^{
        
        //获取仿射对象
        CGAffineTransform transForm = CGAffineTransformMakeScale(2, 2);
        
        //赋值
        zombieView.transform = transForm;
        
    } completion:^(BOOL finished) {

        //实现缩放0.5，0.25秒完成
        [UIView animateWithDuration:0.25 animations:^{
            
            //获取仿射对象
            CGAffineTransform transform = CGAffineTransformMakeScale(0.5, 0.5);
            
            //赋值
            zombieView.transform = transform;
            
        } completion:^(BOOL finished) {
            
            //重新分配位置
            zombieView.center = [self randomPointWithZombieView:zombieView.zombie];
            
            /*恢复原来大小*/
            zombieView.transform = CGAffineTransformIdentity;

        }];
    }];
}

/**
 *  僵尸停止移动
 */
-(void)zombiesStopMove
{
    //销毁计时器
    [self.timer invalidate];
}

/**
 *  gameOver之后让僵尸不可点
 */
-(void)endAllZombiesEditing
{
    for (ZombieView * zombieView in self.zombieViews)
    {
        //不能人机交互
        zombieView.userInteractionEnabled = NO;
    }
}

/**
 *  加快僵尸移动的速度
 *
 *  @param speed 加快的速度 */
-(void)addZombiesMoveSpeed:(Speed)speed
{
    if (speed >= 0)
    {
        self.speed += speed;
    }
}

@end
