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

//具体实现:
//1.通过添加信号量rmutex实现写者到来时能够打断读者进程。
//2.设置信号量fileSrc实现读写者对临界资源的访问。
//3.设置计数器writeCount来统计当前阻塞的写者进程的数目，设置信号量writeCountSignal完成对writeCount计数器资源的互斥访问。
//4.设置计数器readCount来统计访问临界资源的读者数目，设置信号量readCountSignal完成对readCount计数器资源的互斥访问。

//核心思想 
//每个读进程最开始都要申请一下 rmutex 信号量，
//之后在真正做读操作前即让出(使得写进程可以随时申请到 rmutex)。
//而只有第一个写进程需要申请 rmutex，之后就一直占着不放了，
//直到所有写进程都完成后才让出。等于只要有写进程提出申请就禁止读进程排队，变相提高了写进程的优先级。
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WriteFirst : NSObject

@property(assign,nonatomic) int board;           //临界资源
@property(strong,nonatomic) dispatch_semaphore_t rmutex;            //用来控制写者来的时候可以随时打断读者 的信号量
@property(strong,nonatomic) dispatch_semaphore_t readCountMutex;    //读者之间的信号k量
@property(strong,nonatomic) dispatch_semaphore_t writeCountMutex;   //写者之初间的信号量
@property(strong,nonatomic) dispatch_semaphore_t fileSrcMutex;      //临界u资源的信号量
@property(nonatomic,assign) int readCount;
@property(nonatomic,assign) int writeCount;

-(void) readData;
-(void) writeData;

@end

NS_ASSUME_NONNULL_END
