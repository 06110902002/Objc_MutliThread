//
//  ReadWriteVC.h
//  MultiThread
//
//  Created by liuxiaobing on 2018/11/1.
//  Copyright © 2018 liuxiaobing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReaderWrite.h"

NS_ASSUME_NONNULL_BEGIN


/**
 6、读者写者问题：
 （1）满足条件：①写写互斥；②读写互斥；③读读同时
 （2）单纯使用信号量不能解决读者与写者问题，必须引入计数器readcount对读进程计数；
     rmutex是用于对计数器readcount操作的互斥信号量；wmutex表示是否允许写的信号量；
 */
@interface ReadWriteVC : UIViewController

//写者线程跑的队列,这个队列可以控制读者的执行是并行还是串行
@property(strong,nonatomic) dispatch_queue_t readQueue;


//读者线程跑的队列，这个队列可以控制写者的执行是并行还是串行
@property(strong,nonatomic) dispatch_queue_t writeQueue;


@property(strong,nonatomic) ReaderWrite* readWriteMgr;

@end

NS_ASSUME_NONNULL_END
