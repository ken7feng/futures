//
//  NSString+Ext.m
//  WEXWineMall
//
//  Created by K on 2017/7/20.
//  Copyright © 2017年 K. All rights reserved.
//

#import "NSString+Ext.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Ext)

int __char2hex(unsigned char c) {
    switch (c) {
        case '0' ... '9':
            return c - '0';
        case 'a' ... 'f':
            return c - 'a' + 10;
        case 'A' ... 'F':
            return c - 'A' + 10;
        default:
            return 0x00;
    }
}

+ (NSString *)safeString:(NSString *)string
{
    if (string == nil)
    {
        return @"";
    }
    if (![string isKindOfClass:[NSString class]]) {
        return  @"";
    }
    return string;
}

+ (NSString *)rawOrNil:(NSString *)sourceStr{
    if ([sourceStr isKindOfClass:[NSString class]]){
        return sourceStr;
    }else{
        return nil;
    }
}

+(NSNumber*)StringToNumber:(NSString*) str
{
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterNoStyle];
    NSNumber * myNumber = [f numberFromString:str];
    return  myNumber;
}

- (NSData *)decodeHexString {
    NSInteger len = [self length];
    unichar buf[len];
    [self getCharacters:buf range:NSMakeRange(0, len)];
    
    unsigned char resultBytes[len / 2];
    
    for(NSUInteger i = 0, n = len / 2; i < n; i++) {
        resultBytes[i] = (__char2hex(buf[i*2]) << 4) | __char2hex(buf[i*2 + 1]);
    }
    
    return [NSData dataWithBytes:resultBytes length:len / 2];
}

- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)stringByAddingPercentEscapesUsingEncodingExt:(NSStringEncoding)enc
{
    
//    NSString * newString = (__bridge_transfer NSString *)
//    CFURLCreateStringByAddingPercentEscapes(NULL,
//                                            (__bridge CFStringRef)self,
//                                            NULL,
//                                            (CFStringRef)@"!*'();:@&=+$,/?%#[]",
//                                            CFStringConvertNSStringEncodingToEncoding(enc));
//    
//    return newString;
//
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodedUrl = [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return encodedUrl;
}

- (NSString *)stringByReplacingPercentEscapesUsingEncodingExt:(NSStringEncoding)enc
{
    
    NSString * newString = (__bridge_transfer NSString *)
    CFURLCreateStringByReplacingPercentEscapes(NULL, (__bridge CFStringRef)self, CFSTR(""));
    
    return newString;
    
}

- (NSString *)stringByAddingPercentEscapes
{
    return [self stringByAddingPercentEscapesUsingEncodingExt:NSUTF8StringEncoding];
}

- (NSString *)stringByReplacingPercentEscapes
{
    return [self stringByReplacingPercentEscapesUsingEncodingExt:NSUTF8StringEncoding];
}

- (NSData *)decodeBase64String {
    static const short _base64DecodingTable[256] = {
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -1, -1, -2, -1, -1, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
        -1, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, 62, -2, -2, -2, 63,
        52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -2, -2, -2, -2, -2, -2,
        -2,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
        15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -2, -2, -2, -2, -2,
        -2, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
        41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -2, -2, -2, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2
    };
    
    const char *objPointer = [self cStringUsingEncoding:NSASCIIStringEncoding];
    size_t intLength = strlen(objPointer);
    int intCurrent;
    int i = 0, j = 0, k;
    
    unsigned char *objResult = calloc(intLength, sizeof(unsigned char));
    // Run through the whole string, converting as we go
    while ( ((intCurrent = *objPointer++) != '\0') && (intLength-- > 0) ) {
        if (intCurrent == '=') {
            if (*objPointer != '=' && ((i % 4) == 1)) {// || (intLength > 0)) {
                // the padding character is invalid at this point -- so this entire string is invalid
                free(objResult);
                return nil;
            }
            continue;
        }
        
        intCurrent = _base64DecodingTable[intCurrent];
        if (intCurrent == -1) {
            // we're at a whitespace -- simply skip over
            continue;
        } else if (intCurrent == -2) {
            // we're at an invalid character
            free(objResult);
            return nil;
        }
        
        switch (i % 4) {
            case 0:
                objResult[j] = intCurrent << 2;
                break;
                
            case 1:
                objResult[j++] |= intCurrent >> 4;
                objResult[j] = (intCurrent & 0x0f) << 4;
                break;
                
            case 2:
                objResult[j++] |= intCurrent >>2;
                objResult[j] = (intCurrent & 0x03) << 6;
                break;
                
            case 3:
                objResult[j++] |= intCurrent;
                break;
        }
        i++;
    }
    
    // mop things up if we ended on a boundary
    k = j;
    if (intCurrent == '=') {
        switch (i % 4) {
            case 1:
                // Invalid state
                free(objResult);
                return nil;
                
            case 2:
                k++;
                // flow through
            case 3:
                objResult[k] = 0;
        }
    }
    
    // Cleanup and setup the return NSData
    NSData * objData = [NSData dataWithBytes:objResult length:j];
    free(objResult);
    return objData;
}

- (NSData *)decodeUrlBase64String {
    static const short _urlBase64DecodingTable[256] = {
        00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00,
        00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00,
        00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 62, 00, 00,
        52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 00, 00, 00, 00, 00, 00,
        00,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
        15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 00, 00, 00, 00, 63,
        00, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
        41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 00, 00, 00, 00, 00,
        00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00,
        00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00,
        00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00,
        00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00,
        00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00,
        00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00,
        00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00,
        00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00
    };
    
    NSUInteger length = [self length];
    NSUInteger _length4 = (length + 3) / 4 * 4, delta = _length4 - length;
    NSUInteger dlength = _length4 * 3 / 4 - delta;
    
    unichar buffer[length];
    [self getCharacters:buffer range:NSMakeRange(0, length)];
    NSMutableData *data = [NSMutableData dataWithLength:dlength];
    
    uint8_t* bytes = [data mutableBytes];
    
    int index = 0;
    for (int i = 0; i < length; i += 4) {
        short c0 = _urlBase64DecodingTable[buffer[i] & 0xFF];
        short c1 = _urlBase64DecodingTable[buffer[i + 1] & 0xFF];
        bytes[index++] = (uint8_t) (((c0 << 2) | (c1 >> 4)) & 0xFF);
        if (index >= dlength) {
            return data;
        }
        short c2 = _urlBase64DecodingTable[buffer[i + 2] & 0xFF];
        bytes[index++] = (uint8_t) (((c1 << 4) | (c2 >> 2)) & 0xFF);
        if (index >= dlength) {
            return data;
        }
        int c3 = _urlBase64DecodingTable[buffer[i + 3] & 0xFF];
        bytes[index++] = (uint8_t) (((c2 << 6) | c3) & 0xFF);
    }
    
    return data;
}

-(CGSize) nvSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)mode
{
    if (!self || self.length == 0) {
        return CGSizeZero;
    }
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSDictionary * attrs = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
        //IOS7 测量字符串问题，需向下取整
        CGSize sbSize = [self boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
        sbSize.height = ceilf(sbSize.height);
        sbSize.width = ceilf(sbSize.width);
        return sbSize;
    } else {
        //        return [self sizeWithFont:font constrainedToSize:size lineBreakMode:mode];
        NSDictionary *attribute = @{NSFontAttributeName: font};
        CGSize stringSize = [self boundingRectWithSize:size options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        return stringSize;
    }
}

- (NSString *)currencyFormatter:(NSString *)string
{
    
    float vol = [[NSString stringWithFormat:@"%@",string] floatValue];
    if (vol==0) {
        NSString *volume = [NSString stringWithFormat:@"0元"];
        return volume;
    }else if (vol>= 10000) {
        NSString *volume = [NSString stringWithFormat:@"%.2lf万",vol/10000];
        return volume;
    }else if (vol>=100000000)
    {
        NSString *volume = [NSString stringWithFormat:@"%.2lf亿",vol/100000000];
        return volume;
    }else{
        NSString *volume = [NSString stringWithFormat:@"%.2lf元",vol];
        return volume;
    }
}

- (CGSize)sizeForLabel:(NSString *)text fontSize:(UIFont *)font
{
    
    if (!self || self.length == 0) {
        return CGSizeZero;
    }
    CGSize size;
    if ([IOS_SYSTEM_VERSION integerValue] > 7)
    {
        size = [text sizeWithAttributes:@{NSFontAttributeName:font}];
    } else {
        NSAttributedString *attributeSting = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:font}];
        size = [attributeSting size];
    }
    return size;
}

