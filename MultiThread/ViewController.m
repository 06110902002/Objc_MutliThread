//
//  ViewController.m
//  MultiThread
//
//  Created by liuxiaobing on 2018/7/27.
//  Copyright © 2018 liuxiaobing. All rights reserved.
//

#import "ViewController.h"
#import "CustomNSOperation.h"
#import "BingFaNSOperation.h"
#import "VC2ViewController.h"
#import "ProComsumerModel.h"
#import "ReadWriteVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self testNSBlockOperation];
    //[self testSerailNSBlockOperation];
    //[self testNSInvocationOperation];
    //[self testCustomNSOperation];
    
    //测试并发的自定义NSOperation
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"测试并发的自定义NSOperation" forState:UIControlStateNormal];
    button.frame = CGRectMake(20, 20, 200, 40);
    button.backgroundColor = [UIColor brownColor];
    [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIButton* button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"测试DispathQueue" forState:UIControlStateNormal];
    button2.frame = CGRectMake(20, 80, 200, 40);
    button2.backgroundColor = [UIColor brownColor];
    [button2 addTarget:self action:@selector(goDispathQueue:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    
    UIButton* button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setTitle:@"测试信号量实现生产者消费模式" forState:UIControlStateNormal];
    button3.frame = CGRectMake(20, 180, 200, 40);
    button3.backgroundColor = [UIColor brownColor];
    [button3 addTarget:self action:@selector(proComsumer:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    UIButton* button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button4 setTitle:@"测试信号量实现读写者模式" forState:UIControlStateNormal];
    button4.frame = CGRectMake(20, 240, 200, 40);
    button4.backgroundColor = [UIColor brownColor];
    [button4 addTarget:self action:@selector(readWrite:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
}


/**
 1.提交到 Operation Queues 的任务必须是 NSOperation 对象，operation object 封装了你要执行的工作，以及所需的所有数据
 2.operation queue 总是并发地执行任务,如果想串行执行需要添加依赖
 下面例子演示的是并行执行
 */
-(void) testNSBlockOperation{
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    NSBlockOperation* theOp = [NSBlockOperation blockOperationWithBlock: ^{
        NSLog(@"24---------testNSBlockOperation  curThread will sleep 3 seconds:%@",[NSThread currentThread]);
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:3];
        [NSThread sleepUntilDate:date];
        NSLog(@"35---------testNSBlockOperation  curThread:%@  slee end",[NSThread currentThread]);
    }];
    
    NSBlockOperation* theOp2 = [NSBlockOperation blockOperationWithBlock: ^{
        NSLog(@"36---------testNSBlockOperation  curThread:%@",[NSThread currentThread]);
        
    }];
    
    [queue addOperation:theOp];
    [queue addOperation:theOp2];
    
    //NSOperation 类对象的 isConcurrent 方法 告诉你这个 operation 相对于调用 start 方法的线程，是同步还是异步执 行的
    
}

/**
 演示例子的串行执行
 */
-(void)testSerailNSBlockOperation{
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    NSBlockOperation* theOp = [NSBlockOperation blockOperationWithBlock: ^{
        NSLog(@"24---------  curThread will sleep 3 seconds:%@",[NSThread currentThread]);
        // sleep 3秒后的时间
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:3];
        [NSThread sleepUntilDate:date];
        NSLog(@"35---------  curThread:%@  slee end",[NSThread currentThread]);
        
    }];
    //[theOp start];    //执行的是在主线程中
    
    NSBlockOperation* theOp2 = [NSBlockOperation blockOperationWithBlock: ^{
        NSLog(@"36---------  curThread:%@",[NSThread currentThread]);
        
    }];
   // [theOp2 start];   //执行的是在主线程中
    [theOp2 addDependency:theOp];
    [queue addOperation:theOp];
    [queue addOperation:theOp2];
    
}

/**
 如果已经现有一个方法，需要并发地执行，就可以直接创
 建 NSInvocationOperation 对象
 */
-(void)testNSInvocationOperation{
    
    NSInvocationOperation* theOp = [[NSInvocationOperation alloc] initWithTarget:self
                                                                selector:@selector(myTaskMethod:) object:@"liu"];
    [theOp start];  //在主线程测试
    
}
- (void)myTaskMethod:(id)data {
    NSLog(@"86-------------:%@",data);
}

/**
 测试自定义NSOperation
 */
-(void) testCustomNSOperation{
    
    CustomNSOperation* opreation = [[CustomNSOperation alloc] initWithData:@"test customOperation"];
    //[opreation start];      //将自定义operation放在 主线程中执行
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    //将操作任务放到子线程执行
    //[queue addOperation:opreation];
    
    
    //当将其加入到队列中，但这样存在一个问题，由于我们没有实现finished属性，所以获取finished属性时只会返回NO，
    //任务加入到队列后不会被队列删除，一直会保存，而且任务执行完成后的回调块也不会执行，
    //所以最好不要只实现一个main方法就交给队列去执行，即使我们没有实现start方法，
    //这里调用start方法以后依旧会执行main方法。这个非并发版本不建议写，好像也没有什么场景需要这样写，反而更加复杂，如果不小心加入到队列中还会产生未知的错误。
    NSLog(@"108--------------:%d",[opreation isFinished]);
}

-(void) onClick:(UIButton*)button{
    [self testBingFaNSOperation];
}

-(void) testBingFaNSOperation{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    BingFaNSOperation *bingFa = [[BingFaNSOperation alloc] init];
    [queue addOperation:bingFa];
}

-(void)goDispathQueue:(UIButton*) button{
    
    [self presentViewController:[[VC2ViewController alloc] init]  animated:YES completion:nil];
}


-(void) proComsumer:(UIButton*)button{
    [self presentViewController:[[ProComsumerModel alloc] init]  animated:YES completion:nil];
}

-(void) readWrite:(UIButton*)button{
    [self presentViewController:[[ReadWriteVC alloc] init]  animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void) testGitTag{
    NSLog(@"183------------");
}
@end
