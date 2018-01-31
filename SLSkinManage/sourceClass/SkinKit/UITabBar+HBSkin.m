//
//  UITabBar+HBSkin.m
//  SLTestViewAnimation
//
//  Created by Touker on 2017/12/4.
//  Copyright © 2017年 Touker. All rights reserved.
//

#import "UITabBar+HBSkin.h"
#import "UIView+HBSkin.h"
#import <objc/runtime.h>
#import "NSObject+HBSkinNotify.h"
@implementation UITabBar (HBSkin)
static char tintColorKey;
#pragma mark -private
- (void)setSl_tintColor:(NSString *)sl_tintColor{
    objc_setAssociatedObject(self, &tintColorKey, sl_tintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_tintColor{
    return objc_getAssociatedObject(self, &tintColorKey);
}
- (void)setSkin_tintColor:(NSString *)skin_tintColor{
    [self setObserver:self];
    if (skin_tintColor) {
        self.sl_tintColor =skin_tintColor;
        [self updateTintColor];
    }
}
#pragma mark -public
- (NSString *)skin_tintColor{
    return self.sl_tintColor;
}
- (void)updateStyle{
    [super updateStyle];
    if (self.sl_tintColor) {
       [self updateTintColor];
    }
}
- (void)updateTintColor
{
//    HBSkinManage *skinManage = [HBSkinManage sharedSkinManage];
//    HBSkinModel * skinModel =[skinManage.skinModelDic objectForKey:skinManage.currentBundleID];
//    id propertyValue = [skinModel.barTintColorDic valueForKey:self.hb_tintColor];
//    self.barTintColor =[UIColor colorWithHexString:propertyValue alpha:1];
}
@end
