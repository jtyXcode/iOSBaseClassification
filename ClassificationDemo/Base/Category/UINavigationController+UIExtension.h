//
//  UINavigationController+YTExtension.h
//  SMART1
//
//  Created by 袁涛 on 2017/8/2.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (UIExtension)<UIViewControllerTransitionCoordinator,UINavigationBarDelegate>

- (nullable UIViewController *)yt_rootViewController;

- (void)setNeedsNavigationBackground:(CGFloat)alpha;
@end
