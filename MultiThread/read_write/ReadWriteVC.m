//
//  ReadWriteVC.m
//  MultiThread
//
//  Created by liuxiaobing on 2018/11/1.
//  Copyright © 2018 liuxiaobing. All rights reserved.
//

#import "ReadWriteVC.h"

@interface ReadWriteVC ()

@end

@implementation ReadWriteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.readWriteMgr = [[ReaderWrite alloc] init];
    self.writeFirstMgr = [[WriteFirst alloc] init];
    [self initView];
}

-(void) initView{
    
    UIButton* button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"读数据" forState:UIControlStateNormal];
    button2.frame = CGRectMake(20, 80, 200, 40);
    button2.backgroundColor = [UIColor brownColor];
    [button2 addTarget:self action:@selector(read:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    
    UIButton* button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setTitle:@"写数据" forState:UIControlStateNormal];
    button3.frame = CGRectMake(20, 180, 200, 40);
    button3.backgroundColor = [UIColor brownColor];
    [button3 addTarget:self action:@selector(write:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    self.readQueue = dispatch_queue_create("producer", DISPATCH_QUEUE_CONCURRENT);  //读者可以使用 并发队列，不限定读者的顺序
    self.writeQueue = dispatch_queue_create("consumer", DISPATCH_QUEUE_SERIAL);
    
    
    UIButton* button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button4 setTitle:@"写优先——读数据" forState:UIControlStateNormal];
    button4.frame = CGRectMake(240, 80, 200, 40);
    button4.backgroundColor = [UIColor brownColor];
    [button4 addTarget:self action:@selector(writeFirst_Read:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    
    
    UIButton* button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button5 setTitle:@"写优先——写数据" forState:UIControlStateNormal];
    button5.frame = CGRectMake(240, 180, 200, 40);
    button5.backgroundColor = [UIColor brownColor];
    [button5 addTarget:self action:@selector(writeFirst_Write:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button5];
}


-(void) read:(UIButton*) button{
    
    for(int i = 0; i < 5; i ++){
        dispatch_async(self.readQueue,  ^{
            while(1){
                [self.readWriteMgr readData];
                sleep(1);
            }

        });
    }
    
    
}

-(void) write:(UIButton*) button{
    
    for(int i = 0; i < 5; i ++){
        dispatch_async(self.writeQueue,  ^{
            while(1){
                [self.readWriteMgr writeData];

                sleep(1);
            }

        });
    }
    
}


-(void) writeFirst_Read:(UIButton*) button{
    
    for(int i = 0; i < 5; i ++){
        dispatch_async(self.readQueue,  ^{
            while(1){
                [self.writeFirstMgr readData];
                sleep(1);
            }
            
        });
    }
    
}

-(void) writeFirst_Write:(UIButton*) button{
    for(int i = 0; i < 5; i ++){
        dispatch_async(self.writeQueue,  ^{
            while(1){
                [self.writeFirstMgr writeData];
                sleep(2);
            }
            
        });
    }
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
