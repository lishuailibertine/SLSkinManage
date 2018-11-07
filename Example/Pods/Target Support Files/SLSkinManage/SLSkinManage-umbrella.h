#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "HBSKinConst.h"
#import "HBSkinDownloadManage.h"
#import "NSError+SkinManage.h"
#import "NSObject+HBSkinKit.h"
#import "NSObject+HBSkinNotify.h"
#import "SLSkin.h"
#import "SLSkinManage.h"
#import "SLSkinStyleParse.h"

FOUNDATION_EXPORT double SLSkinManageVersionNumber;
FOUNDATION_EXPORT const unsigned char SLSkinManageVersionString[];

