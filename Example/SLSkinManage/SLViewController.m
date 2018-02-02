//
//  SLViewController.m
//  SLSkinManage
//
//  Created by lishuailibertine on 01/30/2018.
//  Copyright (c) 2018 lishuailibertine. All rights reserved.
//

#import "SLViewController.h"
#import <SLSkinManage/SLSkin.h>

@interface SLViewController ()

@end

@implementation SLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray * bundles =@[@"SkinStyle_Light",@"SkinStyle_Night"];
    [bundles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [[SLSkinManage sharedSkinManage] installSkinByBundlePath:((NSBundle *)[SLSkinManage getBundleWithBundleName:obj]).bundlePath installResult:^(NSError *error) {
        }];
    }];
    self.view.skin_background_color =@"c1";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[SLSkinManage sharedSkinManage] notifyUpdateByBundleID:@"SkinStyle_Night"];
    });
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
