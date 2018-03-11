//
//  UIViewController+YTExtension.h
//  SMART1
//
//  Created by 袁涛 on 2017/8/2.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (UIExtension)
/** 获取和自身处于同一个UINavigationController里的上一个UIViewController */
@property (nullable, nonatomic, weak, readonly) UIViewController *yt_previousViewController;

/**
 当前控制器是否是present方式显示 是则返回 YES，否则返回 NO

 @return YES or NO
 */
- (BOOL)isPresented;
@end

@interface UIViewController (NavBar)

/**
 推荐在viewWillDisappear:中使用  导航栏透明度
 */
@property (copy, nonatomic) NSString *navBarBgAlpha;

@end
