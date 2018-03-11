//
//  NSArray+UIExtension.m
//  ClassificationDemo
//
//  Created by 袁涛 on 2017/12/5.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import "NSArray+UIExtension.h"

@implementation NSArray (UIExtension)

@end

@implementation NSArray (Json)
- (NSString *)convertToJsonData{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        return nil;
    }
    NSString *josnString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
 
    
    return josnString;
}
+ (NSArray *)arrayWithData:(NSData *)jsonData{
    if (jsonData == nil) {
        return nil;
    }
    NSError *err;
    NSArray *temps = [NSJSONSerialization JSONObjectWithData:jsonData
                                                     options:NSJSONReadingMutableContainers
                                                       error:&err];
    if (err) {
        return nil;
    }
    return temps;
}
@end

@implementation NSArray (Manipulation)

- (id)objectOrNilAtIndex:(NSUInteger)index {
    return  index < self.count ? self[index] : nil;
}

@end

@implementation NSMutableArray (Manipulation)

- (void)removeFirstObject{
    if (self.count) {
        [self removeObjectAtIndex:0];
    }
}

- (void)removeLastObjects{
    if (self.count) {
        [self removeObjectAtIndex:self.count - 1];
    }
}

- (void)prependObject:(NSArray *)objects{
    if (!objects) return;
    [self insertObjects:objects atIndex:0];
}

- (void)insertObjects:(NSArray *)objects atIndex:(NSUInteger)index {
    NSUInteger i = index;
    for (id obj in objects) {
        [self insertObject:obj atIndex:i++];
    }
}


@end


