//
//  ZombieManager.m
//  打僵尸
//
//  Created by Ibokan on 15/10/6.
//  Copyright (c) 2015年 YueWen. All rights reserved.
//

#import "ZombieManager.h"
#import "BaseZombie.h"
#import "ZombieType1.h"
#import "ZombieType2.h"
#import "ZombieType3.h"
#import "ZombieType4.h"
#import "DEFINE.h"
#import "textType1.h"

@interface ZombieManager ()

@property(nonatomic,strong)NSMutableArray * zombies_m;

@property(nonatomic,strong)ZombieManagerLoadFinishBlock b;

@end


@implementation ZombieManager

-(instancetype)init
{
    if (self = [super init])
    {
        //初始化数组
        self.zombies_m = [NSMutableArray array];
    }
    return self;
}

+(instancetype)shareZombieManager
{
    static ZombieManager * zombieManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        zombieManager = [[ZombieManager alloc]init];
    });
    
    return zombieManager;
}


/**
 *  加载僵尸数组
 */
-(void)loadZombies
{
    //开始之前清除数组
    [self.zombies_m removeAllObjects];
    
    //开始循环加载僵尸
    for (NSInteger i = 0; i < ZOMBIE_COUNT; i++)
    {
        [self addZombie];
    }
}



-(NSArray *)zombies
{
    return [NSArray arrayWithArray:self.zombies_m];
}


/**
 *  设置回调代码块，并触发加载僵尸数据
 *
 *  @param zombieMangerLoadFinishBlock 回调的代码块
 */
-(void)setZombieManagerLoadFinishHandleBlock:(ZombieManagerLoadFinishBlock)zombieMangerLoadFinishBlock
{
    self.b = zombieMangerLoadFinishBlock;
    
    [self loadZombies];//加载数据
    
    self.b(self.zombies_m);
}



//增加一个僵尸
-(void)addZombie
{
    [self.zombies_m addObject:[self arcdToModeZombie]];
}




/**
 *  随机返回僵尸对象
 *
 *  @return 增加的僵尸
 */
-(BaseZombie *)arcdToModeZombie
{
    NSInteger temp = arc4random() % ZOMBIE_TYPE_COUNT + 1;//随机数 1~4，并根据数组返回僵尸类型
    
    switch (temp) {
        case 1:
            return [[ZombieType1 alloc]init];
            break;
        case 2:
            return [[ZombieType2 alloc]init];
            break;
        case 3:
            return [[ZombieType3 alloc]init];
            break;
        case 4:
            return [[ZombieType4 alloc]init];
            break;
        default:
            break;
    }
    return nil;
}

@end
