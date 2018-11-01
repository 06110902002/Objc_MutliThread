//
//  ProComsumerModel.h
//  MultiThread
//
//  Created by liuxiaobing on 2018/10/31.
//  Copyright © 2018 liuxiaobing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseRoom.h"

NS_ASSUME_NONNULL_BEGIN


/**
 生产者消费者模式
 */
@interface ProComsumerModel : UIViewController

@property(nonatomic,strong) BaseRoom* baseroom;

//生产者线程跑的队列,这个队列可以控制生产者的执行是并行还是串行
@property(strong,nonatomic)dispatch_queue_t producerQueue;


//消费者线程跑的队列，这个队列可以控制消费者的执行是并行还是串行
@property(strong,nonatomic) dispatch_queue_t consumerQueue;




-(void) initObj;


@end

NS_ASSUME_NONNULL_END
