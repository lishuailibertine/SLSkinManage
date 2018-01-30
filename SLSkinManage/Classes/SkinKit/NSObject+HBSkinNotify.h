//
//  NSObject+HBSkinNotify.h
//  HBStockWarning
//
//  Created by Touker on 2017/11/29.
//  Copyright © 2017年 Touker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
extern NSString * const HBNotificationSkinUpdate;
@interface NSObject (HBSkinNotify)

- (void)setObserver:(id)object;
@end
