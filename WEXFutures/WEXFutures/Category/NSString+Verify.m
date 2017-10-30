//
//  NSString+Verify.m
//  WEXWineMall
//
//  Created by K on 2017/7/21.
//  Copyright © 2017年 K. All rights reserved.
//

#import "NSString+Verify.h"

@implementation NSString (Verify)

+ (BOOL)isNumber:(NSString *)string
{
    if (string.length > 0)
    {
        NSString *regex = @"^(-?\\d+)(\\.\\d+)?$";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        
        if ([predicate evaluateWithObject:string] == YES) {
            return YES;
        }else {
            return NO;
        }
        
    }
    return YES;
}

+ (BOOL)isPhoneNum:(NSString *)string
{
    if (![string hasPrefix:@"1"]) {
        return NO;
    }
    if (string && string.length == 11) {
        if ([self isPureInt:string]) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)isPassword:(NSString *)string
{
    if (string) {
        
        //判断位数
        NSUInteger len = string.length;
        if ( len >= 6 && len<=20) {
            
            //判断是否包含2类
            BOOL isPureInt = [self isPureInt:string];
            BOOL isPureLetter = [self isPureLetter:string];
            BOOL isPureSpechars = [self isPureSpechars:string];
            
            if (!isPureInt && !isPureLetter && !isPureSpechars) {
                //说明不是纯的3类
                return YES;
            }
        }
    }
    return NO;
}

+ (BOOL)isName:(NSString *)string{
    
    if (string.length > 0 && [NSString onlyChinese:string forLength:99]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isPureInt:(NSString*)string{
    if (string.length > 0) {
        NSScanner* scan = [NSScanner scannerWithString:string];
        int val;
        return[scan scanInt:&val] && [scan isAtEnd];
    }
    return YES;
}

+ (BOOL)isPureLetter:(NSString*)string
{
    if (string && string.length > 0) {
        NSString *regex = @"^[a-zA-Z]*$";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        
        if ([predicate evaluateWithObject:string] == YES) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)isPureSpechars:(NSString*)string
{
    if (string && string.length > 0) {
        // 特殊字符包含`、-、=、\、[、]、;、'、,、.、/、~、!、@、#、$、%、^、&、*、(、)、_、+、|、?、>、<、"、:、{、}
        //        NSString *regex = @".*[-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]+.*";
        NSString *regex = @"[^a-zA-Z0-9]*";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        if ([predicate evaluateWithObject:string] == YES) {
            return YES;
        }
    }
    return NO;
}

+(BOOL)isContainChinese:(NSString*)str
{
    BOOL flag=NO;
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if(a>0x4e00&&a<0x9fff){
            flag=YES;
            break;
        }
    }
    return flag;
}

+ (BOOL)isValidEmail:(NSString *)str
{
    NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [regExPredicate evaluateWithObject:str];
}

+(bool)emptyOrNull:(NSString *)str
{
    if (![str isKindOfClass:[NSString class]])
    {
        return YES;
    }
    return str == nil || (NSNull *)str == [NSNull null] || str.length == 0;
}

+ (NSString *)bankCardFormat:(NSString *)sourceS{
    if (sourceS.length) {
        
    }else{
        return nil;
    }
    NSMutableString *tmpS = [NSMutableString stringWithString:sourceS];
    for (int i = 4; i < tmpS.length; i += 5) {
        [tmpS insertString:@" " atIndex:i];
    }
    return tmpS;
    
}

+ (BOOL)onlyChinese:(NSString *)sourceStr forLength:(int)lengthI{
    NSString *emailRegex = @"^[\u4e00-\u9fa5]+$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:sourceStr] && sourceStr.length <= lengthI;
}

@end
