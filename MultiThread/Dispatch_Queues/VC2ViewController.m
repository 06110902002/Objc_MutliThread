//
//  VC2ViewController.m
//  MultiThread
//
//  Created by liuxiaobing on 2018/7/27.
//  Copyright © 2018 liuxiaobing. All rights reserved.
//


/**
 类型         描述
 
 串行         也称为 private dispatch queue，每次只执行一个任务，按任务 添加顺序执行。
             当前正在执行的任务在独立的线程中运行(不 同任务的线程可能不同)，dispatch queue 管理了
             这些线程。 通常串行 queue 主要用于对特定资源的同步访问。
             你可以创建任意数量的串行 queues，虽然每个 queue 本身每 次只能执行一个任务，但是各个 queue 之间是并发执行的。
 
 
 并发         也称为 global dispatch queue，可以并发执行一个或多个任务 但是任务仍然是以添加到 queue 的顺序启动。
             每个任务运行 于独立的线程中，dispatch queue 管理所有线
             程。同时运行的 任务数量随时都会变化，而且依赖于系统条件。 你不能创建并发 dispatch queues。相反应用只能使用三个已 经定义好的全局并发 queues。
 

 Main dispatch      全局可用的串行 queue，在应用主线程中执行任务。这个 queue 与应用的 run loop 交叉执行。由于它运行在应用的主
 
 
 
 queue      线程，main queue 通常用于应用的关键同步点。 虽然你不需要创建 main dispatch queue，但你必须确保应用 适当地回收
 

 */
#import "VC2ViewController.h"

@interface VC2ViewController ()

@end

@implementation VC2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    [self testPrivate];
    
    
}

-(void) testPrivate{
    
    dispatch_queue_t myCustomQueue;
    myCustomQueue = dispatch_queue_create("com.example.MyCustomQueue", NULL);
    dispatch_async(myCustomQueue, ^{ printf("Do some work here.\n");
    });
    printf("The first block may or may not have run.\n");
    dispatch_sync(myCustomQueue, ^{ printf("Do some more work here.\n");
    });
    printf("Both blocks have completed.\n");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
