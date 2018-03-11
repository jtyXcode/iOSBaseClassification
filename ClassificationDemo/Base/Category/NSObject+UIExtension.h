//
//  NSObject+UIExtension.h
//  ClassificationDemo
//
//  Created by 袁涛 on 2017/11/29.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (UIExtension)

@end

@interface NSObject (Regular)
+ (BOOL)regularPattern:(NSString *)pattern RegStr:(NSString *)str;
/** 正则匹配手机号 */
+ (BOOL)checkTelNumber:(NSString *)telNumber;
/** 正则匹配用户密码 */
+ (BOOL)checkPassword:(NSString *) password;
/** 正则匹配用户姓名,20位的中文或英文 */
+ (BOOL)checkUserName : (NSString *) userName;
/**正则匹配用户身份证号*/
+ (BOOL)checkUserIdCard: (NSString *) idCard;

/** 正则匹配  URL不规则 */
+ (BOOL)checkURL : (NSString *) url;

/** 真实姓名正则 */
+ (BOOL)checkNAME:(NSString *)name;

#pragma mark -

/**
 返回rang

 @param text <#text description#>
 @param pattern 正则表达式
 @return <#return value description#>
 */
+ (nullable NSArray<NSString *> *)RegularText:(NSString *__nullable)text pattern:(NSString *_Nonnull)pattern;

@end

@interface NSObject (md5)
+ (NSString *)md5:(NSString *)inputText;
@end

@interface NSObject (yt_windows)
+ (UIWindow *)lastWindow;
/** 当前在页面显示的控制器 */
+ (UIViewController *)activityViewController;
@end



