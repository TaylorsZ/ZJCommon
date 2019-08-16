//
//  UIViewController+HUD.m
//  LTProject
//
//  Created by Jonny on 2016/9/28.
//  Copyright © 2016年 ZUBMO. All rights reserved.
//

#import "UIViewController+HUD.h"
#import <objc/message.h>
//#import "UIImage+Gif.h"

static const void *kHud = @"k_labelHud";
static const void *kTapG = @"k_TapG";
static const void *kProTapG = @"k_Pro_TapG";

@interface UIViewController ()

@property (nonatomic,strong)UILabel *labelHud;
@property (nonatomic,strong)UITapGestureRecognizer *tapGestureBlock;

@end

@implementation UIViewController (HUD)


- (void)setTapGestureBlock:(UITapGestureRecognizer *)tapGestureBlock {
    objc_setAssociatedObject(self, &kProTapG, tapGestureBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UITapGestureRecognizer *)tapGestureBlock {
    return  objc_getAssociatedObject(self, &kProTapG);
}

- (UILabel *)labelHud {
    UILabel *subhud = objc_getAssociatedObject(self, &kHud);
    if (subhud == nil) {
        subhud = [[UILabel alloc]initWithFrame:CGRectMake(20, self.view.center.y, self.view.frame.size.width - 40, 30)];
        subhud.textColor = [UIColor colorWithRed:100.f/255.f green:100.f/255.f blue:100.f/255.f alpha:1];
        subhud.font = [UIFont systemFontOfSize:15];
        subhud.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:subhud];
        
        objc_setAssociatedObject(self, &kHud, subhud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return subhud;
}

#pragma mark - 显示状态
- (void)showStatus:(NSString *)status tapViewWithBlock:(tapViewWithBlock)block {
    [self addStatusAndImage:status imageName:nil type:nil tapViewWithBlock:block];
}

#pragma mark - 显示状态以及显示没有数据时的图片
- (void)showStatus:(NSString *)status imageName:(NSString *)imageName type:(NSString *)type tapViewWithBlock:(tapViewWithBlock)block {
    [self addStatusAndImage:status imageName:imageName type:type tapViewWithBlock:block];
}
-(void)showStatus:(NSString *)status{
    if (status) {
        self.labelHud.text = status;
    }
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 100) / 2, self.view.center.y - 105, 100, 100)];
    [imageView setImage:[UIImage imageNamed:@"page_nodata"]];
    imageView.hidden = NO;
    self.labelHud.hidden = NO;
    imageView.tag = 110086;
    [self.view addSubview:imageView];
}
/* 添加文字及图片 */
- (void)addStatusAndImage:(NSString *)status imageName:(NSString *)imageName type:(NSString *)type tapViewWithBlock:(tapViewWithBlock)block{
    
    if (status) {
        self.labelHud.text = status;
    }
    if (imageName) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 100) / 2, self.view.center.y - 100-5, 100, 100)];
        
        [imageView setImage:[UIImage imageNamed:imageName]];
        
        imageView.tag = 110086;
        [self.view addSubview:imageView];
    }
    if (block) {
        
        objc_setAssociatedObject(self, &kTapG, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    // 添加手势
    [self addTapGesture];
}

/* 添加点击手势 */
- (void)addTapGesture {
    
    if (self.tapGestureBlock) {
        [self show];
        return;
    }
    // 添加全屏手势
    self.tapGestureBlock = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBlock)];
    [self.view addGestureRecognizer:self.tapGestureBlock];
}

#pragma mark - 回调  Click return
- (void)tapBlock {
    tapViewWithBlock block = objc_getAssociatedObject(self, &kTapG);
    if (block) {
        block();
    }
}

#pragma mark - 显示 Tips show
- (void)show {
    
    self.labelHud.hidden = NO;
    UIImageView *imageView = [self.view viewWithTag:110086];
    imageView.hidden = NO;
    [self.view addGestureRecognizer: self.tapGestureBlock];
    
}

#pragma mark - 消失 Tips hide
- (void)hideStatus {
    
    if (self.labelHud) {
        /* 动画
         __weak typeof(self) __weakSelf = self;
         [UIView animateWithDuration:1 animations:^{
         __weakSelf.labelHud.alpha = 0;
         } completion:^(BOOL finished) {
         [__weakSelf.labelHud removeFromSuperview];
         }];
         */
        
        self.labelHud.hidden = YES;
    }
    
    UIImageView *imageView = [self.view viewWithTag:110086];
    if (imageView) {
        imageView.hidden = YES;
        [imageView removeFromSuperview];
        [self.view removeGestureRecognizer: self.tapGestureBlock];
    }
    
}

@end
