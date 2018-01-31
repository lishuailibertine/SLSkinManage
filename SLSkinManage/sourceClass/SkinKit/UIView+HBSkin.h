//
//  UIView+HBSkin.h
//  HBStockWarning
//
//  Created by Touker on 2017/11/29.
//  Copyright © 2017年 Touker. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIView (HBSkin)
@property (copy,nonatomic) IBInspectable NSString *skin_background_color;
- (void)updateStyle;
@end
