//
//  UIImageView+UIExtension.h
//  ClassificationDemo
//
//  Created by 袁涛 on 2017/11/30.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (UIExtension)
+ (UIImageView *)createCenterImageOfImageView;
+ (UIImageView *)createImageViewToImageName:(NSString *)imageName;
@end
