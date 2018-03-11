//
//  NSDate+UIExtension.h
//  ClassificationDemo
//
//  Created by 袁涛 on 2017/12/5.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (UIExtension)

#pragma mark - Component Properties
@property (nonatomic, readonly) NSInteger year;
@property (nonatomic, readonly) NSInteger month;
@property (nonatomic, readonly) NSInteger day;
@property (nonatomic, readonly) NSInteger hours;
@property (nonatomic, readonly) NSInteger minute;
@property (nonatomic, readonly) NSInteger second;
@property (nonatomic, readonly) NSInteger weekday;

@property (nonatomic, readonly) BOOL isToday;


/**
 <#Description#>

 @param format  @"yyyy-MM-dd HH:mm:ss"
 @return <#return value description#>
 */
- (nullable NSString *)stringWithFormat:(NSString *_Nullable)format;

/** NSDate -> long long */
+(long long)longLongFromDate:(NSDate*)date;

@end
