//
//  ZombieView.m
//  打僵尸
//
//  Created by Ibokan on 15/10/6.
//  Copyright (c) 2015年 YueWen. All rights reserved.
//

#import "ZombieView.h"

@interface ZombieView ()

@property(nonatomic,strong)zombiePressedBlock b;

@end

@implementation ZombieView

/**
 *  自定义的便利方法
 *
 *  @param zombie 僵尸对象，里面存着大小
 *  @param origin 中心点
 *
 */
-(instancetype)initWithZombie:(BaseZombie *)zombie WithOrigin:(CGPoint)origin
{
    if (self = [super init])
    {
        //初始化僵尸属性
        _zombie = zombie;
        
        //框架初始化
        [self frameSetWithZombie:zombie WithOrigin:origin];
        
        //设置图片
        [self setImageToImageView:self withType:[self tagForZomieButton:zombie] withZombie:zombie];
        
        //初始化相关属性
        [self attributeSet];
        
    }
    
    return self;
}


/**
 *  初始化位置框架的属性
 *
 *  @param zombie 僵尸类型
 *  @param origin 中心点
 */
-(void)frameSetWithZombie:(BaseZombie *)zombie WithOrigin:(CGPoint)origin
{
    //初始化frame
    self.frame = CGRectMake(0, 0, zombie.zombiesFrameWidth, zombie.zombiesFrameHeight);
    
    //初始化中心点
    self.center = origin;
}

/**
 *  初始化相关属性
 */
-(void)attributeSet
{
    //可以人机交互
    self.userInteractionEnabled = YES;
    
    //设置动画属性
    self.animationDuration = 1;
    
    //循环播放
    self.animationRepeatCount = -1;
    
    //开启动画
    [self startAnimating];
}


//设置代码块的方法
-(void)doneWithZombiePressedHandleBlock:(zombiePressedBlock)zombiePressedBlock
{
    self.b = zombiePressedBlock;
}





//touch事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //捕获touch事件
    UITouch * touch = [touches anyObject];
    
    //获取touch的点
    CGPoint point = [touch locationInView:self];
    
    //判断在该区域内
    if (CGRectContainsPoint(self.bounds, point))
    {
       //点击之后的操作，由上一个视图决定，回调
        if (self.b)
        {
            self.b();
        }
    }
}



/**
 *  为imageView设置图片
 *
 *  @param ImageView 设置图片的imageView
 *  @param type   图片的类型
 */
-(void)setImageToImageView:(UIImageView *)imageView withType:(NSInteger)type withZombie:(BaseZombie *)zombie
{
    //表示返回的类型合法
    if (type != 0)
    {
        //接收数组
        NSArray * pic = [self zombiesPictureWithType:type withZombie:zombie];
        
        //加到imageView上
        self.animationImages = pic;
    }
}


/**
 *  根据僵尸的类型和图片数加载图片数组
 *
 *  @param type   僵尸的类型
 *  @param zombie 僵尸的对象
 *
 *  @return 图片数组
 */
-(NSArray *)zombiesPictureWithType:(NSInteger)type withZombie:(BaseZombie *)zombie
{
    //存储图片的数组
    NSMutableArray * pics = [NSMutableArray array];
    
    //开始循环添加图片
    for (NSInteger i = 1; i <= zombie.zombiesFrameCount ; i++)
    {
        //获取UIImage
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld_%ld.tiff",type,i]];
        
        //添加到可变数组中
        [pics addObject:image];
    }
    
    //返回
    return [NSArray arrayWithArray:pics];
}


/**
 *  根据僵尸类的名字获得僵尸类型的后缀数字
 *
 *  @param baseZomebie 僵尸的父类
 *
 *  @return 僵尸的数字类型的后缀数字，如果不存在，返回0
 */
-(NSInteger)tagForZomieButton:(BaseZombie *)baseZomebie
{
    //获得僵尸的类名字符串
    NSString * zomebieType = NSStringFromClass([baseZomebie class]);

    //循环匹配
    for (NSInteger i = 1; i <= 4; i++)
    {
        if ([zomebieType isEqualToString:[NSString stringWithFormat:@"ZombieType%ld",i]])
        {
            return i;
        }
    }
    
    return 0;
}

@end
