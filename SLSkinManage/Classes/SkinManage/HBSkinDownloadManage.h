//
//  HBSkinDownManage.h
//  SLTestViewAnimation
//
//  Created by Touker on 2017/12/8.
//  Copyright © 2017年 Touker. All rights reserved.
//

#import <Foundation/Foundation.h>
//皮肤的默认地址
extern NSString * const kSkinDownloadDefaultUrl;
//下载的皮肤默认保存的地址(沙盒相对路径)
extern NSString * const kSkinDownloadDefaultDestinationPath;

typedef NS_ENUM(NSInteger, HBSkinDownloadErrorType) {
    HBSkinDownloadError_TargetPathNotFound =11,//客户端错误，下载路径不存在
    HBSkinDownloadError_UrlNotFound =12,//客户端错误,下载的url不存在
    HBSkinDownloadError_TargetPathCreateFail =13,//客户端错误,目标路径创建失败,这样默认会下载在沙盒根路径下
    HBSkinDownloadError_UnZipFail =14,//客户端错误，zip解压缩失败
    HBSkinDownloadError_UnZipOpenFail =15,//客户端错误，zip文件打开失败
    HBSkinDownloadError_AppOther =19,//客户端其他类型错误
    HBSkinDownloadError_ServerError =21,//服务端错误
};
typedef NS_ENUM(NSInteger, HBSkinDirectoryType) {
    HBSkinDirectoryType_Document,//
    HBSkinDirectoryType_Library
};
@interface HBSkinDownloadParams : NSObject
//下载的服务地址
@property (nonatomic, copy) NSString *url;
//下载到的目标路径(沙盒相对路径)
@property (nonatomic, copy) NSString *destinationPath;
//下载完毕是否移除(压缩文件)
@property (nonatomic, assign) BOOL isRemove;
//如果不设置默认为Document
@property (nonatomic, assign) HBSkinDirectoryType directoryType;
- (instancetype)createDownloadParamWithUrl:(NSString *)url destinationPath:(NSString *)destinationPath;
@end

@interface HBSkinDownloadResponse : NSObject
//皮肤所在的路径
@property (nonatomic ,copy) NSString *skinPath;

@end

@interface HBSkinDownloadManage : NSObject
+ (void)downloadSkinSourceByParams:(HBSkinDownloadParams *)params resultBlock:(void(^)(NSError *error))resultBlock;
@end

