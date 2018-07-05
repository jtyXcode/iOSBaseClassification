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

- (void)enumerateObjectsUsingAnsyBlock:(void (^)(id _Nonnull, NSUInteger))block {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSInteger index = 0;
        for (id subObject in self) {
            block(subObject,index);
            index ++;
        }
    });
}

- (NSArray <id>*)enumerateObjectsUsingAnsyParsingBlock:(id(^)(id _Nonnull,NSUInteger))block{
    __block NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:5];
    __block dispatch_semaphore_t semaphore_t = dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSInteger index = 0;
        for (id subObject in self) {
            [arrayM addObject:block(subObject,index)];
            index ++;
        }
        dispatch_semaphore_signal(semaphore_t);
    });
   	dispatch_semaphore_wait(semaphore_t, DISPATCH_TIME_FOREVER);

    return arrayM;

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
    __block NSInteger i = index;
    [objects enumerateObjectsUsingAnsyBlock:^(id _Nonnull objc, NSUInteger j) {
        [self insertObject:objc atIndex:i++];
    }];    
}


@end


