//
//  UITabBarItem+HBSkin.m
//  SLTestViewAnimation
//
//  Created by Touker on 2017/12/4.
//  Copyright © 2017年 Touker. All rights reserved.
//

#import "UITabBarItem+HBSkin.h"
#import <objc/runtime.h>
#import "NSObject+HBSkinNotify.h"
@implementation UITabBarItem (HBSkin)
static char imageNameKey;
static char selectedImageNameKey;
#pragma mark -private
- (void)setSl_imageName:(NSString *)sl_imageName{
    objc_setAssociatedObject(self, &imageNameKey, sl_imageName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_imageName{
    return objc_getAssociatedObject(self, &imageNameKey);
}

- (void)setSl_selectedImage:(NSString *)sl_selectedImage{
    objc_setAssociatedObject(self, &selectedImageNameKey, sl_selectedImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_selectedImage{
    return objc_getAssociatedObject(self, &selectedImageNameKey);
}
#pragma mark -public
- (void)setSkin_image_name:(NSString *)skin_image_name{
    [self setObserver:self];
    if (skin_image_name) {
        self.sl_imageName =skin_image_name;
        [self updateTabBarItemImage];
    }
}
- (NSString *)skin_image_name{
    return self.sl_imageName;
}

- (void)setSkin_selectedImage_name:(NSString *)skin_selectedImage_name{
    [self setObserver:self];
    if (skin_selectedImage_name) {
        self.sl_selectedImage =skin_selectedImage_name;
        [self updateTabBarItemSelectedImage];
    }
}
- (NSString *)skin_selectedImage_name{
    return self.sl_selectedImage;
}
- (void)updateStyle{
    if (self.sl_imageName) {
        [self updateTabBarItemImage];
    }
    if (self.sl_selectedImage) {
        [self updateTabBarItemSelectedImage];
    }
}
#pragma mark private
- (void)updateTabBarItemImage
{
}
- (void)updateTabBarItemSelectedImage
{
}
@end
