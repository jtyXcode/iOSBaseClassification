//
//  UIViewController+YTExtension.m
//  SMART1
//
//  Created by 袁涛 on 2017/8/2.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import "UIViewController+UIExtension.h"
#import "UINavigationController+UIExtension.h"
#import <objc/runtime.h>



@implementation UIViewController (YTExtension)

- (UIViewController *)yt_previousViewController {
    if (self.navigationController.viewControllers && self.navigationController.viewControllers.count > 1 && self.navigationController.topViewController == self) {
        NSUInteger count = self.navigationController.viewControllers.count;
        return (UIViewController *)[self.navigationController.viewControllers objectAtIndex:count - 2];
    }
    return nil;
}

- (BOOL)isPresented {
    UIViewController *viewController  = self;
    if (self.navigationController) {
        if (self.navigationController.yt_rootViewController != self) {
            return NO;
        }
        viewController = self.navigationController;
    }
    
    BOOL result = viewController.presentingViewController.presentedViewController == viewController;
    return result;
}


@end

static char *kNavBarBgAlpha = "yt_kNavBarBgAlpha";

@implementation UIViewController (NavBar)

- (void)setNavBarBgAlpha:(NSString *)navBarBgAlpha {
    objc_setAssociatedObject(self, kNavBarBgAlpha, navBarBgAlpha, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self.navigationController setNeedsNavigationBackground:[navBarBgAlpha floatValue]];
}

-(NSString *)navBarBgAlpha{
    return objc_getAssociatedObject(self, kNavBarBgAlpha);
}
@end

