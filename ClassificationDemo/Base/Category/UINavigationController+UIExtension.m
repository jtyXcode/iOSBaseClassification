//
//  UINavigationController+YTExtension.m
//  SMART1
//
//  Created by 袁涛 on 2017/8/2.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import "UINavigationController+UIExtension.h"
#import <objc/runtime.h>
#import "UIViewController+UIExtension.h"

@implementation UINavigationController (UIExtension)

+ (void)initialize {
    if (self == [UINavigationController self]) {
        SEL originalSelector = NSSelectorFromString(@"_updateInteractiveTransition:");
        SEL swizzledSelector = NSSelectorFromString(@"yt__updateInteractiveTransition:");
        ReplaceMethod(self,originalSelector,swizzledSelector);
    }

}

/**
 创建屏蔽字典   控制器 : 透明度

 @return
 */
- (NSDictionary *)maskControllerDict {
    
    return @{
             @"TZAlbumPickerController" : @"1.0", //第三方图片选择库
             @"TZPhotoPickerController" : @"1.0",
             @"PUUIMomentsGridViewController" : @"1.0" //系统图片库
             };
}


- (NSString *)currentAlpha:(Class)class {
   return [[self maskControllerDict] objectForKey:NSStringFromClass(class)];
}

/**
 *  屏蔽当前控制器,避免出现问题
 */
- (BOOL)maskCurrentController:(UIViewController *)currentController {
    //屏蔽第三方框架
    
    for (NSString *key in [[self maskControllerDict] allKeys]) {
        if ([self.viewControllers.lastObject isMemberOfClass:NSClassFromString(key)]) {
            return YES;
        }
    }
    
    return NO;
}



- (void)setNeedsNavigationBackground:(CGFloat)alpha {
    // 导航栏背景透明度设置
    UIView *barBackgroundView = [[self.navigationBar subviews] objectAtIndex:0];// _UIBarBackground
//    YTLog(@"%@",self.navigationBar.subviews);
    UIImageView *backgroundImageView;
    for (UIView *view in barBackgroundView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            backgroundImageView = (UIImageView *)view;
            break;
        }
    }

    if (self.navigationBar.isTranslucent) {
        if (backgroundImageView != nil && backgroundImageView.image != nil) {
            barBackgroundView.alpha = alpha;
        } else {
            //barBackgroundView.subviews.count Be on the cards equal to 1
            UIView *backgroundEffectView = [[barBackgroundView subviews] objectAtIndex:barBackgroundView.subviews.count > 1 ? 1 : 0];//  兼容7.0以及以上的版本  8.0以后存在UIVisualEffectView
                if (backgroundEffectView != nil) {
                    backgroundEffectView.alpha = alpha;
                    if (__iOS8_0__) {
                        barBackgroundView.alpha = alpha;
                    }
            }
        }
    } else {
        
        barBackgroundView.alpha = alpha;
    }

    self.navigationBar.clipsToBounds = (alpha == 0.0);
    
    
}


//



- (void)yt_updateInteractiveTransition:(CGFloat)percentComplete {
    [self yt_updateInteractiveTransition:(percentComplete)];
    UIViewController *topVC = self.topViewController;
    if (topVC != nil) {
        
        id<UIViewControllerTransitionCoordinator> coor = topVC.transitionCoordinator;
        if (coor != nil) {
            
            CGFloat fromAlpha = [[coor viewControllerForKey:UITransitionContextFromViewControllerKey].navBarBgAlpha floatValue];
            CGFloat toAlpha = [[coor viewControllerForKey:UITransitionContextToViewControllerKey].navBarBgAlpha floatValue];
            CGFloat nowAlpha = fromAlpha + (toAlpha - fromAlpha) * percentComplete;
//            YTLog(@"from:%f, to:%f, now:%f",fromAlpha, toAlpha, nowAlpha);
            [self setNeedsNavigationBackground:nowAlpha];
        }
    }
}


#pragma mark - UINavigationController Delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UIViewController *topVC = self.topViewController;
    if (topVC != nil) {
        id<UIViewControllerTransitionCoordinator> coor = topVC.transitionCoordinator;
        if (coor != nil) {
            if (__iOS10_0__) {
                [coor notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                   [self dealInteractionChanges:context];
                }];
            }else {
                [coor notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                    [self dealInteractionChanges:context];
                }];
            }
            
                //
        }
    }
}



- (void)dealInteractionChanges:(id<UIViewControllerTransitionCoordinatorContext>)context {
    if ([context isCancelled]) {// 自动取消了返回手势
        NSTimeInterval cancelDuration = [context transitionDuration] * (double)[context percentComplete];
        [UIView animateWithDuration:cancelDuration animations:^{
            CGFloat nowAlpha = [[context viewControllerForKey:UITransitionContextFromViewControllerKey].navBarBgAlpha floatValue];
            //NSLog(@"自动取消返回到alpha：%f", nowAlpha);
            [self setNeedsNavigationBackground:nowAlpha];
        }];
    } else {// 自动完成了返回手势
        NSTimeInterval finishDuration = [context transitionDuration] * (double)(1 - [context percentComplete]);
        [UIView animateWithDuration:finishDuration animations:^{
            CGFloat nowAlpha = [[context viewControllerForKey:
                                 UITransitionContextToViewControllerKey].navBarBgAlpha floatValue];
            //NSLog(@"自动完成返回到alpha：%f", nowAlpha);
            [self setNeedsNavigationBackground:nowAlpha];
        }];
    }
}

#pragma mark - UINavigationBar Delegate

//- (void)


- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item {
    if (self.viewControllers.count >= navigationBar.items.count) {// 点击返回按钮

        UIViewController *popToVC = self.viewControllers[self.viewControllers.count - 1];
        if ([self maskCurrentController:popToVC]) {
            popToVC.navBarBgAlpha = [self currentAlpha:[popToVC class]];
        }
        [self setNeedsNavigationBackground:[popToVC.navBarBgAlpha floatValue]];
        //        [self popViewControllerAnimated:YES];
    }
    
}

- (void)navigationBar:(UINavigationBar *)navigationBar didPushItem:(UINavigationItem *)item {
    // push到一个新界面
    if ([self maskCurrentController:self.topViewController]) {
        
        CGFloat alpha = [[self currentAlpha:[self.topViewController class]] floatValue];
        [self setNeedsNavigationBackground:alpha];
    }else {
        [self setNeedsNavigationBackground:[self.topViewController.navBarBgAlpha floatValue]];
    }
    
}


#pragma mark - other
- (nullable UIViewController *)yt_rootViewController {
    return self.viewControllers.firstObject;
}



@end
