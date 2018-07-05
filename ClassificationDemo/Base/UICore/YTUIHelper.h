//
//  YTUIHelper.h
//  ClassificationDemo
//
//  Created by 袁涛 on 2017/12/2.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface YTUIHelper : NSObject
+ (void)inspectContextIfInvalidatedInDebugMode:(CGContextRef _Nonnull)context;
+ (BOOL)inspectContextIfInvalidatedInReleaseMode:(CGContextRef _Nonnull)context;
+ (void)inspectContextSize:(CGSize)size;
/// 获取一像素的大小
+ (CGFloat)pixelOne;
@end


