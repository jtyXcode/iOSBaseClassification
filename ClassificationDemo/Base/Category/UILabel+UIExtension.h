//
//  UILabel+UIExtension.h
//  ClassificationDemo
//
//  Created by 袁涛 on 2017/11/25.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (UIExtension)

+ (__kindof instancetype)LabelWithFrame:(CGRect)frame Font:(UIFont *)font Title:(NSString *)title;
+ (__kindof instancetype)LabelWithFont:(UIFont *)font Title:(NSString *)title;
+ (__kindof instancetype)LabelWithFont:(UIFont *)font backgrondColor:(UIColor *)backgrondColor titleColor:(UIColor *)titleColor Title:(NSString *)title;

/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

//@property (copy, nonatomic) NSMutableParagraphStyle *paragraphStyle;

@end


@interface UILabel (AttributedString)
- (void)labelStartLoactionStr:(NSString *)startStr endStr:(NSString *)endStr Attributed:(NSDictionary<NSAttributedStringKey, id> *)attrs;
- (void)labelStartLoactionStr:(NSString *)startStr Attributed:(NSDictionary<NSAttributedStringKey, id> *)attrs;
@end

@interface UILabel (Caculation)

@property (assign, nonatomic) CGSize MaxSize; //最大尺寸

+ (CGFloat)getHeightByWidth:(CGFloat)width font:(UIFont *)font title:(NSString *)title ;

+ (CGSize)getSizeBySize:(CGSize)MaxSize Font:(UIFont *)font options:(NSStringDrawingOptions)options Title:(NSString *)title;

- (CGFloat)getHeight;

@end


