//
//  CrashLoginMemory.m
//  WEXFutures
//
//  Created by K on 2017/10/30.
//  Copyright © 2017年 K. All rights reserved.
//

#import "CrashLoginMemory.h"

typedef struct _wex_crash_single_log{
    short key; //function
    short value; //value
}_CRASH_SINGLE_LOG;

static int _wex_crash_log_memory_start = 0;

static BOOL _wex_crash_log_memory_is_full = NO;

#define _WEX_CRASH_LOG_MAXNUM 200
#define _WEX_CRASH_NULL_VALUE 0

static _CRASH_SINGLE_LOG _crash_log_memory[_WEX_CRASH_LOG_MAXNUM] = {0};//no more than 500 logs;

static NSMutableDictionary* _function_dictionary = nil;
static NSMutableDictionary* _value_dictionary = nil;

void _setOnlieCrashLog(const char * fun, int line, NSString * format)
{
    static int i = 0;
    static int v = _WEX_CRASH_NULL_VALUE + 1;
    static NSObject * staticObj = nil;
    if (staticObj == nil)
    {
        staticObj = [[NSObject alloc]init];
    }
    @synchronized (staticObj)
    {
        @try {
            if (_function_dictionary == nil)
            {
                _function_dictionary = [[NSMutableDictionary alloc]initWithCapacity:0];
            }
            if (_value_dictionary == nil)
            {
                _value_dictionary = [[NSMutableDictionary alloc]initWithCapacity:0];
                NSInteger funHash = [@"  " hash];
                NSNumber * funNumber = [[NSNumber alloc]initWithLong:funHash];
                Crash_Log_Function * obj = [[Crash_Log_Function alloc]init];
                obj.key = @"  ";
                obj.order = 0;
                [_value_dictionary setObject:obj forKey:funNumber];
            }
            if (_wex_crash_log_memory_start >= _WEX_CRASH_LOG_MAXNUM)
            {
                _wex_crash_log_memory_start = 0;
                return;
            }
            NSString * funString = [NSString stringWithFormat:@"%s",fun];
            NSInteger funHash = [funString hash];
            NSNumber * funNumber = [[NSNumber alloc]initWithLong:funHash];
            if ([_function_dictionary objectForKey:funNumber] == nil)
            {
                Crash_Log_Function * obj = [[Crash_Log_Function alloc]init];
                obj.key = funString;
                obj.order = i;
                i++;
                [_function_dictionary setObject:obj forKey:funNumber];
            }
            
            _CRASH_SINGLE_LOG * currentLog = &(_crash_log_memory[_wex_crash_log_memory_start]);
            Crash_Log_Function * funObj = [_function_dictionary objectForKey:funNumber];
            currentLog->key = funObj.order;
            currentLog->value = _WEX_CRASH_NULL_VALUE;
            if (format != nil)
            {
                NSString * valueString = format;
                NSInteger valueHash = [valueString hash];
                NSNumber * valueNumber = [[NSNumber alloc]initWithLong:valueHash];
                if ([_value_dictionary objectForKey:valueNumber] == nil)
                {
                    Crash_Log_Function * obj = [[Crash_Log_Function alloc]init];
                    obj.key = valueString;
                    obj.order = v;
                    v++;
                    [_value_dictionary setObject:obj forKey:valueNumber];
                }
                Crash_Log_Function * valueObj = [_value_dictionary objectForKey:valueNumber];
                currentLog->value = valueObj.order;
            }
            _wex_crash_log_memory_start ++;
            if (_wex_crash_log_memory_start >= _WEX_CRASH_LOG_MAXNUM)
            {
                _wex_crash_log_memory_start = 0;
                _wex_crash_log_memory_is_full = YES;
            }
        }
        @catch (NSException *exception)
        {
            _function_dictionary = [[NSMutableDictionary alloc]initWithCapacity:0];
            _value_dictionary = [[NSMutableDictionary alloc]initWithCapacity:0];
            _wex_crash_log_memory_start = 0;
            _wex_crash_log_memory_is_full = NO;
        } @finally {
            
        }
    }
}

NSString * _onlineCrashNumberLog()
{
    NSMutableString * string = [[NSMutableString alloc]initWithCapacity:0];
    if (_wex_crash_log_memory_is_full == NO)
    {
        for (int i = 0; i < _wex_crash_log_memory_start; i++)
        {
            _CRASH_SINGLE_LOG currentLog = _crash_log_memory[i];
            [string appendFormat:@"%04d%04d",currentLog.key,currentLog.value];
        }
    }
    else
    {
        for (int i = _wex_crash_log_memory_start; i < _WEX_CRASH_LOG_MAXNUM; i++)
        {
            _CRASH_SINGLE_LOG currentLog = _crash_log_memory[i];
            [string appendFormat:@"%04d%04d",currentLog.key,currentLog.value];
        }
        for (int i = 0; i < _wex_crash_log_memory_start; i++)
        {
            _CRASH_SINGLE_LOG currentLog = _crash_log_memory[i];
            [string appendFormat:@"%04d%04d",currentLog.key,currentLog.value];
        }
    }
    return string;
}

NSString* _getOnlineCrashJsonLog()
{
    NSString* crashLog = _onlineCrashNumberLog();
    NSMutableDictionary* funDit = [[NSMutableDictionary alloc]init];
    for (NSNumber* key in _function_dictionary)
    {
        Crash_Log_Function* obj = [_function_dictionary objectForKey:key];
        [funDit setObject:obj.key forKey:[NSString stringWithFormat:@"%04d", obj.order]];
    }
    
    NSMutableDictionary* valueDit = [[NSMutableDictionary alloc]init];
    for (NSNumber* key in _value_dictionary) {
        Crash_Log_Function* obj = [_value_dictionary objectForKey:key];
        [valueDit setObject:obj.key forKey:[NSString stringWithFormat:@"%04d", obj.order]];
    }
    
    
    NSDictionary* crashLogDit = @{@"funMap":funDit,
                                  @"valueMap":valueDit,
                                  @"crashLog":crashLog
                                  };
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:crashLogDit options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    return jsonString;
}

NSString* _analysisCrashLog(NSString* log)
{
    NSData* data = [log dataUsingEncoding:NSASCIIStringEncoding];
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    
    if (jsonObject != nil && error == nil){
        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary* funMap = [jsonObject objectForKey:@"funMap"];
            NSDictionary* valueMap = [jsonObject objectForKey:@"valueMap"];
            NSString* crashLog = [jsonObject objectForKey:@"crashLog"];
            //判断
            
            NSMutableString* retString = [[NSMutableString alloc]init];
            int index = 0;
            while ((index+8) <= crashLog.length) {
                NSString* funKey = [crashLog substringWithRange:NSMakeRange(index, 4)];
                NSString* valueKey = [crashLog substringWithRange:NSMakeRange(index+4, 4)];
                
                NSString* fun = [funMap objectForKey:funKey];
                NSString* value = [valueMap objectForKey:valueKey];
                [retString appendFormat:@"\n%@:%@\n",fun,value];
                index = index + 8;
            }
            return retString;
        }
        else
        {
            return @"analysis error!!!!! return error";
        }
    }else{
        // 解析错误
        return @"analysis error!!!!!";
    }
    
}

@implementation CrashLoginMemory

@end

@implementation Crash_Log_Function


@end

