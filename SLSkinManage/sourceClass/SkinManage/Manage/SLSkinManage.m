//
//  SLSkinManage.m
//  AFNetworking
//
//  Created by Touker on 2018/1/31.
//

#import "SLSkinManage.h"
#import "NSObject+HBSkinNotify.h"
//皮肤配置文件中颜色map对应的key值(colors:默认)
NSString * const kSkinConfigColorForKey =@"colors";
//皮肤配置文件中字体map对应的key值(fonts:默认)
NSString * const kSkinConfigFontForKey =@"fonts";
//皮肤配置文件中其他样式map对应的key值(others:默认)
NSString * const kSkinConfigOtherForKey =@"others";
//*************************private************************************
//默认的资源包ID
NSString *const HBDefaultSourcesID =@"SkinStyle_Light";
//默认的样式配置文件名称
NSString *const HBDefaultConfigName =@"skin";
//默认的样式配置文件类型
NSString *const HBDefaultConfigType =@"json";

//********NSUserDefaults************
//存储样式配置对应的key
NSString *const HBSkinConfigMapKey = @"HBSkinConfigMapKey";
//存储样式配置ID对应的key
NSString *const HBSkinBundleIDKey = @"HBSkinBundleIDKey";
@interface SLSkinManage()
@property (nonatomic, strong) NSMutableDictionary *sourcesMap;
@end

@implementation SLSkinManage
+ (instancetype)sharedSkinManage{
    static id _skinManage;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^(void) {
        _skinManage = [[self alloc] init];
        [_skinManage installSkinByBundlePath:([SLSkinManage getBundleWithBundleName:HBDefaultSourcesID]).bundlePath installResult:^(NSError *error) {
            NSAssert(error==nil, @"install default fail:%@",error.userInfo);
            [_skinManage saveCurrentSkinBundleID:HBDefaultSourcesID];
        }];
    });
    return _skinManage;
}
#pragma mark --setter getter
- (NSMutableDictionary *)sourcesMap{
    if (!_sourcesMap) {
        _sourcesMap =[NSMutableDictionary dictionary];
    }
    return _sourcesMap;
}
- (NSDictionary *)getCurrentConfig{
    return [[SLSkinManage getSourcesConfigForKey:HBSkinConfigMapKey] objectForKey:[self getCurrentSkinBundleID]];
}
#pragma mark --public
- (void)installSkinByBundlePath:(NSString *)bundlePath installResult:(void(^)(NSError *error))installResult{
    [self installSkinByBundlePath:bundlePath configName:nil configType:nil installResult:installResult];
}
- (void)installSkinByBundlePath:(NSString *)bundlePath
                     configName:(NSString *)configName
                     configType:(NSString *)configType
                  installResult:(void(^)(NSError *error))installResult{
    if (bundlePath==nil||bundlePath.length==0) {
        if (installResult) {
            installResult([NSError SkinErrorWithDomain:HBSKINMANAGEERRORDOMAIN code:HBSkinManageError_BundlePathNotFound userInfo:nil]);
        }
        return;
    }
    if (configName==nil||configName.length==0) {
        configName=HBDefaultConfigName;
    }
    if (configType==nil||configType.length==0) {
        configType =HBDefaultConfigType;
    }
    @try{
        __weak typeof(self) this =self;
        NSString * configPath =[NSString stringWithFormat:@"%@/%@.%@",bundlePath,configName,configType];
        [SLSkinManage filePathToDic:configPath result:^(NSError *error, NSDictionary *dataDic) {
            if (error) {
                if (installResult) {
                    installResult([NSError SkinErrorWithDomain:HBSKINMANAGEERRORDOMAIN code:HBSkinManageError_JsonParse userInfo:nil]);
                }else{
                    NSAssert(error==nil, @"%@",error.userInfo);
                }
                return;
            }else{
                [this saveConfigWithBundleID:[bundlePath.lastPathComponent stringByDeletingPathExtension] skinConfig:dataDic];
                if (installResult) {
                    installResult(nil);
                }
            }
        }];
    }
    @catch(NSException *exception){
        NSAssert(exception==nil, @"%@",exception.reason);
    }
}
//安装完，需手动根据bundleID进行皮肤更新
- (void)notifyUpdateByBundleID:(NSString *)bundleID{
    if (bundleID==nil||bundleID.length==0) {
        NSAssert((bundleID||bundleID.length>=0), @"bundleID is error");
        return;
    }
    [self saveCurrentSkinBundleID:bundleID];
    [[NSNotificationCenter defaultCenter] postNotificationName:HBNotificationSkinUpdate object:nil];
}
#pragma mark --private
#pragma mark --ConfigDic
- (void)saveConfigWithBundleID:(NSString *)bundleID skinConfig:(NSDictionary *)skinConfig{
    NSDictionary *configMap =[SLSkinManage getSourcesConfigForKey:HBSkinConfigMapKey];
    [self.sourcesMap addEntriesFromDictionary:configMap];
    [self.sourcesMap setValue:skinConfig forKey:bundleID];
    [SLSkinManage saveSourcesConfig:self.sourcesMap forKey:HBSkinConfigMapKey];
}
#pragma mark --SkinBundleID
- (void)saveCurrentSkinBundleID:(NSString *)bundleID{
    [SLSkinManage saveSourcesConfig:bundleID forKey:HBSkinBundleIDKey];
}
- (NSString *)getCurrentSkinBundleID{
    return [SLSkinManage getSourcesConfigForKey:HBSkinBundleIDKey];
}
@end

@implementation SLSkinManage (SLSkinSourceManage)
+ (NSBundle *)getBundleWithBundleName:(NSString *)bundleName {
    NSBundle *bundle = [NSBundle mainBundle];
    if (bundleName.length) {
        bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:bundleName withExtension:@"bundle"]];
    }
    return bundle;
}
+ (void)saveSourcesConfig:(id)object forKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:object=object?object:[NSNull null] forKey:key];
    [defaults synchronize];
}
+ (id)getSourcesConfigForKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return  [defaults objectForKey:key];
}
+ (void)filePathToDic:(NSString *)filePath result:(void(^)(NSError *error,NSDictionary *dataDic))result{
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    NSError *error = nil;
    NSDictionary *jsonDic;
    if (fileData) {
        jsonDic = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingAllowFragments error:&error];
    }
    if (error) {
        result(error,nil);
    }else{
        result(nil,jsonDic);
    }
}
@end
