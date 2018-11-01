//
//  ReadWriteFair.m
//  MultiThread
//
//  Created by liuxiaobing on 2018/11/1.
//  Copyright © 2018 liuxiaobing. All rights reserved.
//

#import "ReadWriteFair.h"

@implementation ReadWriteFair

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.fileSrcMutex = dispatch_semaphore_create(1);
        self.readCountMutex = dispatch_semaphore_create(1);
        self.queueMutex = dispatch_semaphore_create(1);
        self.readCount = 0;
    }
    return self;
}

-(void)readData{
    
    dispatch_semaphore_wait(self.queueMutex,  5 * NSEC_PER_SEC);
    dispatch_semaphore_wait(self.readCountMutex,  5 * NSEC_PER_SEC);
    if(self.readCount == 0){
        NSLog(@"30---------第一个读者需要申请临界资源访问");
        dispatch_semaphore_wait(self.fileSrcMutex,  5 * NSEC_PER_SEC);
    }
    
    self.readCount ++;
    dispatch_semaphore_signal(self.readCountMutex);  //释放读者计数器的锁
    dispatch_semaphore_signal(self.queueMutex);  //释放读者计数器的锁
    NSLog(@"44----------读者开始读数据:%d",self.board);
    
    dispatch_semaphore_wait(self.readCountMutex,  5 * NSEC_PER_SEC);    //读完数据之后还需要再申请使用一次读者之间的x互斥锁，
    self.readCount --;          //将读者计数器 减一操作
    if(self.readCount == 0){    //如果是最后一个t读者操作，需要通知 写者可以 进行写操作了
        dispatch_semaphore_signal(self.fileSrcMutex);
    }
    dispatch_semaphore_signal(self.readCountMutex); //最后再释放 读者之间的锁
    
    
    
}

-(void) writeData{
    
    long count = dispatch_semaphore_wait(self.queueMutex,  5 * NSEC_PER_SEC);
    dispatch_semaphore_wait(self.fileSrcMutex,  5 * NSEC_PER_SEC);
    dispatch_semaphore_signal(self.queueMutex);
    if(count != 0){
        NSLog(@"64----------当前有人在使用临界区在读数据，写者等待....");
        
    }else{
        //        self.board = (arc4random() % 100) + 1;
        //        NSLog(@"71----------写者写数据：%d",self.board);
    }
    self.board = (arc4random() % 100) + 1;
    NSLog(@"71----------公平竞争-写者写数据：%d",self.board);
    dispatch_semaphore_signal(self.fileSrcMutex);
}

@end
