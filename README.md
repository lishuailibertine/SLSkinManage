# SLSkinManage
## 简单介绍

>闲余时间写的一个换肤的小工具。目前的demo还比较简陋,还在持续更新。这个功能的设计仅仅根据自己的想法去实现的，看到的朋友可以借鉴一下，也许就更好的实现方式😊。

## 功能描述

>基本的安装(工程及沙盒路径)、切换皮肤功能，提供独立的下载模块(可替换)。
>可在xib、storyboard、纯代码布局中设置元素皮肤样式。
>UI样式、图片资源通过bundle以及文件来进行结构化的配置。

## 如何集成

>通过源码、pod等方式集成到工程中，添加皮肤资源包(下载等)并通过接口安装，在代码、布局文件中完成样式配置。
### 在storyboard中设置样式
![storyborad](https://github.com/lishuailibertine/SLSkinManage/blob/master/images/stordboard%402x.png)

## 接口使用

```objective-c
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
```
## 样式设置
```objective-c
@interface UIView (HBSkin)
@property (copy,nonatomic) IBInspectable NSString *skin_background_color;
@end
@interface UIButton (HBSkin)
- (void)skin_titleColor:(NSString *)type forState:(UIControlState)state;
- (void)skin_imageNamed:(NSString *)name forState:(UIControlState)state;
- (void)skin_backgroundImageNamed:(NSString *)name forState:(UIControlState)state;
@end

@interface UIImageView (HBSkin)
@property (copy,nonatomic) IBInspectable NSString *skin_image;
@end

@interface UILabel (HBSkin)
@property (copy,nonatomic) IBInspectable NSString *skin_title_color;
@end

@interface UINavigationBar (HBSkin)
@property (copy,nonatomic) IBInspectable NSString *skin_barBackground_image;
@property (copy,nonatomic) IBInspectable NSString *skin_barBackground_color;
@end

@interface UITabBarItem (HBSkin)
@property (copy,nonatomic) IBInspectable NSString *skin_image_name;
@property (copy,nonatomic) IBInspectable NSString *skin_selectedImage_name;
@end

@interface UITextField (HBSkin)
@property (copy,nonatomic) IBInspectable NSString *skin_textFont;
@property (copy,nonatomic) IBInspectable NSString *skin_textColor;
@end

@interface UITextView (HBSkin)
@property (copy,nonatomic) IBInspectable NSString *skin_textFont;
@property (copy,nonatomic) IBInspectable NSString *skin_textColor;
@end

@interface UISlider (HBSkin)
@property (copy,nonatomic) IBInspectable NSString *skin_thumbTintColor;
@property (copy,nonatomic) IBInspectable NSString *skin_minimumTrackTintColor;
@property (copy,nonatomic) IBInspectable NSString *skin_maximumTrackTintColor;
@end

@interface UISwitch (HBSkin)
@property (copy,nonatomic) IBInspectable NSString *skin_onTintColor;
@property (copy,nonatomic) IBInspectable NSString *skin_thumbTintColor;
@end

@interface UIProgressView (HBSkin)
@property (copy,nonatomic) IBInspectable NSString *skin_trackTintColor;
@property (copy,nonatomic) IBInspectable NSString *skin_progressTintColor;
@end

@interface UIPageControl (HBSkin)
@property (copy,nonatomic) IBInspectable NSString *skin_pageIndicatorTintColor;
@property (copy,nonatomic) IBInspectable NSString *skin_currentPageIndicatorTintColor;
@end

@interface UISearchBar (HBSkin)
@property (copy,nonatomic) IBInspectable NSString *skin_barTintColor;
@end

@interface UIBarButtonItem (HBSkin)
@end
```
