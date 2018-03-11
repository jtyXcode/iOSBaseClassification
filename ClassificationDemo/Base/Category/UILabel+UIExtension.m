//
//  UILabel+UIExtension.m
//  ClassificationDemo
//
//  Created by 袁涛 on 2017/11/25.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import "UILabel+UIExtension.h"

@implementation UILabel (UIExtension)
#pragma mark - Class Method

+ (__kindof instancetype)LabelWithFrame:(CGRect)frame Font:(UIFont *)font Title:(NSString *)title{
    UILabel *label = [[[self class] alloc] initWithFrame:frame];
    label.text = title;
    label.font = font;
    return label;
}

+ (__kindof instancetype)LabelWithFont:(UIFont *)font Title:(NSString *)title {
    UILabel *label = [[[self class] alloc] init];
    label.text = title;
    label.font = font;
    return label;
}

+ (__kindof instancetype)LabelWithFont:(UIFont *)font backgrondColor:(UIColor *)backgrondColor titleColor:(UIColor *)titleColor Title:(NSString *)title {
    UILabel *label = [[self class] LabelWithFont:font Title:title];
    label.textColor = titleColor;
    label.backgroundColor = backgrondColor;
    label.font = font;
    return label;
}


+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}

@end


@implementation UILabel (AttributedString)
- (void)labelStartLoactionStr:(NSString *)startStr endStr:(NSString *)endStr Attributed:(NSDictionary<NSAttributedStringKey, id> *)attrs {
    if (self.text == 0 || startStr.length == 0) {
        return;
    }
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSRange newRang;
    NSRange rang = [self.text rangeOfString:startStr];
    NSUInteger loacation = rang.location + (rang.length == 1 ? 0 : rang.length - 1);
    if (endStr.length > 0) {
        NSRange endRang = [self.text rangeOfString:endStr];
        if (endRang.length == 0) {
            return;
        }
        newRang = NSMakeRange(loacation , endRang.location - loacation);
    }else {
        
      newRang = NSMakeRange(loacation, self.text.length - loacation);
    }
    [attributedText addAttributes:attrs range:newRang];
    self.attributedText = attributedText;
}

- (void)labelStartLoactionStr:(NSString *)startStr Attributed:(NSDictionary<NSAttributedStringKey, id> *)attrs {
    [self labelStartLoactionStr:startStr endStr:@"" Attributed:attrs];
}

@end


static const char *yt_LabelMaxSize = "yt_LabelMaxSize";
@implementation UILabel (Caculation)

+ (CGFloat)getHeightByWidth:(CGFloat)width font:(UIFont *)font title:(NSString *)title
{
    
    UILabel *label = [UILabel LabelWithFrame:CGRectMake(0, 0, width, 0) Font:font Title:title];
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}

+ (CGSize)getSizeBySize:(CGSize)MaxSize Font:(UIFont *)font options:(NSStringDrawingOptions)options Title:(NSString *)title{
    /*
     typedef NS_ENUM(NSInteger, NSLineBreakMode) {
     NSLineBreakByWordWrapping = 0,         // Wrap at word boundaries, default
     NSLineBreakByCharWrapping,        // Wrap at character boundaries
     NSLineBreakByClipping,        // Simply clip
     NSLineBreakByTruncatingHead,    // Truncate at head of line: "...wxyz"
     NSLineBreakByTruncatingTail,    // Truncate at tail of line: "abcd..."
     NSLineBreakByTruncatingMiddle    // Truncate middle of line:  "ab...yz"
     } NS_ENUM_AVAILABLE(10_0, 6_0);
     */
    NSDictionary *attributes = @{
                                 NSFontAttributeName : font
                                 //        NSParagraphStyleAttributeName : NSParagraphStyle
                                 };
    
    if (options == 0) {
        CGSize size = [title boundingRectWithSize:MaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        return size;
    }
    if (options != 0) {
        CGSize size = [title boundingRectWithSize:MaxSize options:options attributes:attributes context:nil].size;
        return size;
    }
    return CGSizeZero;
}


- (void)setMaxSize:(CGSize)MaxSize {
    objc_setAssociatedObject(self, yt_LabelMaxSize, NSStringFromCGSize(MaxSize), OBJC_ASSOCIATION_ASSIGN);
}

- (CGSize)MaxSize {
    return  CGSizeFromString(objc_getAssociatedObject(self, yt_LabelMaxSize));
}

- (CGFloat)getHeight {
    if (self.text.length == 0) {
        return self.frame.size.height;
    }
    
    CGFloat height = 0;
    CGSize size;
    if (self.MaxSize.width == 0 && self.MaxSize.height == 0) {
        self.MaxSize = CGSizeMake(self.frame.size.width, MAXFLOAT);
    }
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName : self.font
                                 //        NSParagraphStyleAttributeName : NSParagraphStyle
                                 };
    
    if (self.attributedText.length > 0) {
//        size = [title boundingRectWithSize:self.MaxSize options: attributes:self.attributedText context:nil].size;
        size = [self.text boundingRectWithSize:self.MaxSize options:NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    }else {
        size = [self.text boundingRectWithSize:self.MaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    }
    height = size.height;
    return height;
}



@end



