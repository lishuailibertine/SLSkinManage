//
//  SLSkinManage.h
//  AFNetworking
//
//  Created by Touker on 2018/1/31.
//

#import <Foundation/Foundation.h>

@interface SLSkinManage : NSObject
//当前的资源包
@property (nonatomic, copy,readonly) NSString * currentBundleID;

+ (instancetype)sharedSkinManage;

- (void)installSkinByBundlePath:(NSString *)bundlePath;

- (void)installSkinByBundlePath:(NSString *)bundlePath
                     configName:(NSString *)configName
                     configType:(NSString *)configType
                  installResult:(void(^)(NSError *error))installResult;
//安装完，需手动根据bundleID进行皮肤更新
- (void)notifyUpdateByBundleID:(NSString *)bundleID;
@end


@interface SLSkinManage (SLSkinSourceManage)
+ (NSBundle *)getBundleWithBundleName:(NSString *)bundleName;
@end
