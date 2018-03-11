//
//  UIButton+S_Extension.h
//  ClassificationDemo
//
//  Created by 袁涛 on 2017/11/25.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (UIExtension)

- (void)setDefaultImage:(UIImage * __nullable )image;
- (void)setDefaultText:(NSString * __nullable )text;
- (void)setDefaultTextColor:(UIColor * __nullable)textColor;
- (void)setDefaultText:(NSString * __nullable )text TextColor:(UIColor * __nullable)textColor;

@end

@interface UIButton (FixMultiClick)
@property (assign, nonatomic) NSTimeInterval yt_acceptEventInterval;
@property (assign, nonatomic) NSTimeInterval yt_acceptEventTime;
@end

