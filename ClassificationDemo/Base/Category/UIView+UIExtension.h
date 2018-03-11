//
//  UIView+UIExtension.h
//  ClassificationDemo
//
//  Created by 袁涛 on 2017/11/28.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIExtension)

@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat left;
@property (assign, nonatomic) CGFloat right;
@property (assign, nonatomic) CGFloat top;
@property (assign, nonatomic) CGFloat bottom;
@property (assign, nonatomic) CGFloat centerX;
@property (assign, nonatomic) CGFloat centerY;

@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint point;
@property (assign, nonatomic) CGPoint centerXY;

@end

@interface UIView (SubView)

- (CGFloat)minXWhenCenterInSuperview;
- (CGFloat)minYWhenCenterInSuperview;
- (void)removeAllSubViews;
- (void)notRemoveSubViews:(NSArray<__kindof UIView *> *)subViews;

@end

typedef NS_OPTIONS(NSUInteger, YTUIBorderViewPosition) {
    YTUIBorderViewPositionNone      = 0,
    YTUIBorderViewPositionTop       = 1 << 0,
    YTUIBorderViewPositionLeft      = 1 << 1,
    YTUIBorderViewPositionBottom    = 1 << 2,
    YTUIBorderViewPositionRight     = 1 << 3
};

@interface UIView (Layer)

//@property (assign, nonatomic) YTUIBorderViewPosition borderPosition;
///// 边框的大小，默认为PixelOne
//@property(assign, nonatomic) IBInspectable CGFloat borderWidth;
//
///// 边框的颜色，默认为UIColorSeparator
//@property(strong, nonatomic) IBInspectable UIColor *borderColor;
//
///// 虚线 : dashPhase默认是0，且当dashPattern设置了才有效
//@property(assign, nonatomic) CGFloat dashPhase;
//@property(copy, nonatomic) NSArray <NSNumber *> *dashPattern;
///// border的layer
//@property(nonatomic, strong, readonly) CAShapeLayer *borderLayer;

- (void)clipToCornerRadius:(CGFloat)radius isClip:(BOOL)clip;
- (void)clipToCornerRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth isClip:(BOOL)clip;
- (void)clipToCornerRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color isClip:(BOOL)clip;

@end




