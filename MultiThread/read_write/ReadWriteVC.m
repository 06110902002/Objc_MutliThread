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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
