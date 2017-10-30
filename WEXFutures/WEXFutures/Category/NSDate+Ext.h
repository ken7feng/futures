//
//  NSDate+Ext.h
//  SH-WEX-BASE
//
//  Created by Last Order on 2016/12/13.
//  Copyright © 2016年 Last Order. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 星期数组
 */
//static NSString[] WEEKNAME_CHINESE = new String[] { "星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六" };
//static NSMutableArray *WEEKNAME_CHINESE = [NSMutableArray arrayWithObjects:@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
/**
 * ********************SIMPLEFORMATTYPE对应的字串*********************
 */
/**
 * SIMPLEFORMATTYPE1 对应类型：yyyyMMddHHmmss
 */
static NSString *SIMPLEFORMATTYPESTRING1 = @"yyyyMMddHHmmss";

/**
 * SIMPLEFORMATTYPE2 对应的类型：yyyy-MM-dd HH:mm:ss
 */
static NSString *SIMPLEFORMATTYPESTRING2 = @"yyyy-MM-dd HH:mm:ss";

/**
 * SIMPLEFORMATTYPE3 对应的类型：yyyy-M-d HH:mm:ss
 */
static NSString *SIMPLEFORMATTYPESTRING3 = @"yyyy-M-d HH:mm:ss";

/**
 * SIMPLEFORMATTYPE4对应的类型：yyyy-MM-dd HH:mm
 */
static NSString *SIMPLEFORMATTYPESTRING4 = @"yyyy-MM-dd HH:mm";

/**
 * SIMPLEFORMATTYPE5 对应的类型：yyyy-M-d HH:mm
 */
static NSString *SIMPLEFORMATTYPESTRING5 = @"yyyy-M-d HH:mm";

/**
 * SIMPLEFORMATTYPE6对应的类型：yyyyMMdd
 */
static NSString *SIMPLEFORMATTYPESTRING6 = @"yyyyMMdd";

/**
 * SIMPLEFORMATTYPE7对应的类型：yyyy-MM-dd
 */
static NSString *SIMPLEFORMATTYPESTRING7 = @"yyyy-MM-dd";

/**
 * SIMPLEFORMATTYPE8对应的类型： yyyy-M-d
 */
static NSString *SIMPLEFORMATTYPESTRING8 = @"yyyy-M-d";

/**
 * SIMPLEFORMATTYPE9对应的类型：yyyy年MM月dd日
 */
static NSString *SIMPLEFORMATTYPESTRING9 = @"yyyy年MM月dd日";

/**
 * SIMPLEFORMATTYPE10对应的类型：yyyy年M月d日
 */
static NSString *SIMPLEFORMATTYPESTRING10 = @"yyyy年M月d日";

/**
 * SIMPLEFORMATTYPE11对应的类型：M月d日
 */
static NSString *SIMPLEFORMATTYPESTRING11 = @"M月d日";

/**
 * SIMPLEFORMATTYPE12对应的类型：HH:mm:ss
 */
static NSString *SIMPLEFORMATTYPESTRING12 = @"HH:mm:ss";

/**
 * SIMPLEFORMATTYPE13对应的类型：HH:mm
 */
static NSString *SIMPLEFORMATTYPESTRING13 = @"HH:mm";
/**
 * SIMPLEFORMATTYPE7对应的类型：yyyy-MM-dd
 */
static NSString *SIMPLEFORMATTYPESTRING14 = @"yyyy/MM/dd";

/***
 * SIMPLEFORMATTYPE15对应的类型：yyyy年MM月
 */

static NSString *SIMPLEFORMATTYPESTRING15 = @"yyyy年MM月";

/***
 * SIMPLEFORMATTYPE16对应的类型：yyyyMMddHHmmssSSS
 */

static NSString *SIMPLEFORMATTYPESTRING16 = @"yyyyMMddHHmmssSSS";

/***
 * SIMPLEFORMATTYPE17对应的类型：yyyy-MM-dd HH:mm:ss.SSS
 */

static NSString *SIMPLEFORMATTYPESTRING17 = @"yyyy-MM-dd HH:mm:ss.SSS";

/**
 * SIMPLEFORMATTYPESTRING18 对应类型：yyyy/MM/dd HH:mm:ss
 */
static NSString *SIMPLEFORMATTYPESTRING18 = @"yyyy/MM/dd HH:mm:ss";

