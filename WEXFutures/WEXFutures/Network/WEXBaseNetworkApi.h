//
//  WEXBaseNetworkApi.h
//  WEXFutures
//
//  Created by K on 2017/10/30.
//  Copyright © 2017年 K. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum RequestResultType
{
    ResponseSuccess = 100,
    ResponseFail,
    ResponseRequestFail,
    ResponseNeedLogin,
    ResponsePasswordWrong,
    ResponseShowErrorMessageFromServer,
    NativeShouldShowError,
    ResponseMobileHasBeenRegistered,
    ResponseSMSTimeout,
    ResponseDoNothing,
    ResponseNetworkError,
    
} NetworkRequestResultType;

@interface WEXBaseNetworkApi : NSObject

/**
 接口请求
 
 @param url URL
 @param params 参数
 @param success 成功回调block
 @param faild 失败回调block
 */
- (void)requestPostWithUrl:(NSString *)url paramData:(id)params success:(void (^)(id responseObject))success fail:(void (^)(NSError * error))faild;


/**
 *  @param nonatomic 宏定义超时时间
 */
#ifdef DEBUG
//#define HFH_NETWORK_TIMEOUT_SECONDS  60.0f
#define WEX_NETWORK_TIMEOUT_SECONDS 10.0f
#else
#define WEX_NETWORK_TIMEOUT_SECONDS  20.0f
#endif

- (void)logResponesDataError:(NSString *)errorMsg;

@property (nonatomic, assign)double networkTimeout;

@end
