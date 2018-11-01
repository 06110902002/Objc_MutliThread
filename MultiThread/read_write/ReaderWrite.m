//
//  ReaderWrite.m
//  MultiThread
//
//  Created by liuxiaobing on 2018/11/1.
//  Copyright © 2018 liuxiaobing. All rights reserved.
//

#import "ReaderWrite.h"

@implementation ReaderWrite

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //初始化生产对象--消费者标记，初始为0表示什么都没有
        self.rmutex = dispatch_semaphore_create(1);
        //初始化临界区互斥访问信号量,用信号量实现互斥,特殊初始值为1.
        //控制同一时刻只有一个线程对象在访问临界资源
        self.wmutex = dispatch_semaphore_create(1);
        self.readcount = 0; //当前正在读数据的读者数量
    }
    return self;
}


-(void) readData{
    
    
    long baseCount = dispatch_semaphore_wait(self.rmutex,  5 * NSEC_PER_SEC);       
    if(baseCount != 0){
        NSLog(@"36----------临界区正在被写者使用，读者处于等待");
    }else{
        if(self.readcount == 0){
            long tmp = dispatch_semaphore_wait(self.wmutex,  5 * NSEC_PER_SEC);
            if(tmp != 0){
                NSLog(@"36----------我是第一个读者，我想在临界区读取数据，但是当前有写者，读者处于等待");
            }else{

            }
        }

        self.readcount ++;
        dispatch_semaphore_signal(self.rmutex);  //释放读者计数器的锁
        NSLog(@"50----------读者开始读数据:%d",self.board);
        
        dispatch_semaphore_wait(self.rmutex,  5 * NSEC_PER_SEC);    //读完数据之后还需要再申请使用一次读者之间的x互斥锁，
        self.readcount --;          //将读者计数器 减一操作
        if(self.readcount == 0){    //如果是最后一个t读者操作，需要通知 写者可以 进行写操作了
            dispatch_semaphore_signal(self.wmutex);
        }
        dispatch_semaphore_signal(self.rmutex); //最后再释放 读者之间的锁
    }
    
  
}

-(void) writeData{
    
    long count = dispatch_semaphore_wait(self.wmutex,  5 * NSEC_PER_SEC);
    if(count != 0){
        NSLog(@"50----------当前有人在使用临界区在读数据，写者等待....");
        
    }else{
//        self.board = (arc4random() % 100) + 1;
//        NSLog(@"71----------写者写数据：%d",self.board);
       
    }
    self.board = (arc4random() % 100) + 1;
    NSLog(@"71----------写者写数据：%d",self.board);
     dispatch_semaphore_signal(self.wmutex);
    
}

@end
