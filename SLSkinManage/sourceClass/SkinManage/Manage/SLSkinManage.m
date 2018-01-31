//
//  SLSkinManage.m
//  AFNetworking
//
//  Created by Touker on 2018/1/31.
//

#import "SLSkinManage.h"
NSString *const HBDefaultConfigName =@"skin";
NSString *const HBDefaultConfigType =@"json";
NSString *const HBSkinType = @"HBSkinType";
@interface SLSkinManage()
@property (nonatomic, copy,readwrite) NSString * currentBundleID;
@property (nonatomic, strong) NSMutableDictionary *sourcesMap;
@end

@implementation SLSkinManage
+ (instancetype)sharedSkinManage{
    static id _skinManage;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^(void) {
        _skinManage = [[self alloc] init];
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
#pragma mark --public
- (void)installSkinByBundlePath:(NSString *)bundlePath{
    [self installSkinByBundlePath:bundlePath configName:nil configType:nil installResult:nil];
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
                [this saveConfigWithBundleID:bundlePath.lastPathComponent skinConfig:dataDic];
            }
        }];
    }
    @catch(NSException *exception){
        NSAssert(exception==nil, @"%@",exception.reason);
    }
}
//安装完，需手动根据bundleID进行皮肤更新
- (void)notifyUpdateByBundleID:(NSString *)bundleID{
    
}
#pragma mark --private
- (void)saveConfigWithBundleID:(NSString *)bundleID skinConfig:(NSDictionary *)skinConfig{
    NSDictionary *configMap =[self getConfig];
    [self.sourcesMap addEntriesFromDictionary:configMap];
    [self.sourcesMap setValue:skinConfig forKey:bundleID];
    [SLSkinManage saveSourcesConfig:self.sourcesMap forKey:HBSkinType];
}
- (id)getConfig{
    return [SLSkinManage getSourcesConfigForKey:HBSkinType];
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
