//
//  NSArray+UIExtension.h
//  ClassificationDemo
//
//  Created by 袁涛 on 2017/12/5.
//  Copyright © 2017年 Y_T. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (UIExtension)
@end

@interface NSArray (Json)
- (NSString *)convertToJsonData;
+ (NSArray *)arrayWithData:(NSData *)jsonData;
@end


@interface NSArray (Manipulation)
- (id)objectOrNilAtIndex:(NSUInteger)index;
@end


@interface NSMutableArray (Manipulation)
- (void)removeFirstObject;
- (void)removeLastObjects;
- (void)prependObject:(NSArray *)objects;
- (void)insertObjects:(NSArray *)objects atIndex:(NSUInteger)index;
@end
