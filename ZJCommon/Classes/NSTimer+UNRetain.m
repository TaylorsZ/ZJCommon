//
//  NSTimer+UNRetain.m
//  RuiYuanProject
//
//  Created by 字节科技 on 2019/1/15.
//  Copyright © 2019 uav. All rights reserved.
//

#import "NSTimer+UNRetain.h"

@implementation NSTimer (UNRetain)
+(NSTimer *)zs_scheduledTimerWithTimeInterval:(NSTimeInterval)inerval repeats:(BOOL)repeats block:(void (^)(NSTimer * _Nonnull))block{
    return [NSTimer scheduledTimerWithTimeInterval:inerval target:self selector:@selector(zs_blcokInvoke:) userInfo:[block copy] repeats:repeats];
}

+ (void)zs_blcokInvoke:(NSTimer *)timer {
    
    void (^block)(NSTimer *timer) = timer.userInfo;
    if (block) {
        block(timer);
    }
}
@end
