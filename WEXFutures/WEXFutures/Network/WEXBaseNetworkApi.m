//
//  WEXBaseNetworkApi.m
//  WEXFutures
//
//  Created by K on 2017/10/30.
//  Copyright © 2017年 K. All rights reserved.
//

#import "WEXBaseNetworkApi.h"
#import "AFNetworking.h"
#import "WEXNetworkConfig.h"

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

- (void)requestPostWithUrl:(NSString *)url paramData:(id)params success:(void (^)(id responseObject))success fail:(void (^)(NSError * error))faild
{
    NSDate * date = [NSDate getCurrentDate];
    NSString* timeStamp = [NSString stringWithFormat:@"%d", (int)([date timeIntervalSince1970]/1)];
    
    //用户token
    NSString *token = @"";//[UserDefaultData sessionKey];
    if (token.length <= 0&& [NSString emptyOrNull:token]) {
        token = @"";
    }
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json" ,@"text/javascript", @"image/png", @"image/jpeg", nil];
    [manager.requestSerializer setValue:timeStamp forHTTPHeaderField:@"X-HFH-T"]; //访问时间
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"apiToken"];
    [manager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"device"];
    [manager.requestSerializer setValue:AppVersion forHTTPHeaderField:@"version"];
    [manager.requestSerializer setTimeoutInterval:_networkTimeout];
    
    //    NSString* doUrl = [NSString stringWithFormat:@"%@%@%@",[[NetworkConfig defaultManager] getCurrentServer],AppVersion,url];
    NSString* doUrl = [NSString stringWithFormat:@"%@%@",[[WEXNetworkConfig defaultManager] getCurrentServer],url];
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    NSLog(@"--------------===============%@===============--------------",manager.requestSerializer.HTTPRequestHeaders);
    
    [manager POST:doUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress)
     {
#ifdef DEBUG
         DebugLog(@"progress:%@",uploadProgress);
#endif
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSTimeInterval responseTime = [[NSDate date] timeIntervalSince1970];
         [self addEventWithSendTime:requestTime responseTime:responseTime];
         if (responseObject != nil)
         {
             NSData *tempDisplay = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
             NSString *tempString =[[NSString alloc] initWithData:tempDisplay encoding:NSUTF8StringEncoding];
#ifdef DEBUG
             DebugLog(@"----------------------------------------------------------------\n  >>>>> 接口URL: %@\r\n  >>>>> 接口参数:\r\n\%@\r\n  >>>>> 接口返回值: %@\r\n----------------------------------------------------------------", doUrl, params,tempString);
#endif
             if (success)
             {
                 NSString * status = nil;
                 NSString * errmsg = nil;
                 @try
                 {
                     status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"status"]];
                     errmsg = [responseObject objectForKey:@"errmsg"];
                 } @catch (NSException *exception) {
                     faild([[NSError alloc]initWithDomain:@"error" code:ResponseFail userInfo:nil]);
                     return;
#ifdef DEBUG
                     DebugLog(@"*****************************************************************\n  >>>>> 接口URL%@------- 【status】异常！！！！！！:",doUrl);
#endif
                 }
                 if ([status isEqualToString:@"200"])
                 {
                     id responseData = nil;
                     @try {
                         responseData = [responseObject objectForKey:@"data"];
                     } @catch (NSException *exception) {
#ifdef DEBUG
                         DebugLog(@"*****************************************************************\n  >>>>> 接口URL%@------- 【data】异常,data节点未找到！！！！！！:",doUrl);
#endif
                         faild([NSError errorWithDomain:@"error" code:ResponseDoNothing userInfo:nil]);
                     }
                     success(responseData);
                 }
                 //token失效
                 else if ([status isEqualToString:@""])
                 {
                     
                 }
                 else
                 {
                     
                     //自定义的报错模式
//                     ErrorModel * errorDataModel = [[ErrorModel alloc]init];
//                     errorDataModel.errmsg = errmsg;
//                     errorDataModel.code = status;
//                     NSError *error = [[NSError alloc]initWithDomain:@"error" code:ResponseNetworkError userInfo:@{kError : errorDataModel}];
                     NSError * error = [[NSError alloc]initWithDomain:@"error" code:ResponseNetworkError userInfo:nil];
                     faild(error);
                     
                 }
             }
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
#ifdef DEBUG
         DebugLog(@"*****************************************************************\n  >>>>> 接口URL%@  \r\n--------【networkError】 Error:%@",doUrl,error);
#endif
         if (faild) {
             faild(error);
             
         }
     }];
}

-(void)addEventWithSendTime:(NSTimeInterval)sendTime responseTime:(NSTimeInterval)responseTime
{
    NSTimeInterval totalTime = (responseTime-sendTime)/100;
    NSString* netType = [self currentNetworkType];
    NSString* timeLabel = nil;
    
    if (totalTime < 05) {
        timeLabel = @"0005";
    }
    else if(totalTime < 10)
    {
        timeLabel = @"0510";
    }
    else if(totalTime < 15)
    {
        timeLabel = @"1015";
    }else if(totalTime < 20)
    {
        timeLabel = @"1520";
    }else if(totalTime < 25)
    {
        timeLabel = @"2025";
    }
    else if(totalTime < 30)
    {
        timeLabel = @"2530";
    }
    else if(totalTime < 35)
    {
        timeLabel = @"3035";
    }
    else if(totalTime < 40)
    {
        timeLabel = @"3540";
    }
    else if(totalTime < 50)
    {
        timeLabel = @"4050";
    }
    else if(totalTime < 60)
    {
        timeLabel = @"5060";
    }
    else if(totalTime < 70)
    {
        timeLabel = @"6070";
    }
    else if(totalTime < 80)
    {
        timeLabel = @"7080";
    }
    else
    {
        timeLabel = @"8099";
    }
    //    NSString* label = [NSString stringWithFormat:@"%@%@", netType, timeLabel];
}

@end
