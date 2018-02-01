//
//  UIView+HBSkin.m
//  HBStockWarning
//
//  Created by Touker on 2017/11/29.
//  Copyright © 2017年 Touker. All rights reserved.
//

#import "UIView+HBSkin.h"
#import "NSObject+HBSkinNotify.h"
#import <objc/runtime.h>
#import "SLSkinStyleParse.h"

@implementation UIView (HBSkin)
static char backgroundColorKey;
#pragma mark -private
- (void)setSl_backgroundColor:(NSString *)sl_backgroundColor{
    objc_setAssociatedObject(self, &backgroundColorKey, sl_backgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_backgroundColor{
    return objc_getAssociatedObject(self, &backgroundColorKey);
}
#pragma mark -public
- (void)setSkin_background_color:(NSString *)skin_background_color{
    [self setObserver:self];
    if (skin_background_color) {
        self.sl_backgroundColor =skin_background_color;
        [self updateBackgroundColor];
    }
}
- (NSString *)skin_background_color{
    return self.sl_backgroundColor;
}
- (void)updateStyle{
    if (self.sl_backgroundColor) {
        [self updateBackgroundColor];
    }
}
#pragma mark private
- (void)updateBackgroundColor{
    self.backgroundColor =[SLSkinStyleParse colorForKey:self.sl_backgroundColor];
}
@end
