//
//  NSObject+HBSkinNotify.m
//  HBStockWarning
//
//  Created by Touker on 2017/11/29.
//  Copyright © 2017年 Touker. All rights reserved.
//

#import "NSObject+HBSkinNotify.h"
//返回列表是因为有些主题元素不是继承`UIView`的
static NSArray * themeObserverWhiteLists(){
    return @[[UIView class]];
}
NSString *const HBNotificationSkinUpdate =@"skinUpdate";
static const char *isNSNotification = "isNSNotification";
@implementation NSObject (HBSkinNotify)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        for (Class observerClass in themeObserverWhiteLists()) {
            if ([[self class] isKindOfClass:observerClass]) {
                [NSObject swizzlingInstance:objc_getClass("NSNotificationCenter") orginalMethod:NSSelectorFromString(@"addObserver:selector:name:object:") replaceMethod:NSSelectorFromString(@"theme_addObserver:selector:name:object:")];
                [NSObject swizzlingInstance:self orginalMethod:NSSelectorFromString(@"dealloc") replaceMethod:NSSelectorFromString(@"theme_dealloc")];
                return ;
            }
        }
    });
}
#pragma mark -setter getter
-(void)setIsNSNotification:(BOOL)yesOrNo{
    objc_setAssociatedObject(self, isNSNotification, @(yesOrNo), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)isNSNotification{
    NSNumber *number = objc_getAssociatedObject(self, isNSNotification);;
    return  [number boolValue];
}
#pragma mark - Public
- (void)setObserver:(id)object{
    if (![self isNSNotification]){
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateSkin:)
                                                     name:HBNotificationSkinUpdate
                                                   object:nil];
    }
}
#pragma NSNotification
-(void)skin_addObserver:(id)observer selector:(SEL)aSelector name:(nullable NSNotificationName)aName object:(nullable id)anObject{
    if (aName==HBNotificationSkinUpdate) {
       [observer setIsNSNotification:YES];
    }
    [self skin_addObserver:observer selector:aSelector name:aName object:anObject];
}
#pragma mark -- private
#pragma mark - theme_dealloc
-(void)skin_dealloc{
    if ([self isNSNotification]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    [self skin_dealloc];
}
- (void)updateSkin:(NSNotification *)notification{
    if ([notification.name isEqualToString:HBNotificationSkinUpdate]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
        [self performSelector:@selector(updateStyle) withObject:nil];
#pragma clang diagnostic pop
    }
}
+(BOOL)swizzlingInstance:(Class)clz orginalMethod:(SEL)originalSelector  replaceMethod:(SEL)replaceSelector{
    
    Method original = class_getInstanceMethod(clz, originalSelector);
    Method replace = class_getInstanceMethod(clz, replaceSelector);
    BOOL didAddMethod =
    class_addMethod(clz,
                    originalSelector,
                    method_getImplementation(replace),
                    method_getTypeEncoding(replace));
    
    if (didAddMethod) {
        class_replaceMethod(clz,
                            replaceSelector,
                            method_getImplementation(original),
                            method_getTypeEncoding(original));
    } else {
        method_exchangeImplementations(original, replace);
    }
    return YES;
}
@end
