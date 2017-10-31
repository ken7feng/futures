//
//  CrashLoginMemory.h
//  WEXFutures
//
//  Created by K on 2017/10/30.
//  Copyright © 2017年 K. All rights reserved.
//

#import <Foundation/Foundation.h>

//设置线上crashLog
void _setOnlieCrashLog(const char* fun, int line, NSString *format);
//获取线上crashlog
NSString* _getOnlineCrashJsonLog(void);
//分析log
NSString* _analysisCrashLog(NSString* log);

@interface CrashLoginMemory : NSObject

@end


@interface Crash_Log_Function : NSObject

@property(nonatomic, strong) NSString* key;
@property(nonatomic, assign) int order;

@end
