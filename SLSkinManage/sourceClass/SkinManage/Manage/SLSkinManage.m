//
//  SLSkinManage.m
//  AFNetworking
//
//  Created by Touker on 2018/1/31.
//

#import "SLSkinManage.h"
NSString *const HBDefaultConfigName =@"skin";
NSString *const HBDefaultConfigType =@"json";
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
        NSAssert(!bundlePath,@"bundlePath is nil");
        return;
    }
    if (configName==nil||configName.length==0) {
        configName=HBDefaultConfigName;
    }
    if (configType==nil||configType.length==0) {
        configType =HBDefaultConfigType;
    }
    @try{
        NSString * configPath =[NSString stringWithFormat:@"%@/%@.%@",bundlePath,configName,configType];
        NSData *fileData = [NSData dataWithContentsOfFile:configPath];
        NSError *error = nil;
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"%@",jsonDic);
    }
    @catch(NSException *exception){
        NSAssert(exception==nil, @"%@",exception.reason);
    }
}
//安装完，需手动根据bundleID进行皮肤更新
- (void)notifyUpdateByBundleID:(NSString *)bundleID{
    
}
#pragma mark --private

@end


@implementation SLSkinManage (SLSkinSourceManage)
+ (NSBundle *)getBundleWithBundleName:(NSString *)bundleName {
    NSBundle *bundle = [NSBundle mainBundle];
    if (bundleName.length) {
        bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:bundleName withExtension:@"bundle"]];
    }
    return bundle;
}
@end
