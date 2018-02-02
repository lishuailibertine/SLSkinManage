//
//  UINavigationBar+HBSkin.m
//  AFNetworking
//
//  Created by Touker on 2018/2/1.
//

#import "UINavigationBar+HBSkin.h"
#import "UIView+HBSkin.h"
#import "NSObject+HBSkinNotify.h"
#import "SLSkinStyleParse.h"
#import <objc/runtime.h>

@implementation UINavigationBar (HBSkin)
static char barBackgroundImageKey;
#pragma mark -private
- (void)setSl_barBackgroundImage:(NSString *)sl_barBackgroundImage{
    objc_setAssociatedObject(self, &barBackgroundImageKey, sl_barBackgroundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_barBackgroundImage{
    return objc_getAssociatedObject(self, &barBackgroundImageKey);
}
#pragma mark -public
- (void)setSkin_barBackground_image:(NSString *)skin_barBackground_image{
    [self setObserver:self];
    if (skin_barBackground_image) {
        self.sl_barBackgroundImage =skin_barBackground_image;
        [self updateBarBackgroundImage];
    }
}
- (NSString *)skin_barBackground_image{
    return self.sl_barBackgroundImage;
}
- (void)updateStyle{
    if (self.sl_barBackgroundImage) {
        [self updateBarBackgroundImage];
    }
}
#pragma mark private
- (void)updateBarBackgroundImage{
    [self navigationBarColorImage:[SLSkinStyleParse imageForKey:self.sl_barBackgroundImage]];
}
-(void)navigationBarColorImage:(UIImage *)image{
    self.translucent = NO;
    [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}
@end
