//
//  SystemMacros.h
//  WEXWineMall
//
//  Created by K on 2017/7/20.
//  Copyright © 2017年 K. All rights reserved.
//

#ifndef SystemMacros_h
#define SystemMacros_h

//当前系统版本
#define IOS_SYSTEM_VERSION  [[UIDevice currentDevice] systemVersion]

//当前系统名
#define IOS_SYSTEM_NAME     [[UIDevice currentDevice] systemName]

//当前系统类型
#define IOS_SYSTEM_MODEL    [[UIDevice currentDevice] model]

//当前app版本
#define AppVersion          [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//当前appBulndID
#define AppBundleId             [[NSBundle mainBundle] bundleIdentifier]

//当前系统语言
#define CurrentLanguage     ([[NSLocale preferredLanguages] objectAtIndex:0])

//toast时间
#define ToastShortTime      3
#define ToastLongTime       6

//crashLog
#define CrashLog @"crash.log"

//error
#define kError @"kError"

#define LOG_NETWORK @"logNetWork"

#endif /* SystemMacros_h */
