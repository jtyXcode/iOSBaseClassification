//
//  UITextField+UIExtension.m
//  cxfShopiOSApp
//
//  Created by 袁涛 on 2017/12/12.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import "UITextField+UIExtension.h"
#import <objc/runtime.h>

static char *kplaceholderColor = "yt_kplaceholderColor";

@implementation UITextField (UIExtension)






- (BOOL)inputStrLength:(NSUInteger)maxLength shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSInteger existedLength = self.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    if (existedLength - selectedLength + replaceLength  > maxLength) return NO;
    
    return YES;
}
@end
