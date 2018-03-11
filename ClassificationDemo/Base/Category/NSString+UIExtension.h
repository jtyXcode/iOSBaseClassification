//
//  NSString+UIExtension.h
//  ClassificationDemo
//
//  Created by 袁涛 on 2017/12/2.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (UIExtension)
/// 把某个十进制数字转换成十六进制的数字的字符串，例如“10”->“A”
+ (NSString *)yt_hexStringWithInteger:(NSInteger)integer;

- (Class)Class;
- (BOOL)checkTelPhone;
- (BOOL)checkpwd;
- (BOOL)checkUserIdCard;
- (BOOL)regularPattern:(NSString *)pattern;
- (nullable NSArray<NSString *> *)regularPatterByArray:(NSString *_Nullable)pattern;

- (nullable NSString *)md5;

/**
 判断并且拷贝字符串

 @return 
 */
- (BOOL)copyStr;
//- (CGRect)sizeToBounds;
+ (NSString *)fileSizeWithInterge:(NSInteger)size;


@end

@interface NSString (Josn)
- (nullable NSDictionary *)jsonStringToDict;
- (nullable NSArray *)jsonStringToArray;
@end

//处理html
@interface NSString (HandleHTML)
- (NSString *)handleHTMLIMG;
@end



