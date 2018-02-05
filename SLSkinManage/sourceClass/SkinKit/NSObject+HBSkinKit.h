//
//  NSObject+HBSkinKit.h
//  AFNetworking
//
//  Created by Touker on 2018/2/5.
//

#import <Foundation/Foundation.h>
@interface UIView (HBSkin)
@property (copy,nonatomic) IBInspectable NSString *skin_background_color;
@end

@interface UIBarButtonItem (HBSkin)
@end

@interface UIButton (HBSkin)
@end

@interface UIImageView (HBSkin)
@property (copy,nonatomic) IBInspectable NSString *skin_image;
@end

@interface UILabel (HBSkin)
@property (copy,nonatomic) IBInspectable NSString  *skin_title_color;
@end

@interface UINavigationBar (HBSkin)
@property (copy,nonatomic) IBInspectable NSString *skin_barBackground_image;
@property (copy,nonatomic) IBInspectable NSString *skin_barBackground_color;
@end

@interface UITabBarItem (HBSkin)
@property (copy,nonatomic) IBInspectable NSString *skin_image_name;
@property (copy,nonatomic) IBInspectable NSString *skin_selectedImage_name;
@end
