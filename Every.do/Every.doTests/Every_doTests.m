//
//  Every_doTests.m
//  Every.doTests
//
//  Created by Carl Udren on 1/26/16.
//  Copyright © 2016 Carl Udren. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface Every_doTests : XCTestCase

@end

@implementation Every_doTests

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

@end
