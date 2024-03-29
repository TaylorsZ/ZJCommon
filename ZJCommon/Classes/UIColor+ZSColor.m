//
//  UIColor+ZSColor.m
//  Woleyi
//
//  Created by 李虹鑫 on 2017/2/16.
//  Copyright © 2017年 4533206. All rights reserved.
//

#import "UIColor+ZSColor.h"

@implementation UIColor (ZSColor)

+(instancetype)colorWithHexString:(NSString *)hexString{
    
    // 删除字符串中的空格,并转换为大写
    NSString *colorString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if (colorString.length < 6) { // 非法字符串，返回clearColor
        return [UIColor clearColor];
    }
    
    if ([colorString hasPrefix:@"0X"]) { // 以"0X"开头（从下标为2开始截取）
        colorString = [colorString substringFromIndex:2];
    }
    
    if ([colorString hasPrefix:@"#"]) { // 以"#"开头 (下标为1开始截取)
        colorString = [colorString substringFromIndex:1];
    }
    
    // 截取完如果字符串长度不为6(非法)返回clearColor
    if (colorString.length != 6) {
        return [UIColor clearColor];
    }
    
    // 依次取出r/g/b字符串
    NSRange range;
    range.location = 0;
    range.length = 2;
    // r
    NSString *rString = [colorString substringWithRange:range];
    
    // g
    range.location = 2;
    NSString *gString = [colorString substringWithRange:range];
    
    // b
    range.location = 4;
    NSString *bString = [colorString substringWithRange:range];
    
    // 转换为数值
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    // 返回对应颜色
    return [UIColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:1.0];
    
}
+(instancetype)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha{

       return [[self colorWithHexString:hexString] colorWithAlphaComponent:alpha];
}
@end
