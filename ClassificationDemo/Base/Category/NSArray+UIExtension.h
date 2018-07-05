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

/**
 异步遍历数组

 @param block 遍历回调
 */
- (void)enumerateObjectsUsingAnsyBlock:(void (^)(id _Nonnull, NSUInteger))block;

/**
 解析数据

 @param block 返回解析的数据
 @return 返回数组
 */
- (NSArray <id>*)enumerateObjectsUsingAnsyParsingBlock:(id(^)(id _Nonnull,NSUInteger))block;
+ (NSArray *)arrayWithData:(NSData *)jsonData;

@end


@interface NSArray (Manipulation)
- (id)objectOrNilAtIndex:(NSUInteger)index;
@end


@interface NSMutableArray (Manipulation)
- (void)removeFirstObject;
- (void)removeLastObjects;

/**
 把数组元素按顺序依次插入到当前数组的头部

 @param objects 插入同类型数组
 */
- (void)prependObject:(NSArray *)objects;

/**
 把数组元素按顺序依次插入到当前数组的指定位置

 @param objects 插入同类型数组
 @param index 指定插入的位置
 */
- (void)insertObjects:(NSArray *)objects atIndex:(NSUInteger)index;
@end
