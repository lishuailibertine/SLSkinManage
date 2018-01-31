//
//  SLSkinManage.h
//  AFNetworking
//
//  Created by Touker on 2018/1/31.
//

#import <Foundation/Foundation.h>
#import "NSError+SkinManage.h"
//皮肤配置文件中颜色map对应的key值(colors:默认)
extern NSString * const kSkinConfigColorForKey;
//皮肤配置文件中字体map对应的key值(fonts:默认)
extern NSString * const kSkinConfigFontForKey;
//皮肤配置文件中其他样式map对应的key值(others:默认)
extern NSString * const kSkinConfigFontForKey;
@interface SLSkinManage : NSObject
//当前的资源包ID
@property (nonatomic, copy,readonly) NSString * currentBundleID;
//皮肤管理实例
+ (instancetype)sharedSkinManage;
/**
 * 根据bundlePath安装皮肤(配置文件存储到本地)
 * bundlePath:皮肤资源包的路径
 * installResult:安装皮肤结果handle
 */
- (void)installSkinByBundlePath:(NSString *)bundlePath installResult:(void(^)(NSError *error))installResult;
/**
 * 根据bundlePath安装皮肤(配置文件存储到本地)
 * bundlePath:皮肤资源包的路径
 * configName:样式配置的文件名称
 * configType:样式配置文件的类型
 * installResult:安装皮肤结果handle
 */
- (void)installSkinByBundlePath:(NSString *)bundlePath configName:(NSString *)configName configType:(NSString *)configType installResult:(void(^)(NSError *error))installResult;
/**
 * 安装完，需手动根据bundleID进行皮肤更新
 * 根据皮肤资源ID更新皮肤
 * bundleID:皮肤资源ID
 */
- (void)notifyUpdateByBundleID:(NSString *)bundleID;
@end
@interface SLSkinManage (SLSkinSourceManage)
/**
 * 根据bundleName获取bundle
 */
+ (NSBundle *)getBundleWithBundleName:(NSString *)bundleName;
/**
 * 根据文件配置地址返回一个map
 */
+ (void)filePathToDic:(NSString *)filePath result:(void(^)(NSError *error,NSDictionary *dataDic))result;
/**
 * 保存一个对象到本地(键值对)
 */
+ (void)saveSourcesConfig:(id)object forKey:(NSString *)key;
/**
 * 根据key获取对象
 */
+ (id)getSourcesConfigForKey:(NSString *)key;
@end
