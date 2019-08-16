//
//  NSTimer+UNRetain.h
//  RuiYuanProject
//
//  Created by 字节科技 on 2019/1/15.
//  Copyright © 2019 uav. All rights reserved.
//  解决NSTimer循环引用问题

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (UNRetain)
+ (NSTimer *)zs_scheduledTimerWithTimeInterval:(NSTimeInterval)inerval
                                        repeats:(BOOL)repeats
                                          block:(void(^)(NSTimer *timer))block;
@end

NS_ASSUME_NONNULL_END
