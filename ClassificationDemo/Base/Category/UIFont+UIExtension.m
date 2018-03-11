//
//  UIFont+UIExtension.m
//  ClassificationDemo
//
//  Created by 袁涛 on 2017/11/30.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import "UIFont+UIExtension.h"

#define PTSCALE (96 / 72)
#define PXTOPT(A) ((A) * PTSCALE)


@implementation UIFont (UIExtension)
+ (UIFont *)yt_lightSystemFontOfSize:(CGFloat)fontSize {
    return [UIFont systemFontOfSize:PXTOPT(fontSize)];
}

+ (UIFont *)yt_boldSystemFontOfSize:(CGFloat)fontSize {
    return [UIFont boldSystemFontOfSize:PXTOPT(fontSize)];
}



@end

