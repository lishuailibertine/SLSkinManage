//
//  HBSKinConst.h
//  AFNetworking
//
//  Created by Touker on 2018/2/1.
//

//皮肤配置文件中颜色map对应的key值(colors:默认)
extern NSString * const kSkinConfigColorForKey;
//皮肤配置文件中字体map对应的key值(fonts:默认)
extern NSString * const kSkinConfigFontForKey;
//皮肤配置文件中字体map对应的key值(images:默认)
extern NSString * const kSkinConfigImageForKey;
//皮肤配置文件中其他样式map对应的key值(others:默认)
extern NSString * const kSkinConfigOtherForKey;
//***********************************************
//图片的子路径
extern NSString * const HBImageSubpathKey;
//图片的类型
extern NSString * const HBImageTypeKey;
//*************************private:其实这一部分是作为SLSkinManage中私有的变量，但是为统一管理写到了这个地************************************
//默认的资源包ID
extern NSString *const HBDefaultSourcesID;
//默认的样式配置文件名称
extern NSString *const HBDefaultConfigName;
//默认的样式配置文件类型
extern NSString *const HBDefaultConfigType;
//********NSUserDefaults:本地存储皮肤配置Json和资源包ID对应的key************
//存储样式配置对应的key
extern NSString *const HBSkinConfigMapKey;
//存储样式配置ID对应的key
extern NSString *const HBSkinBundleIDKey;
