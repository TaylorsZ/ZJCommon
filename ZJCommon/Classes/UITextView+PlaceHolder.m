//
//  UITextView+PlaceHolder.m
//  RuiYuanProject
//
//  Created by 张立超 on 2018/8/26.
//  Copyright © 2018年 uav. All rights reserved.
//

#import "UITextView+PlaceHolder.h"
#import <objc/runtime.h>
static const void *zs_placeHolderKey;

@interface UITextView ()
@property (nonatomic, readonly) UILabel *zs_placeHolderLabel;
@end

@implementation UITextView (PlaceHolder)
+(void)load{
    [super load];
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"layoutSubviews")),
                                   class_getInstanceMethod(self.class, @selector(zsPlaceHolder_swizzling_layoutSubviews)));
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")),
                                   class_getInstanceMethod(self.class, @selector(zsPlaceHolder_swizzled_dealloc)));
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"setText:")),
                                   class_getInstanceMethod(self.class, @selector(zsPlaceHolder_swizzled_setText:)));
}
#pragma mark - swizzled
- (void)zsPlaceHolder_swizzled_dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self zsPlaceHolder_swizzled_dealloc];
}
- (void)zsPlaceHolder_swizzling_layoutSubviews {
    if (self.zs_placeHolder) {
        UIEdgeInsets textContainerInset = self.textContainerInset;
        CGFloat lineFragmentPadding = self.textContainer.lineFragmentPadding;
        CGFloat x = lineFragmentPadding + textContainerInset.left + self.layer.borderWidth;
        CGFloat y = textContainerInset.top + self.layer.borderWidth;
        CGFloat width = CGRectGetWidth(self.bounds) - x - textContainerInset.right - 2*self.layer.borderWidth;
        CGFloat height = [self.zs_placeHolderLabel sizeThatFits:CGSizeMake(width, 0)].height;
        self.zs_placeHolderLabel.frame = CGRectMake(x, y, width, height);
    }
    [self zsPlaceHolder_swizzling_layoutSubviews];
}
- (void)zsPlaceHolder_swizzled_setText:(NSString *)text{
    [self zsPlaceHolder_swizzled_setText:text];
    if (self.zs_placeHolder) {
        [self updatePlaceHolder];
    }
}
#pragma mark - associated
-(NSString *)zs_placeHolder{
    return objc_getAssociatedObject(self, &zs_placeHolderKey);
}
-(void)setZs_placeHolder:(NSString *)zs_placeHolder{
    objc_setAssociatedObject(self, &zs_placeHolderKey, zs_placeHolder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updatePlaceHolder];
}
-(UIColor *)zs_placeHolderColor{
    return self.zs_placeHolderLabel.textColor;
}
-(void)setZs_placeHolderColor:(UIColor *)zs_placeHolderColor{
    self.zs_placeHolderLabel.textColor = zs_placeHolderColor;
}
-(NSString *)placeholder{
    return self.zs_placeHolder;
}
-(void)setPlaceholder:(NSString *)placeholder{
    self.zs_placeHolder = placeholder;
}
#pragma mark - update
- (void)updatePlaceHolder{
    if (self.text.length) {
        [self.zs_placeHolderLabel removeFromSuperview];
        return;
    }
    self.zs_placeHolderLabel.font = self.font?self.font:self.cacutDefaultFont;
    self.zs_placeHolderLabel.textAlignment = self.textAlignment;
    self.zs_placeHolderLabel.text = self.zs_placeHolder;
    [self insertSubview:self.zs_placeHolderLabel atIndex:0];
}
#pragma mark - lazzing
-(UILabel *)zs_placeHolderLabel{
    UILabel *placeHolderLab = objc_getAssociatedObject(self, @selector(zs_placeHolderLabel));
    if (!placeHolderLab) {
        placeHolderLab = [[UILabel alloc] init];
        placeHolderLab.numberOfLines = 0;
        placeHolderLab.textColor = [UIColor lightGrayColor];
        objc_setAssociatedObject(self, @selector(zs_placeHolderLabel), placeHolderLab, OBJC_ASSOCIATION_RETAIN);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePlaceHolder) name:UITextViewTextDidChangeNotification object:self];
    }
    return placeHolderLab;
}
- (UIFont *)cacutDefaultFont{
    static UIFont *font = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UITextView *textview = [[UITextView alloc] init];
        textview.text = @" ";
        font = textview.font;
    });
    return font;
}
@end
