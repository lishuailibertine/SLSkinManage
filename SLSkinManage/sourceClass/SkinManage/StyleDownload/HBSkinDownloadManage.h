//
//  HBSkinDownManage.h
//  SLTestViewAnimation
//
//  Created by Touker on 2017/12/8.
//  Copyright © 2017年 Touker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSError+SkinManage.h"

//皮肤的默认地址
extern NSString * const kSkinDownloadDefaultUrl;
//下载的皮肤默认保存的地址(沙盒相对路径)
extern NSString * const kSkinDownloadDefaultDestinationPath;
typedef NS_ENUM(NSInteger, HBSkinDirectoryType) {
    HBSkinDirectoryType_Document,//
    HBSkinDirectoryType_Library
};
@interface HBSkinDownloadParams : NSObject
//下载的服务地址
@property (nonatomic, copy) NSString *url;
//下载到的目标路径(沙盒相对路径)
@property (nonatomic, copy) NSString *destinationPath;
//如果不设置默认为Document
@property (nonatomic, assign) HBSkinDirectoryType directoryType;
//下载完毕是否移除(压缩文件)
@property (nonatomic, assign) BOOL isRemove;

- (instancetype)createDownloadParamWithUrl:(NSString *)url destinationPath:(NSString *)destinationPath;
@end

@interface HBSkinDownloadResponse : NSObject
//皮肤所在的路径
@property (nonatomic ,copy) NSString *skinPath;

@end

@interface HBSkinDownloadManage : NSObject
+ (void)downloadSkinSourceByParams:(HBSkinDownloadParams *)params resultBlock:(void(^)(NSError *error))resultBlock;
@end

