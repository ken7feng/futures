//
//  NSDate+Ext.m
//  SH-WEX-BASE
//
//  Created by Last Order on 2016/12/13.
//  Copyright © 2016年 Last Order. All rights reserved.
//

#import "NSDate+Ext.h"

@implementation NSDate (Ext)

+ (NSString *)storageTimeZone
{
    return kCtripCalendarTimeZone_GMT;
}

+ (NSString *)displayTimeZone
{
    return kCtripCalendarTimeZone_CN;
}

+ (NSString *)SIMPLEFORMATTYPESTRING1;
{
    return SIMPLEFORMATTYPESTRING1;
}

+ (NSString *)SIMPLEFORMATTYPESTRING2;
{
    return SIMPLEFORMATTYPESTRING2;
}

+ (NSString *)SIMPLEFORMATTYPESTRING3;
{
    return SIMPLEFORMATTYPESTRING2;
}

+ (NSString *)SIMPLEFORMATTYPESTRING4;
{
    return SIMPLEFORMATTYPESTRING4;
}

+ (NSString *)SIMPLEFORMATTYPESTRING5;
{
    return SIMPLEFORMATTYPESTRING5;
}

+ (NSString *)SIMPLEFORMATTYPESTRING6;
{
    return SIMPLEFORMATTYPESTRING6;
}

+ (NSString *)SIMPLEFORMATTYPESTRING7;
{
    return SIMPLEFORMATTYPESTRING7;
}

+ (NSString *)SIMPLEFORMATTYPESTRING8;
{
    return SIMPLEFORMATTYPESTRING8;
}

+ (NSString *)SIMPLEFORMATTYPESTRING9;
{
    return SIMPLEFORMATTYPESTRING9;
}
+ (NSString *)SIMPLEFORMATTYPESTRING10;
{
    return SIMPLEFORMATTYPESTRING10;
}
+ (NSString *)SIMPLEFORMATTYPESTRING11;
{
    return SIMPLEFORMATTYPESTRING11;
}
+ (NSString *)SIMPLEFORMATTYPESTRING12;
{
    return SIMPLEFORMATTYPESTRING12;
}

+ (NSString *)SIMPLEFORMATTYPESTRING13;
{
    return SIMPLEFORMATTYPESTRING13;
}

+ (NSString *)SIMPLEFORMATTYPESTRING14
{
    return SIMPLEFORMATTYPESTRING14;
}

+ (NSDateFormatter *)getCurrentDateFormatter
{
    NSDateFormatter * dataFormatter = [[NSDateFormatter alloc]init];
    [dataFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CH"] ];
    [dataFormatter setTimeZone:[NSTimeZone timeZoneWithName:[self displayTimeZone]]];
    return dataFormatter;
}


#pragma mark - ----------获取当前日期信息----------
#pragma mark 获取当前日期 yyyyMMddHHmmss 14位
+ (NSString *)getCurrentTime
{
    NSDate *date = [self getCurrentDate];
    return [self getCalendarStrBySimpleDateFormat:date simpleDateFormatType:SIMPLEFORMATTYPE1];
}

#pragma mark 获取当前日期 yyyyMMddHHmmssSSS 17位
+ (NSString *)getCurrentTimeMillisecond
{
    NSDate *date = [self getCurrentDate];
    return [self getCalendarStrBySimpleDateFormat:date simpleDateFormatType:SIMPLEFORMATTYPE16];
}

#pragma mark 根据 SimpleDateFormatType类型将calendar转成对应的格式 如果date为null则返回空字符串
+ (NSString *)getCalendarStrBySimpleDateFormat:(NSDate *)date simpleDateFormatType:(int)SimpleDateFormatType
{
    NSString *str = @"";
    NSString *type = @"";
    switch (SimpleDateFormatType)
    {
        case SIMPLEFORMATTYPE1:
            type = SIMPLEFORMATTYPESTRING1;
            break;
        case SIMPLEFORMATTYPE2:
            type = SIMPLEFORMATTYPESTRING2;
            break;
        case SIMPLEFORMATTYPE3:
            type = SIMPLEFORMATTYPESTRING3;
            break;
        case SIMPLEFORMATTYPE4:
            type = SIMPLEFORMATTYPESTRING4;
            break;
        case SIMPLEFORMATTYPE5:
            type = SIMPLEFORMATTYPESTRING5;
            break;
        case SIMPLEFORMATTYPE6:
            type = SIMPLEFORMATTYPESTRING6;
            break;
        case SIMPLEFORMATTYPE7:
            type = SIMPLEFORMATTYPESTRING7;
            break;
        case SIMPLEFORMATTYPE8:
            type = SIMPLEFORMATTYPESTRING8;
            break;
        case SIMPLEFORMATTYPE9:
            type = SIMPLEFORMATTYPESTRING9;
            break;
        case SIMPLEFORMATTYPE10:
            type = SIMPLEFORMATTYPESTRING10;
            break;
        case SIMPLEFORMATTYPE11:
            type = SIMPLEFORMATTYPESTRING11;
            break;
        case SIMPLEFORMATTYPE12:
            type = SIMPLEFORMATTYPESTRING12;
            break;
        case SIMPLEFORMATTYPE13:
            type = SIMPLEFORMATTYPESTRING13;
            break;
        case SIMPLEFORMATTYPE14:
            type = SIMPLEFORMATTYPESTRING14;
            break;
        case SIMPLEFORMATTYPE15:
            type = SIMPLEFORMATTYPESTRING15;
            break;
        case SIMPLEFORMATTYPE16:
            type = SIMPLEFORMATTYPESTRING16;
            break;
        case SIMPLEFORMATTYPE17:
            type = SIMPLEFORMATTYPESTRING17;
            break;
        case SIMPLEFORMATTYPE18:
            type = SIMPLEFORMATTYPESTRING18;
            break;
        default:
            type = SIMPLEFORMATTYPESTRING1;
            break;
    }
    
    
    if (type != nil && type.length != 0 && date != nil) 
    {
        //        if(dateFormater == nil)
        //        {
        NSDateFormatter *dateFormater = [self getCurrentDateFormatter];
        //        }
        
        [dateFormater setDateFormat:type];
        str = [dateFormater stringFromDate:date];
        
        //        [dateFormaterLock unlock];
    }
    
    return str;
}

+ (NSDate *)getCurrentDate
{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    return localeDate;
}

+ (NSString*)getCurrentTimestamp
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;
}


@end
