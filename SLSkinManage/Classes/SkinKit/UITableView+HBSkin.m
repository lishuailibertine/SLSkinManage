//
//  UITableView+HBSkin.m
//  SLTestViewAnimation
//
//  Created by Touker on 2017/12/4.
//  Copyright © 2017年 Touker. All rights reserved.
//

#import "UITableView+HBSkin.h"
#import "NSObject+HBSkinNotify.h"
#import "UIView+HBSkin.h"
#import <objc/runtime.h>
@implementation UITableView (HBSkin)
static char sl_splitLine_colorKey;
#pragma mark -private
- (void)setSl_splitLine_color:(NSString *)sl_splitLine_color{
    objc_setAssociatedObject(self, &sl_splitLine_colorKey, sl_splitLine_color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_splitLine_color{
    return objc_getAssociatedObject(self, &sl_splitLine_colorKey);
}
#pragma mark -public
- (void)setSkin_splitLine_color:(NSString *)skin_splitLine_color{
    [self setObserver:self];
    if (skin_splitLine_color) {
        self.sl_splitLine_color =skin_splitLine_color;
        [self updateSplitLineColorWithAlpha:1];
    }
}
- (NSString *)skin_splitLine_color{
    return self.sl_splitLine_color;
}
- (void)updateStyle{
    [super updateStyle];
    if (self.sl_splitLine_color) {
       [self updateSplitLineColorWithAlpha:1];
    }
}
#pragma mark private
- (void)updateSplitLineColorWithAlpha:(float)alpha
{
//    HBSkinManage *skinManage = [HBSkinManage sharedSkinManage];
//    HBSkinModel * skinModel =[skinManage.skinModelDic objectForKey:skinManage.currentBundleID];
//    id propertyValue = [skinModel.backGroundColorDic valueForKey:self.hb_splitLine_color];
//    self.separatorColor =[UIColor colorWithHexString:propertyValue alpha:alpha];
}
@end
