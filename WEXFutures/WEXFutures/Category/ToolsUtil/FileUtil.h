//
//  FileUtil.h
//  WEXWineMall
//
//  Created by K on 2017/7/20.
//  Copyright © 2017年 K. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 文件操作相关的方法 */
@interface FileUtil : NSObject

/** 初始化的方法 */
+ (FileUtil *) shareInstance;

/**
 获取文件的路径
 @param fileName 文件名
 @return 组成的文件名
 */
+ (NSString *) dataFilePath:(NSString *)fileName;

/**
 判断文件是否存在
 @param filePath 文件路径
 @return YES存在 NO不存在
 */
+ (BOOL) isExistsFilePath:(NSString *)filePath;

/***
 根据路径创建文件(如果存在就直接覆盖)
 @param filePath 文件路径
 */
+(void) createFileWithFilePath:(NSString *)filePath;

/**
 根据文件路径删除文件
 @param filePath 文件路径
 */
+(bool) deleteFileWithFilePath:(NSString *)filePath;

/***
 获取文件大小,失败返回0
 @param filePath 文件路径
 @return 文件的大小
 */
+(unsigned long long)getFileSizeWithFilePath:(NSString *)filePath;

/**
 读取string
 @param filePath 文件路径
 @return 文件的内容
 */
+ (NSString *) readWithContentsOfFile:(NSString *)filePath;

/**
 读取文件内容到 NSData 中
 @param filePath 文件路径
 @return NSData
 */
+ (NSData *) dataWithContentsOfFile:(NSString *)filePath;

/***
 写字符串 到文件
 @param content 文件内容
 @param filePath 文件目录
 @return 成功与否
 */
+ (bool) writeContent:(NSString *)content
             filePath:(NSString *)filePath;

/**
 追加字符串 到文件
 @param content 文件内容
 @param filePath 文件目录
 @return 成功与否
 */
+ (BOOL) writeAppendContent:(NSString *)content
                   filePath:(NSString *)filePath;

/**
 写文件
 @param data 文件内容
 @param filePath 文件目录
 @return 成功与否
 */
+ (bool) writeData:(NSData *)data
          filePath:(NSString *)filePath;

/**
 追加文件
 @param data 文件内容
 @param filePath 文件目录
 */
+ (bool) writeAppendData:(NSData *)data
                filePath:(NSString *)filePath;

/**
 写clientID 到文件
 @param clientID 委托
 @return 成功与否
 */
+ (bool) writeClientID:(NSString *) clientID;

/**
 写clientIDCreateByClient 到文件
 @param clientIDCreateByClient 创建委托
 @return 成功与否
 */
+ (bool) writeClientIDCreateByClient:(NSString *) clientIDCreateByClient;
/***
 读取clientID
 @return 读取的clientId
 */
+ (NSString *) readClientID;

/**
 读取clientID
 @return 读取的clientId
 */


//设置iTunes 不备份
+ (BOOL)addSkipBackUpFileWithPath:(NSString *)path;


/**
 *  创建目录
 */
+(BOOL)createDirectory:(NSString *)directory;

/**
 *  根据目录获取绝对路径
 *
 *  @param directory <#directory description#>
 *
 *  @return <#return value description#>
 */
+(NSString*)getAbsolutePathWithDirectory:(NSString*)directory;

/**
 *  清除文件夹下的所有文件
 *
 *  @param directory 文件夹路径
 */
+(void)removeAllFilesWithDirectory:(NSString*)directory;

/**
 *  清除单个文件
 *
 *  @param path 文件路径
 */
+ (void)clearCachesWithFilePath:(NSString *)path;

/**
 *  文件夹或文件大小
 *
 *  @param path 文件夹或文件路径
 *
 *  @return 大小
 */
+ (double)sizeWithFilePath:(NSString *)path;

/**
 *通过文件名获取文件url
 *
 * @param fileName 文件名
 *
 * @return 文件URL
 */
+ (NSURL *)getDocumentURLWithFileName:(NSString *)fileName;

    
+ (NSMutableDictionary *)locData:(NSString *)fileName;

@end
