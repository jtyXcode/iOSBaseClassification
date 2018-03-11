//
//  UIImage+UIExtension.h
//  ClassificationDemo
//
//  Created by 袁涛 on 2017/11/30.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>




#define CGContextInspectSize(size) [YTUIHelper inspectContextSize:size]

#ifdef DEBUG
#define CGContextInspectContext(context) [YTUIHelper inspectContextIfInvalidatedInDebugMode:context]
#else
#define CGContextInspectContext(context) if(![YTUIHelper inspectContextIfInvalidatedInReleaseMode:context]){return nil;}
#endif

typedef NS_ENUM(NSInteger, YTUIImageShape) {
    YTUIImageShapeOval,                 // 椭圆
    YTUIImageShapeTriangle,             // 三角形
    YTUIImageShapeDisclosureIndicator,  // 列表 cell 右边的箭头
    YTUIImageShapeCheckmark,            // 列表 cell 右边的checkmark
    YTUIImageShapeDetailButtonImage,    // 列表 cell 右边的 i 按钮图片
    YTUIImageShapeNavBack,              // 返回按钮的箭头
    YTUIImageShapeNavClose              // 导航栏的关闭icon
};

typedef NS_OPTIONS(NSInteger, YTUIImageBorderPosition) {
    YTUIImageBorderPositionAll      = 0,
    YTUIImageBorderPositionTop      = 1 << 0,
    YTUIImageBorderPositionLeft     = 1 << 1,
    YTUIImageBorderPositionBottom   = 1 << 2,
    YTUIImageBorderPositionRight    = 1 << 3,
};


@interface UIImage (UIExtension)
/**
 *  设置一张图片的透明度
 *
 *  @param alpha 要用于渲染透明度
 *
 *  @return 设置了透明度之后的图片
 */
- (UIImage *)yt_imageWithAlpha:(CGFloat)alpha;

/**
 *  判断一张图是否不存在 alpha 通道，注意 “不存在 alpha 通道” 不等价于 “不透明”。一张不透明的图有可能是存在 alpha 通道但 alpha 值为 1。
 */
- (BOOL)yt_opaque;

/**
 *  保持当前图片的形状不变，使用指定的颜色去重新渲染它，生成一张新图片并返回
 *
 *  @param tintColor 要用于渲染的新颜色
 *
 *  @return 与当前图片形状一致但颜色与参数tintColor相同的新图片
 */
- (UIImage *)yt_imageWithTintColor:(UIColor *)tintColor;

/**
 *  切割出在指定位置中的图片
 *
 *  @param rect 要切割的rect
 *
 *  @return 切割后的新图片
 */
- (UIImage *)yt_imageWithClippedRect:(CGRect)rect;

/**
 *  将原图进行旋转，只能选择上下左右四个方向
 *
 *  @param  direction 旋转的方向
 *
 *  @return 处理完的图片
 */
- (UIImage *)yt_imageWithOrientation:(UIImageOrientation)orientation;

/**
 *  为图片加上一个border，border的路径为path
 *
 *  @param borderColor  border的颜色
 *  @param path         border的路径
 *
 *  @return 带border的UIImage
 *  @warning 注意通过`path.lineWidth`设置边框大小，同时注意路径要考虑像素对齐（`path.lineWidth / 2.0`）
 */
- (UIImage *)yt_imageWithBorderColor:(UIColor *)borderColor path:(UIBezierPath *)path;

/**
 *  为图片加上一个border，border的路径为borderColor、cornerRadius和borderWidth所创建的path
 *
 *  @param borderColor   border的颜色
 *  @param borderWidth    border的宽度
 *  @param cornerRadius  border的圆角
 *
 *  @param dashedLengths 一个CGFloat的数组，例如`CGFloat dashedLengths[] = {2, 4}`。如果不需要虚线，则传0即可
 *
 *  @return 带border的UIImage
 */
- (UIImage *)yt_imageWithBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius dashedLengths:(const CGFloat *)dashedLengths;
- (UIImage *)yt_imageWithBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius;


/**
 *  为图片加上一个border（可以是任意一条边，也可以是多条组合；只能创建矩形的border，不能添加圆角）
 *
 *  @param borderColor       border的颜色
 *  @param borderWidth        border的宽度
 *  @param borderPosition    border的位置
 *
 *  @return 带border的UIImage
 */
- (UIImage *)yt_imageWithBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth borderPosition:(YTUIImageBorderPosition)borderPosition;

/**
 *  创建一个size为(1, 1)的纯色的UIImage
 *
 *  @param color 图片的颜色
 *
 *  @return 纯色的UIImage
 */
+ (UIImage *)yt_imageWithColor:(UIColor *)color;

/**
 *  创建一个纯色的UIImage
 *
 *  @param  color           图片的颜色
 *  @param  size            图片的大小
 *  @param  cornerRadius    图片的圆角
 *
 * @return 纯色的UIImage
 */
+ (UIImage *)yt_imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;


/**
 *  生成一张线性或对角渐变色的UIImage
 *
 *  @param startColor 起始颜色
 *  @param endColor 最终颜色
 *  @param rect 尺寸
 *  @param isLineer 是否是线性渐变
 *  @return 线性渐变色的UIImage
 */
+ (UIImage *)yt_imageStartColor:(UIColor *)startColor endColor:(UIColor *)endColor rect:(CGRect)rect isLineer:(BOOL)isLineer;

/**
 *  创建一个指定大小和颜色的形状图片
 *  @param shape 图片形状
 *  @param size 图片大小
 *  @param lineWidth 路径大小，不会影响最终size
 *  @param tintColor 图片颜色
 */
+ (UIImage *)yt_imageWithShape:(YTUIImageShape)shape size:(CGSize)size lineWidth:(CGFloat)lineWidth tintColor:(UIColor *)tintColor;

/**
 对传进来的 `UIView` 截图，生成一个 `UIImage` 并返回。注意这里使用的是 view.layer 来渲染图片内容。
 
 @param view 要截图的 `UIView`
 
 @return `UIView` 的截图
 
 @warning UIView 的 transform 并不会在截图里生效
 */
+ (UIImage *)yt_imageWithView:(UIView *)view;

/**
 返回一张不被渲染的图片

 @param name <#name description#>
 @return <#return value description#>
 */
+ (UIImage *)imageWithRenderOriginalName:(NSString *)name;

/**
 返回一张不超过屏幕大小的图片

 @param image 选中图片
 @return
 */
+ (UIImage *)yt_imageSizeWithScreenImage:(UIImage *)image;

@end


@interface UIImage (gif)
+ (nullable UIImage *)imageWithSmallCIFData:(NSData *)data scale:(CGFloat)scale;
@end

