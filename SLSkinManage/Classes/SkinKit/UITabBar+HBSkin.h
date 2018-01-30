//
//  UITabBar+HBSkin.h
//  SLTestViewAnimation
//
//  Created by Touker on 2017/12/4.
//  Copyright © 2017年 Touker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (HBSkin)
@property (copy,nonatomic) IBInspectable NSString *skin_tintColor;
- (void)updateStyle;
@end
