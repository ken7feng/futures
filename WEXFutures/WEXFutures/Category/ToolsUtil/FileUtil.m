//
//  FileUtil.m
//  WEXWineMall
//
//  Created by K on 2017/7/20.
//  Copyright © 2017年 K. All rights reserved.
//

#import "FileUtil.h"
#import <sys/xattr.h>

#define  kClientIDKey @"kClientIDKey"

#define kLibraryCacheDir        [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define kDocumentCacheDitDir    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

@implementation FileUtil

static FileUtil * fileUtilInstance = nil;

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

/** 初始化的方法 */
+ (FileUtil *) shareInstance
{
    @synchronized (self)
    {
        if (!fileUtilInstance)
        {
            fileUtilInstance = [[FileUtil alloc]init];
        }
    }
    return fileUtilInstance;
}

/**
 获取文件的路径
 @param fileName 文件名
 @return 组成的文件名
 */
+ (NSString *) dataFilePath:(NSString *)fileName
{
    NSArray * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentPath = [path firstObject];
    return [documentPath stringByAppendingPathComponent:fileName];
}

/**
 判断文件是否存在
 @param filePath 文件路径
 @return YES存在 NO不存在
 */
+ (BOOL) isExistsFilePath:(NSString *)filePath
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        return YES;
    }
    return NO;
}

/***
 根据路径创建文件(如果存在就直接覆盖)
 @param filePath 文件路径
 */
+(void) createFileWithFilePath:(NSString *)filePath
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    //如果有文件，先删除
    if ([FileUtil isExistsFilePath:filePath])
    {
        [fileManager removeItemAtPath:filePath error:nil];
    }
    [fileManager createFileAtPath:filePath contents:nil attributes:nil];
}

/**
 根据文件路径删除文件
 @param filePath 文件路径
 */
+(bool) deleteFileWithFilePath:(NSString *)filePath
{
    DebugLog(@"deleteFileWithFilePath: %@", filePath);
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([FileUtil isExistsFilePath:filePath])
    {
        DebugLog(@"if([FileUitl isExistsFilePath:%@])",filePath);
        return [fileManager removeItemAtPath:filePath error:nil];
    }
    return false;
}

/***
 获取文件大小,失败返回0
 @param filePath 文件路径
 @return 文件的大小
 */
+(unsigned long long)getFileSizeWithFilePath:(NSString *)filePath
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([FileUtil isExistsFilePath:filePath])
    {
        NSError * error = nil;
        NSDictionary * fileAttDict = [fileManager attributesOfItemAtPath:filePath error:&error];
        if (fileAttDict != nil)
        {
            return [fileAttDict fileSize];
        }
        else
        {
            DebugLog(@"获取文件大小失败 description = %@ failureReason = %@",[error localizedDescription], [error localizedFailureReason]);
            return 0;
        }
    }
    else
    {
        return 0;
    }
}

/**
 读取string
 @param filePath 文件路径
 @return 文件的内容
 */
+ (NSString *) readWithContentsOfFile:(NSString *)filePath
{
    NSString * str = @"";
    if ([FileUtil isExistsFilePath:filePath])
    {
        str = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    }
    return str;
}

/**
 读取文件内容到 NSData 中
 @param filePath 文件路径
 @return NSData
 */
+ (NSData *) dataWithContentsOfFile:(NSString *)filePath
{
    NSData * data = nil;
    if ([FileUtil isExistsFilePath:filePath])
    {
        data = [NSData dataWithContentsOfFile:filePath];
    }
    return data;
}

/***
 写字符串 到文件
 @param content 文件内容
 @param filePath 文件目录
 @return 成功与否
 */
