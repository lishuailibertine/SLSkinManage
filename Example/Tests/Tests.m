//
//  SLSkinManageTests.m
//  SLSkinManageTests
//
//  Created by lishuailibertine on 01/30/2018.
//  Copyright (c) 2018 lishuailibertine. All rights reserved.


@import XCTest;
#import <SLSkinManage/SLSkin.h>

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    [[SLSkinManage sharedSkinManage] installSkinByBundlePath:((NSBundle *)[SLSkinManage getBundleWithBundleName:@"SkinStyle_Night"]).bundlePath configName:nil configType:nil installResult:^(NSError *error) {
        NSLog(@"%@",[SLSkinManage sharedSkinManage].currentConfigMap);
    }];

}

@end

