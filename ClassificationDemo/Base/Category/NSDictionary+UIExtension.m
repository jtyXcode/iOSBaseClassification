//
//  NSDictionary+UIExtension.m
//  ClassificationDemo
//
//  Created by 袁涛 on 2017/12/5.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import "NSDictionary+UIExtension.h"

@implementation NSDictionary (UIExtension)

@end

@implementation NSDictionary (Json)
- (NSString *)convertToJsonData{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        return nil;
    }
    
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}
+ (NSDictionary *)dictWithData:(NSData *)jsonData{
    if (jsonData == nil) {
        return nil;
    }
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                            options:NSJSONReadingMutableContainers
                                            error:&err];
    
    if(err)
    {
        return nil;
    }
    return dic;
}


- (NSString *)keyASCIIStore {
    NSArray *allkey = [self allKeys];
    if (allkey.count == 0) {
        return @"";
    }
    NSArray *afterSortKeyArray = [allkey sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSComparisonResult resuest = [obj2 compare:obj1];
        return resuest;
    }];
    
    
    
//    NSMutableArray *valueArray = [NSMutableArray array];
//    for (NSString *key in afterSortKeyArray) {
//        [valueArray addObject:self[key]];
//    }
    
    NSMutableString *afterString = [NSMutableString string];
    for (NSString *key in afterSortKeyArray) {
        [afterString appendString:[NSString stringWithFormat:@"%@%@",key,self[key]]];
    }
    return afterString;
}


@end