+ (bool) writeContent:(NSString *)content filePath:(NSString *)filePath
{
    bool isSuccess = false;
    if (![NSString emptyOrNull:content])
    {
        isSuccess = [content writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
    return isSuccess;
}

/**
 追加字符串 到文件
 @param content 文件内容
 @param filePath 文件目录
 @return 成功与否
 */
+ (BOOL) writeAppendContent:(NSString *)content filePath:(NSString *)filePath
{
    if (![NSString emptyOrNull:content] && filePath.length > 0)
    {
        NSData * contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
        //取得修改句柄
        NSFileHandle * filehandle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
        //移动指针到文件末尾
        [filehandle seekToEndOfFile];
        //追加内容
        [filehandle writeData:contentData];
        return YES;
    }
    return NO;
}

/**
 写文件
 @param data 文件内容
 @param filePath 文件目录
 @return 成功与否
 */
+ (bool) writeData:(NSData *)data filePath:(NSString *)filePath
{
    bool isSuccess = false;
    if (data != nil)
    {
        isSuccess = [data writeToFile:filePath atomically:YES];
    }
    return YES;
}

/**
 追加文件
 @param data 文件内容
 @param filePath 文件目录
 */
+ (BOOL) writeAppendData:(NSData *)data filePath:(NSString *)filePath
{
    if (data != nil)
    {
        NSFileHandle * fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:data];
        return YES;
    }
    return NO;
}

/**
 写clientID 到文件
 @param clientID 委托
 @return 成功与否
 */
+ (bool) writeClientID:(NSString *) clientID
{
    bool isSuccess = false;
    if ([NSString emptyOrNull:clientID])
    {
        return isSuccess;
    }
    else
    {
        @synchronized (self)
        {
            NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:clientID forKey:kClientIDKey];
            isSuccess = [userDefaults synchronize];
        }
        return isSuccess;
    }
    
}

/**
 写clientIDCreateByClient 到文件
 @param clientIDCreateByClient 创建委托
 @return 成功与否
 */
+ (bool) writeClientIDCreateByClient:(NSString *) clientIDCreateByClient
{
    bool isSuccess = false;
    if ([NSString emptyOrNull:clientIDCreateByClient])
    {
        return isSuccess;
    }
    else
    {
        @synchronized (self)
        {
            NSString * doucumentPath = kLibraryCacheDir;
            NSString * clientIDPath = [doucumentPath stringByAppendingPathComponent:@"clientIDCreateByClient.txt"];
            isSuccess = [clientIDCreateByClient writeToFile:clientIDPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        }
        return isSuccess;
    }
}
/***
 读取clientID
 @return 读取的clientId
 */
+ (NSString *) readClientID
{
    NSString * clientID = NULL;
    @synchronized (self)
    {
        NSUserDefaults * dfts = [NSUserDefaults standardUserDefaults];
        clientID = [dfts objectForKey:kClientIDKey];
        //userDefaults没有，检查Library/Cache目录
        if (clientID.length == 0)
        {
            NSString * clientIDTxtName = @"CTClientID.txt";
            NSString * documentPath = kLibraryCacheDir;
            NSString * clientIDLibPath = [documentPath stringByAppendingPathComponent:clientIDTxtName];
            clientID = [NSString stringWithContentsOfFile:clientIDLibPath encoding:NSUTF8StringEncoding error:nil];
            //如果Library/Cache目录没有，检查Documents/Cache目录
            if (clientID.length == 0)
            {
                NSString * docPath = kDocumentCacheDitDir;
                NSString * clientIDDocPath = [docPath stringByAppendingString:clientIDTxtName];
                clientID = [NSString stringWithContentsOfFile:clientIDDocPath encoding:NSUTF8StringEncoding error:nil];
            }
            if (clientID.length == 0)
            {
                clientID = @"";
            }
            else
            {
                [dfts setObject:clientID forKey:kClientIDKey];
                [dfts synchronize];
            }
        }
        return clientID;
    }
}

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        DebugLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}


+ (BOOL)addSkipBackupAttributeToItemAtURLFor501:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    const char* filePath = [[URL path] fileSystemRepresentation];
    
    const char* attrName = "com.apple.MobileBackup";
    u_int8_t attrValue = 1;
    
    int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
    return result == 0;
}


