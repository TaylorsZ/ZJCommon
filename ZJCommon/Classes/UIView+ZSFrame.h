//
//  UIView+ZSFrame.h
//  ZSSegmentedControlView
//
//  Created by 李虹鑫 on 2017/1/13.
//  Copyright © 2017年 尚乘货色. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AGSPoint;
typedef NS_OPTIONS(NSUInteger, ZSBorderSideType) {
    ZSBorderSideTypeAll  = 0,
    ZSBorderSideTypeTop = 1 << 0,
    ZSBorderSideTypeBottom = 1 << 1,
    ZSBorderSideTypeLeft = 1 << 2,
    ZSBorderSideTypeRight = 1 << 3,
};

@interface UIView (ZSFrame)

@property(nonatomic,strong)AGSPoint *locationPoint;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
/**
 为view添加指定边的border
 @param color 线条颜色
 @param borderWidth 线条宽度
 @param borderType 类型(上下左右)
 @return 添加了指定border的view
 */
- (UIView *)borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(ZSBorderSideType)borderType;
-(UIView *)cornerRadiusWithValue:(CGFloat )radius radiusType:(UIRectCorner)radiusType;
@end


@interface UIView (Postion)

@property (nonatomic, assign, readonly) CGRect bt_frame;
@property (nonatomic, assign, readonly) CGPoint bt_topLeftVertex;
@property (nonatomic, assign, readonly) CGPoint bt_bottomLeftVertex;
@property (nonatomic, assign, readonly) CGPoint bt_bottomRightVertex;
@property (nonatomic, assign, readonly) CGPoint bt_topRightVertex;

- (void)bt_setAnchorPoint:(CGPoint)anchorPoint;
/// Point 仿射变换(自定义 center)
CG_EXTERN CGPoint bt_CGPointApplyAffineTransform(CGPoint origin, CGPoint point, CGAffineTransform t);
@end

