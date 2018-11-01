//
//  BaseRoom.m
//  MultiThread
//
//  Created by liuxiaobing on 2018/10/31.
//  Copyright © 2018 liuxiaobing. All rights reserved.
//

#import "BaseRoom.h"

@implementation BaseRoom

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //新建一个仓库,这里暂不作容量设计
        self.baseList = [[NSMutableArray alloc] init];
        
        //初始化生产对象--消费者标记，初始为0表示什么都没有
        self.product_sem = dispatch_semaphore_create(10);
        
         self.comsumer_sem = dispatch_semaphore_create(0);
        
        //初始化临界区互斥访问信号量,用信号量实现互斥,特殊初始值为1.
        //控制同一时刻只有一个线程对象在访问仓库
        self.mutex = dispatch_semaphore_create(1);
        
    }
    return self;
}

-(void)produce:(NSString *)e{
    
    
     long baseCount = dispatch_semaphore_wait(self.mutex,  5 * NSEC_PER_SEC);        //先获取访问仓库的信号量
    if(baseCount != 0){
        NSLog(@"39----------仓库有人正在使用，生产者处于等待");
    }else{
        long maxSpaceCount = dispatch_semaphore_wait(self.product_sem, 5 * NSEC_PER_SEC);  //再判断 仓库是否还有可放物品的空间
        
        if(maxSpaceCount != 0){
            NSLog(@"43----------仓库10个空间已经使用完，生产者处于等待：仓库容量:%lu",[self.baseList count]);
            dispatch_semaphore_signal(self.mutex);          //生产完了释放临界区的访问锁
        }else{
            [self.baseList addObject:e];
            NSLog(@"40---------生产鞋子%@:w仓库目前有：%lu",e,[self.baseList count]);
            dispatch_semaphore_signal(self.mutex);          //生产完了释放临界区的访问锁
            dispatch_semaphore_signal(self.comsumer_sem);    //将仓库中的皮鞋数量加1
        }
    }
    
    
    
}

-(NSString*) comsumer{
    NSString* e = nil;
    long baseCount = dispatch_semaphore_wait(self.mutex, 5 * NSEC_PER_SEC);        //先获取访问仓库的信号量
    if(baseCount != 0){
        NSLog(@"55----------仓库有人正在使用，消费者处于等待");
    }else{
        long avableCount = dispatch_semaphore_wait(self.comsumer_sem, 5 * NSEC_PER_SEC);  //再判断 仓库是否还有可取，如果有物品，则取一个出来，否则t等待
        if(avableCount != 0){
            NSLog(@"59----------空仓，消费者处于等待");
            dispatch_semaphore_signal(self.mutex);          //生产完了释放临界区的访问锁
        }else{
            e = [self.baseList objectAtIndex:[self.baseList count] -1];
            [self.baseList removeLastObject];
            NSLog(@"50---------卖鞋子:%@ 仓库还有%lu:",e,[self.baseList count]);
            dispatch_semaphore_signal(self.mutex);          //生产完了释放临界区的访问锁
            dispatch_semaphore_signal(self.product_sem);    //将仓库中的可放置的数量 +1
        }
    }
    
    
    
    return e;
}


@end
