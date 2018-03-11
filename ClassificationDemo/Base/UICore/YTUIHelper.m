//
//  YTUIHelper.m
//  ClassificationDemo
//
//  Created by 袁涛 on 2017/12/2.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import "YTUIHelper.h"

@implementation YTUIHelper

+ (void)inspectContextSize:(CGSize)size {
    if (size.width < 0 || size.height < 0) {
        NSAssert(NO, @"QMUI CGPostError, %@:%d %s, 非法的size：%@\n%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__, NSStringFromCGSize(size), [NSThread callStackSymbols]);
    }
}

+ (void)inspectContextIfInvalidatedInDebugMode:(CGContextRef)context {
    if (!context) {
        // crash了就找zhoon或者molice
        NSAssert(NO, @"QMUI CGPostError, %@:%d %s, 非法的context：%@\n%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__, context, [NSThread callStackSymbols]);
    }
}

+ (BOOL)inspectContextIfInvalidatedInReleaseMode:(CGContextRef)context {
    if (context) {
        return YES;
    }
    return NO;
}

static CGFloat pixelOne = -1.0f;
+ (CGFloat)pixelOne {
    if (pixelOne < 0) {
        pixelOne = 1 / ScreenScale;
    }
    return pixelOne;
}


@end
