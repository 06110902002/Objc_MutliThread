//
//  ReadWriteFair.h
//  MultiThread
//
//  Created by liuxiaobing on 2018/11/1.
//  Copyright © 2018 liuxiaobing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/**
 读者写者公平竞争
 */
@interface ReadWriteFair : NSObject


@property(assign,nonatomic) int board;           //临界资源
@property(strong,nonatomic) dispatch_semaphore_t queueMutex;            //控制谁先 访问临界资源的信号量
@property(strong,nonatomic) dispatch_semaphore_t readCountMutex;    //读者之间的信号k量
@property(strong,nonatomic) dispatch_semaphore_t fileSrcMutex;      //临界u资源的信号量
@property(nonatomic,assign) int readCount;

-(void) readData;
-(void) writeData;


@end

NS_ASSUME_NONNULL_END
