//
//  NSStringTests.m
//  ClassificationDemoTests
//
//  Created by 袁涛 on 2018/7/6.
//  Copyright © 2018年 Y_T. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+UIExtension.h"

@interface NSStringTests : XCTestCase

@end

@implementation NSStringTests

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

- (void)testReverseString {
    NSString *a = @"-321";
    NSString *b = [a reverseString];
    XCTAssertEqual(b, @"123-");
    
}


@end
