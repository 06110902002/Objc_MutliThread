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
    if(baseCount != 0){
        NSLog(@"37----------读者被写者打断，退出临界资源的访问");
    }
    dispatch_semaphore_wait(self.readCountMutex,  5 * NSEC_PER_SEC);        //申请访问y读者之间的锁
    
    if(self.readCount == 0 ){
        dispatch_semaphore_wait(self.fileSrcMutex,  5 * NSEC_PER_SEC);      //如果是第一个，则申请临界资源的锁

    }
    self.readCount ++;      //获取到读者之间的锁的时候，将正在访问临界资源的的读者个数加1
    NSLog(@"46----------读者开始读数据：%d",self.board);
    dispatch_semaphore_signal(self.readCountMutex);  //释放读者计数器的锁
    dispatch_semaphore_signal(self.rmutex);         //释放读者可被打断的锁

    
    dispatch_semaphore_wait(self.readCountMutex,  5 * NSEC_PER_SEC);        //申请访问y读者之间的锁
    self.readCount --;
    if(self.readCount == 0){
        dispatch_semaphore_signal(self.fileSrcMutex);
    }
    dispatch_semaphore_signal(self.readCountMutex);  //释放读者计数器的锁

    

}

-(void) writeData{
    
    dispatch_semaphore_wait(self.writeCountMutex,  5 * NSEC_PER_SEC);   //获取写者之间的锁
    if(self.writeCount == 0){       //如果是第一个写者，申请读者可打断锁
        dispatch_semaphore_wait(self.rmutex,  5 * NSEC_PER_SEC);
    }
    self.writeCount ++; //写者数量加1
    dispatch_semaphore_signal(self.writeCountMutex);  //释放写者之间的互斥锁
    dispatch_semaphore_wait(self.fileSrcMutex,  5 * NSEC_PER_SEC); //申请访问临界资源的锁
    self.board = (arc4random() % 100) + 1; //模拟写数据
    NSLog(@"71----------写者写数据：%d",self.board);
    dispatch_semaphore_signal(self.fileSrcMutex);      //p写完之后，释放临界资源的锁
    
    dispatch_semaphore_wait(self.writeCountMutex,  5 * NSEC_PER_SEC);   //再申请 写者之间的锁
    self.writeCount --; //当前 写者访问临界资源的个数 减1
    if(self.writeCount == 0){ //如果是最后一个离开临界资源,则释放 读者打断锁
        dispatch_semaphore_signal(self.rmutex);
    }
    dispatch_semaphore_signal(self.writeCountMutex); //释放 写者之间锁
}

@end
