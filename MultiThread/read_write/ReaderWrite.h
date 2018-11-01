//
//  ReaderWrite.h
//  MultiThread
//
//  Created by liuxiaobing on 2018/11/1.
//  Copyright © 2018 liuxiaobing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/**
 （1）满足条件：①写写互斥；②读写互斥；③读读同时
 
 （2）单纯使用信号量不能解决读者与写者问题，必须引入计数器readcount对读进程计数；
    rmutex是用于对计数器readcount操作的互斥信号量；
    wmutex表示是否允许写的信号量；
 */
@interface ReaderWrite : NSObject

@property(assign,nonatomic) int board;           //临界资源
@property(strong,nonatomic) dispatch_semaphore_t rmutex;         //读者计数器 互斥信号量
@property(strong,nonatomic) dispatch_semaphore_t wmutex;         //写者-读者， 写者-写者
@property(nonatomic,assign) int readcount;

-(void) readData;

-(void) writeData;

@end

NS_ASSUME_NONNULL_END