-(CGSize) nvSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    return [self nvSizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
}

-(CGSize) nvSizeWithFont:(UIFont *)font forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    return [self nvSizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:lineBreakMode];
}


//  判断是否以字母开头
+ (BOOL)isEnglishFirst:(NSString *)str
{
    NSString *regular = @"^[A-Za-z].+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regular];
    
    if ([predicate evaluateWithObject:str] == YES){
        return YES;
    }else{
        return NO;
    }
}
//  判断是否以汉字开头
+ (BOOL)isChineseFirst:(NSString *)str
{
    int utfCode = 0;
    void *buffer = &utfCode;
    NSRange range = NSMakeRange(0, 1);
    BOOL b = [str getBytes:buffer maxLength:2 usedLength:NULL encoding:NSUTF16LittleEndianStringEncoding options:NSStringEncodingConversionExternalRepresentation range:range remainingRange:NULL];
    if (b && (utfCode >= 0x4e00 && utfCode <= 0x9fa5)){
        return YES;
    }else{
        return NO;
    }
}

+ (NSString *)JSONString:(NSString *)aString {
    NSMutableString *s = [NSMutableString stringWithString:aString];
    [s replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"/" withString:@"\\/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\b" withString:@"\\b" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\f" withString:@"\\f" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\r" withString:@"\\r" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\t" withString:@"\\t" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    return [NSString stringWithString:s];
}

+ (NSString*)ObjectTojsonString:(id)object

{
    
    NSString *jsonString = [[NSString alloc]init];
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                        
                                                      options:NSJSONWritingPrettyPrinted
                        
                                                        error:&error];
    
    if (! jsonData) {
        
        NSLog(@"error: %@", error);
        
    } else {
        
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    NSString *character = nil;
    for (int i = 0; i < mutStr.length; i ++) {
        character = [mutStr substringWithRange:NSMakeRange(i, 1)];
        if ([character isEqualToString:@"\\"])
            [mutStr deleteCharactersInRange:NSMakeRange(i, 1)];
    }
    
    return mutStr;
    
}

@end
