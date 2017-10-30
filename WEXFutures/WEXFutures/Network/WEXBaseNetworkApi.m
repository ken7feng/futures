//
//  WEXBaseNetworkApi.m
//  WEXFutures
//
//  Created by K on 2017/10/30.
//  Copyright © 2017年 K. All rights reserved.
//

#import "WEXBaseNetworkApi.h"
#import "AFNetworking.h"

@implementation WEXBaseNetworkApi

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _networkTimeout = WEX_NETWORK_TIMEOUT_SECONDS;
    }
    return self;
}

- (void)pushCrashLog
{
//    if ([[self currentNetworkType] isEqualToString:@"wifi"])
//    {
//        NSURL * crashUrl = [FileUtil getDocumentURLWithFileName:CrashLog];
//        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//        [manager POST:@"aaa" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//            NSDateFormatter *formatter      = [[NSDateFormatter alloc] init];
//            formatter.dateFormat            = @"yyyyMMddHHmmss";
//            NSString *str                   = [formatter stringFromDate:[NSDate date]];
//            [formData appendPartWithFileURL:crashUrl name:@"crashLog" fileName:[NSString stringWithFormat:@"crashLog<%@>",str] mimeType:@"multipart/form-data" error:nil];
//        } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            [FileUtil deleteFileWithFilePath:[FileUtil dataFilePath:CrashLog]];
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        }];
//
//    }
}

- (NSString *)currentNetworkType
{
    AFNetworkReachabilityStatus netStatus = [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus];
    NSString * networkTpye = nil;
    switch (netStatus)
    {
        case AFNetworkReachabilityStatusUnknown:
        {
            networkTpye = @"unKnow";
        }
            break;
        case AFNetworkReachabilityStatusNotReachable:
        {
            networkTpye = @"notReachable";
        }
            break;
        case AFNetworkReachabilityStatusReachableViaWiFi:
        {
            networkTpye = @"wifi";
        }
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
        {
            networkTpye = @"wwan";
        }
            break;
        default:
        {
            networkTpye = @"default";
        }
            break;
    }
    return networkTpye;
}

- (void)logResponesDataError:(NSString *)errorMsg
{
#ifdef DEBUG
    DebugLog(@"[%@]: %@",LOG_NETWORK,errorMsg);
#endif
    
#ifdef INHOUSE
    DebugLogFile(LOG_NETWORK,@"%@",errorMsg);
#endif
}

@end
