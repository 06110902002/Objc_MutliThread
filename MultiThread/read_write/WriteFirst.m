//
//  WriteFirst.m
//  MultiThread
//
//  Created by liuxiaobing on 2018/11/1.
//  Copyright © 2018 liuxiaobing. All rights reserved.
//

#import "WriteFirst.h"

@implementation WriteFirst

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //初始化生产对象--消费者标记，初始为0表示什么都没有
        self.readCountMutex = dispatch_semaphore_create(1);
        //初始化临界区互斥访问信号量,用信号量实现互斥,特殊初始值为1.
        //控制同一时刻只有一个线程对象在访问临界资源
        self.writeCountMutex = dispatch_semaphore_create(1);
        self.fileSrcMutex = dispatch_semaphore_create(1);
        
        self.rmutex = dispatch_semaphore_create(1);
        self.readCount = 0; //当前正在读数据的读者数量
         self.writeCount = 0; //当前正在读数据的读者数量
        
    }
    return self;
}

-(void) readData{
    
    long baseCount = dispatch_semaphore_wait(self.rmutex,  5 * NSEC_PER_SEC);
    dispatch_semaphore_wait(self.readCountMutex,  5 * NSEC_PER_SEC);
    
    if(self.readCount == 0 ){
        dispatch_semaphore_wait(self.fileSrcMutex,  5 * NSEC_PER_SEC);

    }
    self.readCount ++;
    dispatch_semaphore_signal(self.readCountMutex);  //释放读者计数器的锁
    dispatch_semaphore_signal(self.rmutex);  //释放读者计数器的锁

    NSLog(@"46----------读者开始读数据：%d",self.board);
    dispatch_semaphore_signal(self.readCountMutex);  //释放读者计数器的锁
    self.readCount --;
    if(self.readCount == 0){
        dispatch_semaphore_signal(self.fileSrcMutex);
    }
    dispatch_semaphore_signal(self.readCountMutex);  //释放读者计数器的锁

    

}

-(void) writeData{
    
    dispatch_semaphore_wait(self.writeCountMutex,  5 * NSEC_PER_SEC);
    if(self.writeCount == 0){
        dispatch_semaphore_wait(self.rmutex,  5 * NSEC_PER_SEC);
    }
    self.writeCount ++;
    dispatch_semaphore_signal(self.writeCountMutex);
    dispatch_semaphore_wait(self.fileSrcMutex,  5 * NSEC_PER_SEC);
    self.board = (arc4random() % 100) + 1;
    NSLog(@"71----------写者写数据：%d",self.board);
    dispatch_semaphore_signal(self.fileSrcMutex);
    
    dispatch_semaphore_wait(self.writeCountMutex,  5 * NSEC_PER_SEC);
    self.writeCount --;
    if(self.writeCount == 0){
        dispatch_semaphore_signal(self.rmutex);
    }
    dispatch_semaphore_signal(self.writeCountMutex);
}

@end
