//
//  UILabel+Space.m
//  RuiYuanProject
//
//  Created by Taylor on 2019/4/27.
//  Copyright © 2019 uav. All rights reserved.
//

#import "UILabel+Space.h"

@implementation UILabel (Space)
/// 設置文字間距
- (void)setText:(NSString *)text spacing:(CGFloat)spacing{
    // 設置文字間距原理是在每一個字符串後面添加一個空白的間距,這樣會使得居中出現問題
    // text = [NSString stringWithFormat:@" %@",text]; 錯誤方式,就算空白字符串,也會佔用寬度,居中有偏差
    // 正確解決辦法就是在xib中設置居中偏移量為 + spacing/2.0
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSKernAttributeName:@(spacing)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:self.textAlignment];
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length]-1)];
    self.attributedText = attributedString;
    [self sizeToFit];
}

/// 设置行间距
- (void)setText:(NSString *)text lineSpacing:(CGFloat)lineSpacing{
    if (!text || lineSpacing < 0.01) {
        self.text = text;
        return;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];//设置行间距
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, text.length)];
    self.attributedText = attributedString;
}

-(CGRect)getAttributedStringRectWithMaxWidth:(CGFloat)maxWidth{
   
    //获取设置文本间距以后的高度
    return [self.attributedText boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
}
@end
