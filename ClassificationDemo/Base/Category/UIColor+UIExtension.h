//
//  UIColor+UIExtension.h
//  ClassificationDemo
//
//  Created by 袁涛 on 2017/11/30.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (UIExtension)
+ (UIColor *)yt_colorWithHexString:(NSString *)hexString;
+ (UIColor *)yt_randomColor;

/**
 *  将当前色值转换为hex字符串，通道排序是AARRGGBB（与Android保持一致）
 */
- (NSString *)yt_hexString;
/**
 *  获取当前UIColor对象里的红色色值
 *
 *  @return 红色通道的色值，值范围为0.0-1.0
 */

- (CGFloat)yt_red;
/**
 *  获取当前UIColor对象里的绿色色值
 *
 *  @return 绿色通道的色值，值范围为0.0-1.0
 */
- (CGFloat)yt_green;

/**
 *  获取当前UIColor对象里的蓝色色值
 *
 *  @return 蓝色通道的色值，值范围为0.0-1.0
 */
- (CGFloat)yt_blue;

/**
 *  获取当前UIColor对象里的透明色值
 *
 *  @return 透明通道的色值，值范围为0.0-1.0
 */
- (CGFloat)yt_alpha;

/**
 *  获取当前UIColor对象里的hue（色相）
 */
- (CGFloat)yt_hue;

/**
 *  获取当前UIColor对象里的saturation（饱和度）
 */
- (CGFloat)yt_saturation;

/**
 *  获取当前UIColor对象里的brightness（亮度）
 */
- (CGFloat)yt_brightness;

/**
 *  将当前UIColor对象剥离掉alpha通道后得到的色值。相当于把当前颜色的半透明值强制设为1.0后返回
 *
 *  @return alpha通道为1.0，其他rgb通道与原UIColor对象一致的新UIColor对象
 */
- (UIColor *)yt_colorWithoutAlpha;

/**
 *  计算当前color叠加了alpha之后放在指定颜色的背景上的色值
 */
- (UIColor *)yt_colorWithAlpha:(CGFloat)alpha backgroundColor:(UIColor *)backgroundColor;

/**
 *  计算当前color叠加了alpha之后放在白色背景上的色值
 */
- (UIColor *)yt_colorWithAlphaAddedToWhite:(CGFloat)alpha;

/**
 *  将自身变化到某个目标颜色，可通过参数progress控制变化的程度，最终得到一个纯色
 *  @param toColor 目标颜色
 *  @param progress 变化程度，取值范围0.0f~1.0f
 */
- (UIColor *)yt_transitionToColor:(UIColor *)toColor progress:(CGFloat)progress;
@end
