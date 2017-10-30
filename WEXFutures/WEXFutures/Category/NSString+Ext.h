//
//  NSString+Ext.h
//  WEXWineMall
//
//  Created by K on 2017/7/20.
//  Copyright © 2017年 K. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SAFE_STRING(S) [NSString safeString:S]

@interface NSString (Ext)

//字符串转数字
+(NSNumber*)StringToNumber:(NSString*) str;

//安全字符串
+(NSString*)safeString:(NSString*)string;


/**
 *  如果数据类型是string则原样输出，否则输出nil
 *
 *  @param sourceStr 疑似string
 *
 *  @return string或者nil
 */
+ (NSString *)rawOrNil:(NSString *)sourceStr;

//decode
- (NSData *)decodeHexString;

//MD5
- (NSString *)md5;

- (NSString *)stringByAddingPercentEscapesUsingEncodingExt:(NSStringEncoding)enc;

- (NSString *)stringByReplacingPercentEscapesUsingEncodingExt:(NSStringEncoding)enc;


/**
 url escape
 */
- (NSString *)stringByAddingPercentEscapes;
/**
 url unescape
 */
- (NSString *)stringByReplacingPercentEscapes;

// Standard Base64 decoder
- (NSData *)decodeBase64String;

// URL Base64 decoder (avoid url escape)
- (NSData *)decodeUrlBase64String;

//字符串数字大于万的时候，转换单位
- (NSString *)currencyFormatter:(NSString *)string;

//  判断是否以字母开头
+ (BOOL)isEnglishFirst:(NSString *)str;

//  判断是否以汉字开头
+ (BOOL)isChineseFirst:(NSString *)str;

+ (NSString *)JSONString:(NSString *)aString;

+ (NSString*)ObjectTojsonString:(id)object;

- (CGSize)sizeForLabel:(NSString *)text fontSize:(UIFont *)font;

//计算字体高度
-(CGSize) nvSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)mode;
-(CGSize) nvSizeWithFont:(UIFont *)font forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode;
@end
