//
//  NSDate+UIExtension.m
//  ClassificationDemo
//
//  Created by 袁涛 on 2017/12/5.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import "NSDate+UIExtension.h"

@implementation NSDate (UIExtension)

-(NSInteger)year {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitYear fromDate:self];
}

- (NSInteger)month {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitMonth fromDate:self];
}

- (NSInteger)day {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:self];
}

- (NSInteger)hours {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitHour fromDate:self];
}

- (NSInteger)minute {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitMinute fromDate:self];
}

- (NSInteger)second {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitSecond fromDate:self];
}

- (NSInteger)weekday {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitWeekday fromDate:self];
}

- (BOOL)isToday {
    if (fabs(self.timeIntervalSinceNow) >= 60 * 60 * 24) return NO;
    return [NSDate new].day == self.day;
}

- (nullable NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setLocale:[NSLocale currentLocale]];
    return [formatter stringFromDate:self];
}

/** NSDate -> long long */
+(long long)longLongFromDate:(NSDate*)date{
    return [date timeIntervalSince1970] * 1000;
}


@end
