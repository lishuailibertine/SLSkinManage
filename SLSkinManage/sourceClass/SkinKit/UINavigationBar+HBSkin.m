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
static char barBackgroundColorKey;
#pragma mark -private
- (void)setSl_barBackgroundImage:(NSString *)sl_barBackgroundImage{
    objc_setAssociatedObject(self, &barBackgroundImageKey, sl_barBackgroundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_barBackgroundImage{
    return objc_getAssociatedObject(self, &barBackgroundImageKey);
}
- (void)setSl_barBackgroundColor:(NSString *)sl_barBackgroundColor{
    objc_setAssociatedObject(self, &barBackgroundColorKey, sl_barBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_barBackgroundColor{
    return objc_getAssociatedObject(self, &barBackgroundColorKey);
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
- (void)setSkin_barBackground_color:(NSString *)skin_barBackground_color{
    [self setObserver:self];
    if (skin_barBackground_color) {
        self.sl_barBackgroundColor =skin_barBackground_color;
        [self updateBarBackgroundColor];
    }
}
- (NSString *)skin_barBackground_color{
    return self.sl_barBackgroundColor;
}
- (void)updateStyle{
    [super updateStyle];
    if (self.sl_barBackgroundImage) {
        [self updateBarBackgroundImage];
    }
    if (self.sl_barBackgroundColor) {
        [self updateBarBackgroundColor];
    }
}
#pragma mark private
- (void)updateBarBackgroundImage{
    [self navigationBarColorImage:[SLSkinStyleParse imageForKey:self.sl_barBackgroundImage]];
}
- (void)updateBarBackgroundColor{
    [self navigationBarColor:[SLSkinStyleParse colorForKey:self.sl_barBackgroundColor]];
}
-(void)navigationBarColorImage:(UIImage *)image{
    self.translucent = NO;
    [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}
-(void)navigationBarColor:(UIColor *)color{
    self.translucent = NO;
    [self setBackgroundImage:[self imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
}
- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
@end
