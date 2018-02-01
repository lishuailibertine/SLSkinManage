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
    //test 安装接口
    [[SLSkinManage sharedSkinManage] installSkinByBundlePath:((NSBundle *)[SLSkinManage getBundleWithBundleName:@"SkinStyle_Night"]).bundlePath configName:nil configType:nil installResult:^(NSError *error) {
        NSLog(@"%@",[SLSkinManage sharedSkinManage].currentConfigMap);
    }];
}
- (void)testStyleParse
{
    //test 样式解析
    UIColor * color = [SLSkinStyleParse colorForKey:@"c1"];
    NSLog(@"%@",color);
    [[SLSkinManage sharedSkinManage] notifyUpdateByBundleID:@"SkinStyle_Night"];
    UIColor * color_nigght = [SLSkinStyleParse colorForKey:@"c1"];
    NSLog(@"%@",color_nigght);
}
- (void)testGetImage
{
    //获取工程中某个bundle下的图片路径
    NSString * imagePath = [SLSkinManage getImagePathWithBundle:[SLSkinManage getBundleWithBundleName:@"SkinStyle_Light"] imageName:@"navBar" imageType:@"png" inDirectory:@"images"];
    NSLog(@"%@",imagePath);
    
}
@end

