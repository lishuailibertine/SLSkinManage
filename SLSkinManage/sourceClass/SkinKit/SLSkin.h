//
//  SLSkin.h
//  Pods
//
//  Created by Touker on 2018/1/31.
//

#ifndef SLSkin_h
#define SLSkin_h

#import "SLSkinManage.h"
#import "HBSkinDownloadManage.h"
#import "SLSkinStyleParse.h"
#import "NSError+SkinManage.h"
#import "NSObject+HBSkinKit.h"

/** 三种安装方式根据具体的业务场景使用
 * 1,SLInstallSkinByName:安装工程路径下的皮肤资源包
 * 2,SLInstallSkinInSandboxByName:安装沙盒路径下的皮肤资源包
 * 3,SLInstallSkinByBundlePath:通过bundle资源路径安装皮肤资源包（工程或者沙盒）
 */
#define SLInstallSkinByName(bundleName,result) \
SLInstallSkinByBundlePath(SLGetBundlePath(bundleName),result);\

#define SLInstallSkinInSandboxByName(bundleName,result) \
SLInstallSkinByBundlePath(SLGetBundlePathInSandbox(bundleName),result);\

#define SLInstallSkinByBundlePath(bundlePath,result) \
[[SLSkinManage sharedSkinManage] installSkinByBundlePath:bundlePath installResult:result];\

/** 根据资源包bundle名切换皮肤*/
#define SLSwitchSkinByBundleID(bundleName) \
[[SLSkinManage sharedSkinManage] notifyUpdateByBundleID:bundleName];

/** 获取资源包路径接口
 * 1,SLGetBundlePath:获取工程路径下的皮肤资源包路径
 * 2,SLGetBundlePathInSandbox:获取工程路径下的皮肤资源包路径
 */
#define SLGetBundlePath(bundleName) \
([SLSkinManage getBundleWithBundleName:bundleName]).bundlePath\

#define SLGetBundlePathInSandbox(bundleName) \
([SLSkinManage getBundleInSandboxWithBundleName:bundleName directoryType:HBSkinDownloadDirectory inDirectory:HBSkinDownloadSubDirectory]).bundlePath\

#endif /* SLSkin_h */
