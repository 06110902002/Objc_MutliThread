//
//  CustomNSOperation.m
//  MultiThread
//
//  Created by liuxiaobing on 2018/7/27.
//  Copyright © 2018 liuxiaobing. All rights reserved.
//

#import "CustomNSOperation.h"

@implementation CustomNSOperation

-(id) initWithData:(id)data{
    if (self = [super init]){
        
    }
    return self;
}


/**
 override  主要用来执行任务的接口，类似java Thread中的run接口
 定义非并发，直接重写这个main方法即可
 */
-(void)main{
    
    NSLog(@"26-------我是一个自定义的Operation 在这个函数中处理我的异步任务");
//    响应取消事件
//    operation 开始执行之后，会一直执行任务直到完成，或者显式地取 消操作。取消可能在任何时候发生，甚至在 operation 执行之前。尽 管 NSOperation 提供了一个方法，让应用取消一个操作，但是识别出取 消事件则是你的事情。如果 operation 直接终止，可能无法回收所有已 分配的内存或资源。因此 operation 对象需要检测取消事件，并优雅地 退出执行。
//    operation 对象定期地调用 isCancelled 方法，如果返回 YES(表示已 取消)，则立即退出执行。不管是自定义NSOperation 子类，还是使用 系统提供的两个具体子类，都需要支持取消。isCancelled 方法本身非常 轻量，可以频繁地调用而不产生大的性能损失。以下地方可能需要调用 isCancelled:
//     在执行任何实际的工作之前
//     在循环的每次迭代过程中，如果每个迭代相对较长可能需要调用
//    多次
//     代码中相对比较容易中止操作的任何地方
    
//    while(![self isCancelled]){
//        NSLog(@"26-------我是一个自定义的Operation 在这个函数中处理我的异步任务");
//    }
}




/**
 释放本对象的接口，由系统调用
 */
- (void)dealloc {
    NSLog(@"35---------我是一个自定义的Operation,我即将释放");
}

@end
