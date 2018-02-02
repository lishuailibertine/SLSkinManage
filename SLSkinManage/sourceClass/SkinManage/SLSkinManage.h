//
//  SLSkinManage.h
//  AFNetworking
//
//  Created by Touker on 2018/1/31.
//

#import <Foundation/Foundation.h>
#import "NSError+SkinManage.h"
#import "HBSKinConst.h"
/**
 * 皮肤更新的回调
 * bundleID:当前的皮肤资源ID
 */
typedef void(^skinUpdateCallback)(NSString *bundleID);
@interface SLSkinManage : NSObject
//获取当前皮肤在本地存储的配置map
@property (nonatomic, strong,getter=getCurrentConfig,readonly) NSDictionary *currentConfigMap;
//获取当前皮肤在本地存储的资源ID
@property (nonatomic, strong,getter=getCurrentSkinBundleID,readonly) NSString *currentBundleID;
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
#pragma mark --register(根据业务场景使用)
/**注册主题更新callback
 * 把控制器的指针地址作为key(请谨慎使用，容易覆盖)
 */
+ (void)registerCallbackWithKey:(NSString *)key skinUpdateCallback:(skinUpdateCallback)skinUpdateCallback;
/**移除观察者*/
+ (void)removeCallbackWithKey:(NSString *)key;
@end


@interface SLSkinManage (SLSkinSourceManage)
/**
 * 根据bundleName获取bundle(工程路径下)
 */
+ (NSBundle *)getBundleWithBundleName:(NSString *)bundleName;
/**
 * 获取bundle(沙盒路径下)
 * bundleName: 资源包名
 * directoryType:NSSearchPathDirectory
 * subPath:据沙盒的相对路径
 */
+ (NSBundle *)getBundleInSandboxWithBundleName:(NSString *)bundleName directoryType:(NSSearchPathDirectory)directoryType inDirectory:(NSString *)subPath;
/**
 * 获取文件的路径
 * bundle:图片所属的bundle(可以根据:bundleForClass获取)
 * imageName:图片的名称
 * imageType:文件的类型
 * inDirectory:文件在bundle的子路径
 */
+ (NSString *)getImagePathWithBundle:(NSBundle *)bundle imageName:(NSString *)imageName imageType:(NSString *)fileType inDirectory:(NSString *)subPath;
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
