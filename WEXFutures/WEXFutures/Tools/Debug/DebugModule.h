//
//  Debug.h
//  WEXFutures
//
//  Created by K on 2017/10/30.
//  Copyright © 2017年 K. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WEX_LOG_FILE_PATH @"wexLogFilePath"
#define WEX_LOG_CRASH_FILE_PATH  @"wexCrashLogFilePath"


#define DebugLog(...) _debugLog(__PRETTY_FUNCTION__, __LINE__,[NSString stringWithFormat:__VA_ARGS__])

//#ifdef DEBUG
//#define CrashDebugLog(...) _debugCrashLog(__PRETTY_FUNCTION__, __LINE__,[NSString stringWithFormat:__VA_ARGS__])
//#else
//#define CrashDebugLog(...) _setOnlieCrashLog(__PRETTY_FUNCTION__, __LINE__,[NSString stringWithFormat:__VA_ARGS__])
//#endif
#define CrashDebugLog(...) _debugCrashLog(__PRETTY_FUNCTION__, __LINE__,[NSString stringWithFormat:__VA_ARGS__])

#define DebugLogFile(F,...) _debugLogWithWriteSpecialLog(F,__PRETTY_FUNCTION__, __LINE__,[NSString stringWithFormat:__VA_ARGS__])


@interface DebugModule : NSObject

void _debugLog(const char* fun, int line, NSString *format);

void _debugCrashLog(const char* fun, int line, NSString *format);

void _debugLogWithWriteSpecialLog(NSString* filePath, const char* fun, int line, NSString *format);

@end