static long lunarInfo[] = { 0x04bd8, 0x04ae0, 0x0a570, 0x054d5, 0x0d260, 0x0d950, 0x16554, 0x056a0, 0x09ad0, 0x055d2, 0x04ae0, 0x0a5b6, 0x0a4d0, 0x0d250, 0x1d255, 0x0b540, 0x0d6a0, 0x0ada2, 0x095b0, 0x14977, 0x04970, 0x0a4b0, 0x0b4b5, 0x06a50, 0x06d40, 0x1ab54, 0x02b60, 0x09570, 0x052f2, 0x04970, 0x06566, 0x0d4a0, 0x0ea50, 0x06e95, 0x05ad0, 0x02b60, 0x186e3, 0x092e0, 0x1c8d7, 0x0c950, 0x0d4a0, 0x1d8a6, 0x0b550, 0x056a0, 0x1a5b4, 0x025d0, 0x092d0, 0x0d2b2, 0x0a950, 0x0b557, 0x06ca0, 0x0b550, 0x15355, 0x04da0, 0x0a5d0, 0x14573, 0x052d0, 0x0a9a8, 0x0e950, 0x06aa0, 0x0aea6, 0x0ab50, 0x04b60, 0x0aae4, 0x0a570, 0x05260, 0x0f263, 0x0d950, 0x05b57, 0x056a0, 0x096d0, 0x04dd5, 0x04ad0, 0x0a4d0, 0x0d4d4, 0x0d250, 0x0d558, 0x0b540, 0x0b5a0, 0x195a6, 0x095b0, 0x049b0, 0x0a974, 0x0a4b0, 0x0b27a, 0x06a50, 0x06d40, 0x0af46, 0x0ab60, 0x09570, 0x04af5, 0x04970, 0x064b0, 0x074a3, 0x0ea50, 0x06b58, 0x055c0, 0x0ab60, 0x096d5, 0x092e0, 0x0c960, 0x0d954, 0x0d4a0, 0x0da50, 0x07552, 0x056a0, 0x0abb7, 0x025d0, 0x092d0, 0x0cab5, 0x0a950, 0x0b4a0, 0x0baa4, 0x0ad50, 0x055d9, 0x04ba0, 0x0a5b0, 0x15176, 0x052b0, 0x0a930, 0x07954, 0x06aa0, 0x0ad50, 0x05b52, 0x04b60, 0x0a6e6, 0x0a4e0, 0x0d260, 0x0ea65, 0x0d530, 0x05aa0, 0x076a3, 0x096d0, 0x04bd7, 0x04ad0, 0x0a4d0, 0x1d0b6, 0x0d250, 0x0d520, 0x0dd45, 0x0b5a0, 0x056d0, 0x055b2, 0x049b0, 0x0a577, 0x0a4b0, 0x0aa50, 0x1b255, 0x06d20, 0x0ada0 };

// 日历使用到的时区信息
#define kCtripCalendarTimeZone_CN   @"Asia/Shanghai"
#define kCtripCalendarTimeZone_GMT  @"GMT"

@interface NSDate (Ext)


typedef enum{
    SIMPLEFORMATTYPE1  = 1,
    SIMPLEFORMATTYPE2  = 2,
    SIMPLEFORMATTYPE3  = 3,
    SIMPLEFORMATTYPE4  = 4,
    SIMPLEFORMATTYPE5  = 5,
    SIMPLEFORMATTYPE6  = 6,
    SIMPLEFORMATTYPE7  = 7,
    SIMPLEFORMATTYPE8  = 8,
    SIMPLEFORMATTYPE9  = 9,
    SIMPLEFORMATTYPE10 = 10,
    SIMPLEFORMATTYPE11 = 11,
    SIMPLEFORMATTYPE12 = 12,
    SIMPLEFORMATTYPE13 = 13,
    SIMPLEFORMATTYPE14 = 14,
    SIMPLEFORMATTYPE15 = 15,
    SIMPLEFORMATTYPE16 = 16,
    SIMPLEFORMATTYPE17 = 17,
    SIMPLEFORMATTYPE18,
}SIMPLEFORMATTYPE;


typedef enum{
    YEAR   = 1,
    MONTH  = 2,
    DAY    = 3,
    HOUR   = 4,
    MINUTE = 5,
    SECOND = 6,
}DATETYPE;

typedef enum {
    eCTStringComparisonResultInvalid = -2,          //非法比较
    eCTStringComparisonResultOrderedAscending = -1, //小于（前后升序）=早于
    eCTStringComparisonResultOrderedSame = 0,       //等于
    eCTStringComparisonResultOrderedDescending = 1, //大于（前后降序）=晚于
} eCTStringComparisonResult;


//获取当前格式化时间
+ (NSDateFormatter *)getCurrentDateFormatter;

//获取当前时间
+ (NSDate *)getCurrentDate;

//当前时间戳
+ (NSString*)getCurrentTimestamp;

@end
