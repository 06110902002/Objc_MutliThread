//
//  BingFaNSOperation.h
//  MultiThread
//
//  Created by liuxiaobing on 2018/7/27.
//  Copyright © 2018 liuxiaobing. All rights reserved.
//  并发 的NSOperation

#import <Foundation/Foundation.h>

/**  实现并发需要重载的方法与属性
 方法 描述
 
 start (必须)所有并发操作都必须覆盖这个方法，以自定义的实现替换 默认行为。手动执行一个操作时，你会调用 start 方法。
 因此你对这 个方法的实现是操作的起点，设置一个线程或其它执行环境，来执 行你的任务。你的实现在任何时候都绝对不能调用 super。
 
 
 main (可选)这个方法通常用来实现 operation 对象相关联的任务。尽管 你可以在 start 方法中执行任务，使用 main 来实现任务可以让你的 代码更加清晰地分离设置和任务代码
 
 isExecuting isFinished
 (必须)并发操作负责设置自己的执行环境，并向外部 client 报告 执行环境的状态。因此并发操作必须维护某些状态信息，以知道是 否正在执行任务，是否已经完成任务。使用这两个方法报告自己的 状态。 这两个方法的实现必须能够在其它多个线程中同时调用。另外这些 方法报告的状态变化时，还需要为相应的 key path 产生适当的 KVO 通知。
 
 
 isConcurrent (必须)标识一个操作是否并发 operation，覆盖这个方法并返回 YES
 
 */



@interface BingFaNSOperation : NSOperation{
    
    BOOL executing;    //属性通过kvo机制进行实现
    BOOL finished;
}

- (void)completeOperation;







@end
