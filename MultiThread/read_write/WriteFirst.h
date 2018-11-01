//
//  WriteFirst.h
//  MultiThread
//
//  Created by liuxiaobing on 2018/11/1.
//  Copyright © 2018 liuxiaobing. All rights reserved.
//

//写者优先:
//1.写者线程的优先级高于读者线程。
//2.当有写者到来时应该阻塞读者线程的队列。
//3.当有一个写者正在写时或在阻塞队列时应当阻塞读者进程的读操作，直到所有写者进程完成写操作时放开读者进程。
//4.当没有写者进程时读者进程应该能够同时读取文件
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WriteFirst : NSObject

@property(assign,nonatomic) int board;           //临界资源
@property(strong,nonatomic) dispatch_semaphore_t rmutex;
@property(strong,nonatomic) dispatch_semaphore_t readCountMutex;
@property(strong,nonatomic) dispatch_semaphore_t writeCountMutex;
@property(strong,nonatomic) dispatch_semaphore_t fileSrcMutex;
@property(nonatomic,assign) int readCount;
@property(nonatomic,assign) int writeCount;

-(void) readData;
-(void) writeData;

@end

NS_ASSUME_NONNULL_END
