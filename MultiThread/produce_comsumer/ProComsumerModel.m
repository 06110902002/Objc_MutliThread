//
//  ProComsumerModel.m
//  MultiThread
//
//  Created by liuxiaobing on 2018/10/31.
//  Copyright © 2018 liuxiaobing. All rights reserved.
//

#import "ProComsumerModel.h"
#import "ProComsumerModel.h"

@interface ProComsumerModel ()

@end

@implementation ProComsumerModel

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initObj];
    
    [self initView];
    
}

-(void) initView{
    UIButton* button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"生产" forState:UIControlStateNormal];
    button2.frame = CGRectMake(20, 80, 200, 40);
    button2.backgroundColor = [UIColor brownColor];
    [button2 addTarget:self action:@selector(producer:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    
    UIButton* button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setTitle:@"消费" forState:UIControlStateNormal];
    button3.frame = CGRectMake(20, 180, 200, 40);
    button3.backgroundColor = [UIColor brownColor];
    [button3 addTarget:self action:@selector(comsumer:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
}

-(void)producer:(UIButton*) button{
    [self producter];
}

-(void)comsumer:(UIButton*) button{
    [self comsumer];
}

-(void) initObj{
    
    self.baseroom = [[BaseRoom alloc] init];
    
    
    //分别创建N个生产者和M消费者各自的运行并发队列
    //均使用并发队列，即生产者之间可以并发执行，消费者之间也可以并发执行
    self.producerQueue = dispatch_queue_create("producer", DISPATCH_QUEUE_CONCURRENT);
    self.consumerQueue = dispatch_queue_create("consumer", DISPATCH_QUEUE_CONCURRENT);
    
}

-(void) producter{
    
//    //创建10个生产者持续生产皮鞋
//    for (int i = 0; i < 5; i++) {
//        dispatch_async(self.producerQueue,  ^{
//            while(1){
//                NSString* t = [NSString stringWithFormat:@"nike"];
//                [self.baseroom produce:t];
//                sleep(1);
//            }
//
//        });
//    }
    
    dispatch_async(self.producerQueue,  ^{
        while(1){
            NSString* t = [NSString stringWithFormat:@"nike"];
            [self.baseroom produce:t];
            sleep(3);
        }

    });
//
}

-(void)comsumer{
    
    for (int i = 0; i < 5; i++){
        dispatch_async(self.consumerQueue, ^{
            while(1){
                [self.baseroom comsumer];
                sleep(1);
            }

        });
    }
    
//    dispatch_async(self.consumerQueue, ^{
//        while(1){
//            [self.baseroom comsumer];
//            sleep(1);
//        }
//
//    });
    
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
