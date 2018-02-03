//
//  UIImageView+HBSkin.m
//  SLTestViewAnimation
//
//  Created by Touker on 2017/12/6.
//  Copyright © 2017年 Touker. All rights reserved.
//

#import "UIImageView+HBSkin.h"
#import "UIView+HBSkin.h"
#import "NSObject+HBSkinNotify.h"
#import "SLSkinStyleParse.h"
#import <objc/runtime.h>
static char ImageKey;
@implementation UIImageView (HBSkin)

- (void)setSl_Image:(NSString *)sl_Image{
    objc_setAssociatedObject(self, &ImageKey, sl_Image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_Image{
    return objc_getAssociatedObject(self, &ImageKey);
}
#pragma mark -public
- (void)setSkin_image:(NSString *)skin_image{
    [self setObserver:self];
    if (skin_image) {
        self.sl_Image =skin_image;
        [self updateStyle];
    }
}
- (NSString *)skin_image{
    return self.sl_Image;
}
- (void)updateStyle{
    [super updateStyle];
    if (self.skin_image) {
        self.image =[SLSkinStyleParse imageForKey:self.skin_image];
    }
}
@end
