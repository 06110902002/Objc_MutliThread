//
//  BingFaNSOperation.m
//  MultiThread
//
//  Created by liuxiaobing on 2018/7/27.
//  Copyright © 2018 liuxiaobing. All rights reserved.
//

#import "BingFaNSOperation.h"

@implementation BingFaNSOperation


- (id)init {
    self = [super init]; if (self) {
        executing = NO;
        finished = NO;
    }
    return self;
}

- (BOOL)isConcurrent {
    return YES;
}
- (BOOL)isExecuting {
    return executing;
}
- (BOOL)isFinished {
    return finished;
}

/**
 (必须)所有并发操作都必须覆盖这个方法，以自定义的实现替换 默认行为。手动执行一个操作时，你会调用 start 方法。
 因此你对这 个方法的实现是操作的起点，设置一个线程或其它执行环境，来执 行你的任务。
 你的实现在任何时候都绝对不能调用 super。
 */
-(void)start{
    
    // Always check for cancellation before launching the task. if ([self isCancelled])
    if([self isCancelled]){
        // Must move the operation to the finished state if it is canceled.
        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];  //触发 isFinished属性
        return;
    }
    
    
    // If the operation is not canceled, begin executing the task.
    [self willChangeValueForKey:@"isExecuting"];
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    executing = YES;
    [self didChangeValueForKey:@"isExecuting"];     //触发 isExecuting属性
    
}

//实现并发本接口是否重载是可选的
-(void)main{
    [self completeOperation];
}

/**
 自定义一个执行完成的方法
 */
-(void) completeOperation{
    
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    executing = NO;
    finished = YES;
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

@end
