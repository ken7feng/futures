//
//  NSString+Verify.h
//  WEXWineMall
//
//  Created by K on 2017/7/21.
//  Copyright © 2017年 K. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Verify)

//验证是否为纯数字，包含小数
+ (BOOL)isNumber:(NSString *)string;

//验证手机号长度，是否为纯数字
+ (BOOL)isPhoneNum:(NSString *)string;

//验证是否为密码，6-20位，包含数字，字母，符号，中两类
+ (BOOL)isPassword:(NSString *)string;

//判断是否为人名
+ (BOOL)isName:(NSString *)string;

//判断是否为整形
+ (BOOL)isPureInt:(NSString*)string;

//判断是否为纯字母
+ (BOOL)isPureLetter:(NSString*)string;

//判断是否有特殊字符
+ (BOOL)isPureSpechars:(NSString*)string;

//是否含有汉字
+ (BOOL)isContainChinese:(NSString*)str;

//验证是否是邮箱
+ (BOOL)isValidEmail:(NSString *)str;

//判断字符串是否为空
+(bool)emptyOrNull:(NSString *)str;

//银行卡格式化，每四个用空格分开
+ (NSString *)bankCardFormat:(NSString *)souuceStr;

@end