//设置iTunes 不备份
+ (BOOL)addSkipBackUpFileWithPath:(NSString *)path
{
    BOOL isDir = NO;
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir];
    NSURL * URL = nil;
    if (isExist)
    {
        URL = [NSURL fileURLWithPath:path isDirectory:isDir];
    }
    
    BOOL ret = NO;
    
    if (URL)
    {
        if ([IOS_SYSTEM_VERSION floatValue] == 5.0)
        {
            ret = [FileUtil addSkipBackupAttributeToItemAtURLFor501:URL];
        }
        else
        {
            ret = [FileUtil addSkipBackupAttributeToItemAtURL:URL];
        }
    }
    return ret;
}


/**
 *  创建目录
 */
+(BOOL)createDirectory:(NSString *)directory
{
    NSArray * documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * path = [documents[0] stringByAppendingPathComponent:directory];
    if ([[NSFileManager defaultManager] isExecutableFileAtPath:path] == NO)
    {
        [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:directory];
        BOOL bo = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        return bo;
    }
    return YES;
}

/**
 *  根据目录获取绝对路径
 *
 *  @param directory <#directory description#>
 *
 *  @return <#return value description#>
 */
+(NSString*)getAbsolutePathWithDirectory:(NSString*)directory
{
    NSArray * documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * path = [[documents firstObject] stringByAppendingPathComponent:directory];
    return path;
}


/**
 *  清除文件夹下的所有文件
 *
 *  @param directory 文件夹路径
 */
+(void)removeAllFilesWithDirectory:(NSString*)directory
{
    NSArray * files = [[NSFileManager defaultManager] subpathsAtPath:directory];
    DebugLog(@"files :%lu",(unsigned long)[files count]);
    for (NSString * p in files)
    {
        NSError * error = nil;
        NSString * path = [directory stringByAppendingPathComponent:p];
        DebugLog(@"%@\n\n%@", p, path);
        if ([[NSFileManager defaultManager] isExecutableFileAtPath:path])
        {
            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        }
    }
}

/**
 *  清除单个文件
 *
 *  @param path 文件路径
 */
+ (void)clearCachesWithFilePath:(NSString *)path
{
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

/**
 *  文件夹或文件大小
 *
 *  @param path 文件夹或文件路径
 *
 *  @return 大小
 */
+ (double)sizeWithFilePath:(NSString *)path
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    //检查路径合理性
    BOOL dir = NO;
    BOOL isExist = [fileManager fileExistsAtPath:path isDirectory:&dir];
    if (!isExist)
    {
        return 0;
    }
    //是否是文件夹
    //1、是文件夹
    if (dir)
    {
        NSArray * subPaths = [fileManager subpathsAtPath:path];
        int totalSize = 0;
        for (NSString * subPath in subPaths)
        {
            NSString * fullSubPath = [path stringByAppendingPathComponent:subPath];
            BOOL dir = NO;
            [fileManager fileExistsAtPath:fullSubPath isDirectory:&dir];
            if (!dir)
            {
                NSDictionary * attrs = [fileManager attributesOfItemAtPath:fullSubPath error:nil];
                totalSize += [attrs[NSFileSize] floatValue];
            }
        }
        return totalSize / (1000 * 1000.0);
    }
    //2、不是文件夹
    else
    {
        NSDictionary * attrs = [fileManager attributesOfItemAtPath:path error:nil];
        return [attrs[NSFileSize] floatValue] / (1000 * 1000.0);
    }
}

+ (NSURL *)getDocumentURLWithFileName:(NSString *)fileName
{
    NSURL * url = nil;
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([FileUtil isExistsFilePath:[FileUtil dataFilePath:fileName]])
    {
        NSURL * urlPath = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
        url = [urlPath URLByAppendingPathComponent:fileName];
    }
    return url;
}
    
+ (NSMutableDictionary *)locData:(NSString *)fileName
{
    NSString *path = [[NSBundle mainBundle]pathForResource:fileName ofType:@"json"];
    if ([FileUtil isExistsFilePath:path])
    {
        NSData *data = [FileUtil dataWithContentsOfFile:path];
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        return dic;
    }
    return nil;
}
    
+ (void)writeToPlist:(NSArray *)uploadingfiles  Name:(NSString *)name
{
    [uploadingfiles writeToFile:[FileUtil dataFilePath:name] atomically:YES];
}

@end
