//
//  UITextField+UIExtension.h
//  cxfShopiOSApp
//
//  Created by 袁涛 on 2017/12/12.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (UIExtension)

- (BOOL)inputStrLength:(NSUInteger)maxLength shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
@end
