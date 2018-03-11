//
//  NSObject+UIExtension.m
//  ClassificationDemo
//
//  Created by 袁涛 on 2017/11/29.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import "NSObject+UIExtension.h"
#import "CommonCrypto/CommonDigest.h"

@implementation NSObject (UIExtension)

@end

@implementation NSObject (Regular)
+ (BOOL)regularPattern:(NSString *)pattern RegStr:(NSString *)str {
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}


#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber
{
    NSString *pattern = @"^1+[3578]+\\d{9}";
    return [self regularPattern:pattern RegStr:telNumber];
}

#pragma 正则匹配用户密码
+ (BOOL)checkPassword:(NSString *) password
{
    return YES;
//    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{8,20}$";
////    NSString *pattern = @"^[0-9A-Za-z]{8,16}$";
//    return [self regularPattern:pattern RegStr:password];
    
}

#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName
{
    NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5]{1,20}";
    return [self regularPattern:pattern RegStr:userName];
    
}

#pragma 正则匹配用户身份证号15或18位
+ (BOOL)checkUserIdCard: (NSString *) idCard
{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    return [self regularPattern:pattern RegStr:idCard];
}

#pragma 正则匹配  URL不规则
+ (BOOL)checkURL : (NSString *) url
{
    NSString *pattern = @"^[0-9A-Za-z]{1,50}";
    return [self regularPattern:pattern RegStr:url];
    
}

#pragma url

#pragma 真实姓名正则
+ (BOOL)checkNAME:(NSString *)name
{
    NSString *pattern = @"^[\u4e00-\u9fa5]+(·[\u4e00-\u9fa5]+)*$";
    return [self regularPattern:pattern RegStr:name];
    
}


#pragma mark -
+ (nullable NSArray<NSString *> *)RegularText:(NSString *__nullable)text pattern:(NSString *_Nonnull)pattern{
    if (text.length == 0) {
        return nil;
    }
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSArray *matches = [regex matchesInString:text options:0 range:NSMakeRange(0, text.length)];
    if (matches.count == 0) {
        return nil;
    }
    NSMutableArray <NSString *>*array = [NSMutableArray array];
    for (NSTextCheckingResult *result in [matches objectEnumerator]) {
        NSRange range = [result range];
        [array addObject:NSStringFromRange(range)];
    }
    return array;
}


@end

@implementation NSObject (md5)
+(NSString *)md5:(NSString *)inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}
@end


@implementation NSObject (yt_windows)
+ (UIWindow *)lastWindow {
    NSArray *windows = [UIApplication sharedApplication].windows;
    for (UIWindow *window in [windows reverseObjectEnumerator]) {
        if ([window isKindOfClass:[UIWindow class]] &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
            window.hidden = NO;
            window.userInteractionEnabled = YES;
            return window;
    }
    return [UIApplication sharedApplication].keyWindow;
}

- (UIViewController *)activityViewController
{
    UIViewController* activityViewController = nil;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if(window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows)
        {
            if(tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    NSArray *viewsArray = [window subviews];
    if([viewsArray count] > 0)
    {
        UIView *frontView = [viewsArray objectAtIndex:0];
        
        id nextResponder = [frontView nextResponder];
        
        if([nextResponder isKindOfClass:[UIViewController class]])
        {
            activityViewController = nextResponder;
        }
        else
        {
            activityViewController = window.rootViewController;
        }
    }
    
    UIViewController *topNavVC = nil;
    if ([activityViewController isKindOfClass:[UITabBarController class]]) {
        if (activityViewController.childViewControllers.count == 0) {
            return nil;
        }else {
            UITabBarController *vc = (UITabBarController *)activityViewController;
            topNavVC = vc.selectedViewController;
        }
    }
    
    if (topNavVC == nil) {
        topNavVC = activityViewController;
    }
    
    if ([topNavVC isKindOfClass:[UINavigationController class]]) {
        UINavigationController *vc = (UINavigationController *)topNavVC;
        UIViewController *topVC = vc.topViewController;
        return topVC;
    }
    
    return topNavVC;
}


@end



