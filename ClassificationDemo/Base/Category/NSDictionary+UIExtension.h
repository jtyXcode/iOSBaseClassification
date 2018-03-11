//
//  NSDictionary+UIExtension.h
//  ClassificationDemo
//
//  Created by 袁涛 on 2017/12/5.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (UIExtension)

@end

@interface NSDictionary (Json)
- (NSString *)convertToJsonData;
+ (NSDictionary *)dictWithData:(NSData *)jsonData;
//key的 ascii 排序
- (NSString *)keyASCIIStore;
@end
