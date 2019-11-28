//
//  HTConst.h
//  AspectsDemo
//
//  Created by 张乐工作 on 2019/11/21.
//  Copyright © 2019 张乐. All rights reserved.
//

#ifndef HTConst_h
#define HTConst_h

//高度相关
#define kNavigationH 64
#define kChatCellHeight 70
#define kCategoryViewHeight 44
#define INPUTVIEW_TOOL_HEIGHT 95
#define kBoomTarHeight 45
#define INPUTVIEW_PUBLIC_HEIGHT 50

#define kTableBarH 49
#define kHeaderSectionH 7
#define kFooterSectionH 0.01
#define kZero 0

//iPhoneX 相关
#define IPHONEX_STATUSBAR_HEIGHT 44
#define IPHONEX_TABBAR_HEIGHT 83
#define IPHONEX_NAVIGATIONBAR_HEIGHT 88
#define IPHONEX_INDICATOR_HEIGHT 34
#define isIPhoneXAll ([[UIApplication sharedApplication] statusBarFrame].size.height == 44)
//iphone真实导航栏
#define IPHONE_NAVIGATION_HEIGHT (isIPhoneXAll ? IPHONEX_NAVIGATIONBAR_HEIGHT : kNavigationH)
//iphone真实底部安全距离
#define IPHONE_BOTTOMSAFEAREA    (isIPhoneXAll ? IPHONEX_INDICATOR_HEIGHT : kZero)
//iphone真实状态栏高度
#define IPHONE_STATUSBARHEIHGT (isIPhoneXAll ? IPHONEX_STATUSBAR_HEIGHT : 20)

/**
 *  物理屏幕Size
 */
#define ScreenSize       ([[UIScreen mainScreen] bounds].size)
#define ScreenHeight     ([UIScreen mainScreen].bounds.size.height)
#define ScreenWidth      ([UIScreen mainScreen].bounds.size.width)

#define BaseUrl       @"http://test-hantalk.hanmaker.com/"

#endif /* HTConst_h */
