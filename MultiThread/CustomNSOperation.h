//
//  CustomNSOperation.h
//  MultiThread
//
//  Created by liuxiaobing on 2018/7/27.
//  Copyright © 2018 liuxiaobing. All rights reserved.
//  自定义NSThreadOperation



#import <Foundation/Foundation.h>


/**
 每个 operation 对象至少需要实现以下方法:
    自定义 initialization 方法:初始化，将 operation 对象设置为已知 状态
    自定义 main 方法:执行你的任务
 
你也可以选择性地实现以下方法:
    main方法中需要调用的其它自定义方法
    Accessor方法:设置和访问operation对象的数据
    dealloc方法:清理operation对象分配的所有内存
    NSCoding 协议的方法:允许 operation 对象 archive 和 unarchive
 */
@interface CustomNSOperation : NSOperation



/**
 本接口主要用来处理

 @param data
 @return 
 */
-(id)initWithData:(id)data;


@end
