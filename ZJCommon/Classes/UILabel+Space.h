//
//  UILabel+Space.h
//  RuiYuanProject
//
//  Created by Taylor on 2019/4/27.
//  Copyright © 2019 uav. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Space)
/**設置文字間距*/
- (void)setText:(NSString *)text spacing:(CGFloat)spacing;
/**设置行间距*/
- (void)setText:(NSString *)text lineSpacing:(CGFloat)lineSpacing;
/**获取当前富文本的rect*/
-(CGRect)getAttributedStringRectWithMaxWidth:(CGFloat)maxWidth;
@end

NS_ASSUME_NONNULL_END
