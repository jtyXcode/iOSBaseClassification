//
//  NSArrayTests.m
//  ClassificationDemoTests
//
//  Created by 袁涛 on 2018/7/5.
//  Copyright © 2018年 Y_T. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSArray+UIExtension.h"

@interface NSArrayTests : XCTestCase

@end

@implementation NSArrayTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testAnsyJson {
    NSArray *array = @[@1,@2,@3,@4,@5];
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:1];
    NSLog(@"------");
    [array enumerateObjectsUsingAnsyBlock:^(NSNumber *num, NSUInteger index) {
        [arrayM addObject:num];
    }];
    NSLog(@"------");
    XCTAssertTrue(arrayM.count == 5);
}

- (void)testInsertJson {
    NSArray *array = @[@1,@2,@3,@4,@5];
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:1];
    [arrayM addObject:@9];
    [arrayM prependObject:array];
    
    XCTAssertTrue([arrayM[0] isEqualToNumber:@1]);
}

- (void)testParsingJson {
    NSArray *array = @[@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5,@1,@2,@3,@4,@5];
    NSArray *array1 = [array enumerateObjectsUsingAnsyParsingBlock:^NSNumber *(NSNumber * num, NSUInteger i) {
        return num;
    }];
    XCTAssertTrue(array1.count == 600);
}



@end
