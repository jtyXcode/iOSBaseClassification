//
//  UIView+UIExtension.m
//  ClassificationDemo
//
//  Created by 袁涛 on 2017/11/28.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import "UIView+UIExtension.h"

@implementation UIView (UIExtension)

- (void)setX:(CGFloat)x {
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

-(void)setY:(CGFloat)y {
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

- (void)setWidth:(CGFloat)width {
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (void)setHeight:(CGFloat)height {
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (void)setTop:(CGFloat)top {
    CGRect rect = self.frame;
    rect.origin.y = top;
    self.frame = rect;
}


- (void)setLeft:(CGFloat)left {
    CGRect rect = self.frame;
    rect.origin.x = left;
    self.frame = rect;
}


- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (void)setSize:(CGSize)size {
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}

- (void)setPoint:(CGPoint)point {
    CGRect rect = self.frame;
    rect.origin = point;
    self.frame = rect;
}

- (void)setCenterXY:(CGPoint)centerXY {
    CGPoint point = centerXY;
    self.centerXY = point;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (CGFloat)right {
    return self.frame.origin.x +  self.frame.size.width;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (CGSize)size {
    return self.frame.size;
}

- (CGPoint)point {
    return self.frame.origin;
}

-(CGPoint)centerXY {
//  self.layer.
    return self.center;
}

@end


@implementation UIView (SubView)
- (CGFloat)minXWhenCenterInSuperview{
    return CGFloatGetCenter(CGRectGetWidth(self.superview.bounds), CGRectGetWidth(self.frame));
}
- (CGFloat)minYWhenCenterInSuperview{
    return CGFloatGetCenter(CGRectGetHeight(self.superview.bounds), CGRectGetHeight(self.frame));
}


- (void)removeAllSubViews {
    for (UIView *sview in self.subviews) {
        [sview removeFromSuperview];
    }
}
- (void)notRemoveSubViews:(NSArray<__kindof UIView *> *)subViews{
    if (ArrayIsEmpty(subViews)) {
        [self removeAllSubViews];
    }else {
        for (UIView *sview in self.subviews) {
            for (UIView *nView in subViews) {
                if ([nView isEqual:sview]) {
                    continue;
                }else {
                    [sview removeFromSuperview];
                }
                
            }
        }
        
    }
}

@end

@implementation UIView (Layer)

//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        ReplaceMethod([self class], @selector(initWithFrame:), @selector(yt_initWithFrame:));
//        ReplaceMethod([self class], @selector(initWithCoder:), @selector(yt_initWithCoder:));
//        ReplaceMethod([self class], @selector(layoutSublayersOfLayer:), @selector(yt_layoutSublayersOfLayer:));
//    });
//}
//
//- (instancetype)qmui_initWithFrame:(CGRect)frame {
//    [self qmui_initWithFrame:frame];
//    [self setDefaultStyle];
//    return self;
//}
//
//- (instancetype)qmui_initWithCoder:(NSCoder *)aDecoder {
//    [self qmui_initWithCoder:aDecoder];
//    [self setDefaultStyle];
//    return self;
//}
//
//- (void)setDefaultStyle {
//    self.borderWidth = PixelOne;
//    self.borderColor = UIColorSeparator;
//}




- (void)clipToCornerRadius:(CGFloat)radius isClip:(BOOL)clip {
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = clip;
}

- (void)clipToCornerRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth isClip:(BOOL)clip{
    self.layer.borderWidth = borderWidth;
    [self clipToCornerRadius:radius isClip:clip];
}

- (void)clipToCornerRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color isClip:(BOOL)clip {
    self.layer.borderColor = color.CGColor;
    [self clipToCornerRadius:radius borderWidth:borderWidth isClip:clip];
}



@end








