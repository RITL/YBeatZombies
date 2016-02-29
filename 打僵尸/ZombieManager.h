//
//  ZombieManager.h
//  打僵尸
//
//  Created by Ibokan on 15/10/6.
//  Copyright (c) 2015年 YueWen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ZombieManagerLoadFinishBlock)(NSArray * zombies);

@interface ZombieManager : NSObject

/**
 *  存放僵尸对象的数组
 */
@property(nonatomic,strong,readonly)NSArray * zombies;


/**
 *  加载僵尸
 */
-(void)loadZombies;




/**
 *  获取单例对象
 *
 *  @return 单例对象
 */
+(instancetype)shareZombieManager;

/**
 *  为回调的代码块赋值
 *
 *  @param zombieMangerLoadFinishBlock 回调的代码块
 */
-(void)setZombieManagerLoadFinishHandleBlock:(ZombieManagerLoadFinishBlock)zombieMangerLoadFinishBlock;

@end
