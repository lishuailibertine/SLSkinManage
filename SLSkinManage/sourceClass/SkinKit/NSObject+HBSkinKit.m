//
//  NSObject+HBSkinKit.m
//  AFNetworking
//
//  Created by Touker on 2018/2/5.
//

#import "NSObject+HBSkinKit.h"
#import "NSObject+HBSkinNotify.h"
#import "SLSkinStyleParse.h"
#import <objc/runtime.h>
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


@implementation UIBarButtonItem (HBSkin)
@end

@implementation UIButton (HBSkin)
@end

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


@implementation UITabBarItem (HBSkin)
static char tabbarImageNameKey;
static char tabbarSelectedImageNameKey;
#pragma mark -private
- (void)setSl_imageName:(NSString *)sl_imageName{
    objc_setAssociatedObject(self, &tabbarImageNameKey, sl_imageName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_imageName{
    return objc_getAssociatedObject(self, &tabbarImageNameKey);
}

- (void)setSl_selectedImage:(NSString *)sl_selectedImage{
    objc_setAssociatedObject(self, &tabbarSelectedImageNameKey, sl_selectedImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_selectedImage{
    return objc_getAssociatedObject(self, &tabbarSelectedImageNameKey);
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
