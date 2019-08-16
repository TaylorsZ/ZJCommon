//
//  UITextView+PlaceHolder.h
//  RuiYuanProject
//
//  Created by 张立超 on 2018/8/26.
//  Copyright © 2018年 uav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (PlaceHolder)
/**
 *  UITextView+placeholder
 */
@property (nonatomic, copy) NSString *zs_placeHolder;
/**
 *  IQKeyboardManager等第三方框架会读取placeholder属性并创建UIToolbar展示
 */
@property (nonatomic, copy) NSString *placeholder;
/**
 *  placeHolder颜色
 */
@property (nonatomic, strong) UIColor *zs_placeHolderColor;
@end
