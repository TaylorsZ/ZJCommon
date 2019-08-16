//
//  UIColor+ZSColor.h
//  Woleyi
//
//  Created by 李虹鑫 on 2017/2/16.
//  Copyright © 2017年 4533206. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZSColor)

/** 根据16进制字符串返回对应颜色 */
+ (instancetype)colorWithHexString:(NSString *)hexString;

/** 根据16进制字符串返回对应颜色 带透明参数 */
+ (instancetype)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end
