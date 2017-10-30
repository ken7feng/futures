//
//  Debug.m
//  WEXFutures
//
//  Created by K on 2017/10/30.
//  Copyright © 2017年 K. All rights reserved.
//

#import "DebugModule.h"

void _writeFile(NSString* content, NSString* filePath)
{
    if (SAFE_STRING(content).length <= 0) {
        return;
    }
    
    if (SAFE_STRING(filePath).length <= 0) {
        return;
    }
    
    NSString* url = [FileUtil dataFilePath:filePath];
    if(![FileUtil isExistsFilePath:url])
    {
        [FileUtil createFileWithFilePath:url];
    }
    
    unsigned long long size = [FileUtil getFileSizeWithFilePath:filePath];
    if (size > 1000*(1000)) { //超过1000K，重写文件。
        [FileUtil writeContent:@"" filePath:url];
    }
    [FileUtil writeAppendContent:content filePath:url];
}

@implementation DebugModule

void _debugLog(const char* fun, int line, NSString *format)
{
#ifdef DEBUG
#ifndef INHOUSETEST
    //    [[NVGAWindow instance] showGAEvent:format action:nil label:nil value:0 extras:nil];
#endif
#endif
    NSLog(@"%s, %d, %@", fun, line, format);
}

void _debugCrashLog(const char* fun, int line, NSString *format)
{
    
    NSString* content = [NSString stringWithFormat:@"%s, line:%d, %@\r\n", fun, line, format];
    _writeFile(content, WEX_LOG_CRASH_FILE_PATH);
    NSLog(@"%s, %d, %@", fun, line, format);
    _setOnlieCrashLog(fun, line, format);
}


void _debugLogWithWriteSpecialLog(NSString* filePath, const char* fun, int line, NSString *format)
{
    _writeFile([NSString stringWithFormat:@"%s, %d, %@", fun, line, format], filePath);
    
    NSLog(@"%s, %d, %@", fun, line, format);
}

@end
