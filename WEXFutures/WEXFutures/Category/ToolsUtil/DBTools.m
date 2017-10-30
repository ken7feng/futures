//
//  DBTools.m
//  WEXWineMall
//
//  Created by K on 2017/7/21.
//  Copyright © 2017年 K. All rights reserved.
//

#import "DBTools.h"

@implementation DBTools

static DBTools * dbToolsInstance = nil;
//static FMDatabase *_fmdb;

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

/** 初始化的方法 */
+ (DBTools *) shareInstance
{
    @synchronized (self)
    {
        if (!dbToolsInstance)
        {
            dbToolsInstance = [[DBTools alloc]init];
        }
    }
    return dbToolsInstance;
}

+ (BOOL)createNewTableWithSQL:(NSString *)sql andWithFileName:(NSString *)fileName
{
//    // 执行打开数据库和创建表操作
//    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite", fileName]];
//    _fmdb = [FMDatabase databaseWithPath:filePath];
//    if ([_fmdb open])
//    {
//        BOOL result = [_fmdb executeUpdate:sql];
//        if (result)
//        {
//            return YES;
//        }
//    }
    return NO;
}


@end
