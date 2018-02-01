//
//  UILabel+HBSkin.m
//  HBStockWarning
//
//  Created by Touker on 2017/11/29.
//  Copyright © 2017年 Touker. All rights reserved.
//

#import "UILabel+HBSkin.h"
#import "NSObject+HBSkinNotify.h"
#import "UIView+HBSkin.h"
#import "SLSkinStyleParse.h"
#import <objc/runtime.h>

@implementation UILabel (HBSkin)
static char textColorKey;
#pragma mark -private
- (void)setSl_textColor:(NSString *)textColor{
    objc_setAssociatedObject(self, &textColorKey, textColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_textColor{
    return objc_getAssociatedObject(self, &textColorKey);
}
#pragma mark -public
- (void)setSkin_title_color:(NSString *)skin_title_color{
    [self setObserver:self];
    if (skin_title_color) {
        self.sl_textColor =skin_title_color;
        [self updateTitleColor];
    }
}
- (NSString *)skin_title_color{
    return self.sl_textColor;
}
- (void)updateStyle{
    [super updateStyle];
    if (self.sl_textColor) {
        [self updateTitleColor];
    }
}
#pragma mark private
- (void)updateTitleColor
{
    self.textColor =[SLSkinStyleParse colorForKey:self.sl_textColor];
}
@end
