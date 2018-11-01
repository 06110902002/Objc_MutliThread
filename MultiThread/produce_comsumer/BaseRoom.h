//
//  BaseRoom.h
//  MultiThread
//
//  Created by liuxiaobing on 2018/10/31.
//  Copyright © 2018 liuxiaobing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/**
 仓库
 */
@interface BaseRoom : NSObject


@property(strong,nonatomic) NSMutableArray* list;

@property(assign,nonatomic) BOOL bIsStop;

@property(strong,nonatomic) NSMutableArray* baseList;           //仓库
@property(strong,nonatomic) dispatch_semaphore_t mutex;         //访问仓库（临界区）的互斥访问信号量
@property(strong,nonatomic) dispatch_semaphore_t comsumer_sem;      //生产者-是否生产对象的标记  消费者是否消费仓库对象的标记 使用信
@property(strong,nonatomic) dispatch_semaphore_t product_sem;      //生产者-是否生产对象的标记  消费者是否消费仓库对象的标记 使用信
@property(nonatomic,assign) int count;

-(void) produce:(NSString*) e;

-(NSString*) comsumer;

@end

NS_ASSUME_NONNULL_END
