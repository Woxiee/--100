//
//  GlobalQueueOperation.m
//  KX_Service
//
//  Created by ac on 16/7/29.
//  Copyright © 2016年 Faker. All rights reserved.
//

#import "GlobalQueueOperation.h"

@interface GlobalQueueOperation()

@property (nonatomic, strong) dispatch_queue_t concurrentThread;
@property (nonatomic, strong) dispatch_queue_t serialThread;

@end


@implementation GlobalQueueOperation
static GlobalQueueOperation *instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
        [instance getConcurrentQueue];
        [instance getSerialQueue];
    });
    return instance;
}

+ (instancetype)globalQueue
{
    return [[self alloc] init];
}

- (void) getConcurrentQueue{
    _concurrentThread = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}

- (void)getSerialQueue
{
    _serialThread = dispatch_queue_create("com.KuaiYun", DISPATCH_QUEUE_SERIAL);
}

/**
 *  全局队列：异步、并发、没有顺序、速度快
 *
 *  @param block 代码块
 */
void doInDisPatchWithConcurrent(dispatch_block_t block)
{
    if (instance == nil) {
        [GlobalQueueOperation globalQueue];
    }
    dispatch_async(instance.concurrentThread, block);
}

/**
 *  全局队列：异步、串行、顺序执行、速度慢
 *
 *  @param block 代码块
 */
void doInDispatchSerialWith(dispatch_block_t block){
    if (instance == nil) {
        [GlobalQueueOperation globalQueue];
    }
    dispatch_async(instance.serialThread, block);
}

/**
 *  主线程执行
 *
 *  @param block 代码块
 */
void doInMain(dispatch_block_t block)
{
    dispatch_async(dispatch_get_main_queue(), block);
}


@end
