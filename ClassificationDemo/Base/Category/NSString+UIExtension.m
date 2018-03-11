//
//  NSString+UIExtension.m
//  ClassificationDemo
//
//  Created by 袁涛 on 2017/12/2.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import "NSString+UIExtension.h"
#import "NSObject+UIExtension.h"

@implementation NSString (UIExtension)

+ (NSString *)hexLetterStringWithInteger:(NSInteger)integer {
    NSAssert(integer < 16, @"要转换的数必须是16进制里的个位数，也即小于16，但你传给我是%@", @(integer));
    
    NSString *letter = nil;
    switch (integer) {
        case 10:
            letter = @"A";
            break;
        case 11:
            letter = @"B";
            break;
        case 12:
            letter = @"C";
            break;
        case 13:
            letter = @"D";
            break;
        case 14:
            letter = @"E";
            break;
        case 15:
            letter = @"F";
            break;
        default:
            letter = [[NSString alloc]initWithFormat:@"%@", @(integer)];
            break;
    }
    return letter;
}

+ (NSString *)yt_hexStringWithInteger:(NSInteger)integer {
    
    NSString *hexString = @"";
    NSInteger remainder = 0;
    for (NSInteger i = 0; i < 9; i++) {
        remainder = integer % 16;
        integer = integer / 16;
        NSString *letter = [self hexLetterStringWithInteger:remainder];
        hexString = [letter stringByAppendingString:hexString];
        if (integer == 0) {
            break;
        }
        
    }
    return hexString;
}

- (Class)Class {
    return NSClassFromString(self);
}

- (BOOL)checkTelPhone {
    return [NSObject checkTelNumber:self];
}

- (BOOL)checkpwd {
    return [NSObject checkPassword:self];
}

- (BOOL)checkUserIdCard {
    return [NSObject checkPassword:self];
}
- (BOOL)regularPattern:(NSString *)pattern {
    return [NSObject regularPattern:pattern RegStr:self];
}

- (nullable NSArray<NSString *> *)regularPatterByArray:(NSString *)pattern {
    return [NSObject RegularText:self pattern:pattern];
}

- (BOOL)copyStr {
    if (self.length == 0) {
        return NO;
    }
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self;
    return YES;
}

- (nullable NSString *)md5 {
    return [NSObject md5:self];
}

+ (NSString *)fileSizeWithInterge:(NSInteger)size{
    // 1k = 1024, 1m = 1024k
    if (size < 1024) {// 小于1k
        return [NSString stringWithFormat:@"%ldB",(long)size];
    }else if (size < 1024 * 1024){// 小于1m
        CGFloat aFloat = size/1024;
        return [NSString stringWithFormat:@"%.0fK",aFloat];
    }else if (size < 1024 * 1024 * 1024){// 小于1G
        CGFloat aFloat = size/(1024 * 1024);
        return [NSString stringWithFormat:@"%.1fM",aFloat];
    }else{
        CGFloat aFloat = size/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.1fG",aFloat];
    }
}



//- (CGRect)sizeToBounds {
//    self boundingRectWithSize:<#(CGSize)#> options:<#(NSStringDrawingOptions)#> attributes:self context:(nullable NSStringDrawingContext *)
//}


@end

@implementation NSString (Josn)
- (NSDictionary *)jsonStringToDict{

    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if (err) {
        return nil;
    }
    return dic;
}

- (NSArray *)jsonStringToArray{
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if (err) {
        return nil;
    }
    return array;
}

@end

@implementation NSString (HandleHTML)

- (NSString *)handleHTMLIMG {
    NSArray *imgs = [NSObject RegularText:self pattern:@"<img(.*?)>"];
    if (ArrayIsEmpty(imgs)) {
        return self;
    }
    
    NSMutableArray *temps = [NSMutableArray array];
    
    for (NSString *rangeStr in imgs) {
        NSMutableString *s = [NSMutableString stringWithFormat:@"%@", [self substringWithRange:NSRangeFromString(rangeStr)]];
        if (![s containsString:@"style=\"width:100%\""]) {
            NSArray *arr = [NSObject RegularText:s pattern:@"style=\"[^\"]*?\""];
            if (!ArrayIsEmpty(arr)) {
                s = [NSMutableString stringWithFormat:@"%@", [s stringByReplacingOccurrencesOfString:[s substringWithRange:NSRangeFromString(arr[0])] withString:@"style=\"width:100%;\""]];
            }else {
                 [s insertString:@"style=\"width:100%;\"" atIndex:5];
            }
        }
        [temps addObject:s];
    }
    
    return [temps componentsJoinedByString:@""];
    
}

@end



