//
//  WEXUrlConfig.h
//  WEXFutures
//
//  Created by K on 2017/10/30.
//  Copyright © 2017年 K. All rights reserved.
//


#define kWebInterfaceSite [WEXUrlConfig defaultManager].webInterfaceSite

#import <Foundation/Foundation.h>

@interface WEXUrlConfig : NSObject

/**
 *  api服务器的地址
 */
@property(nonatomic, strong) NSString* webInterfaceSite;


/**
 *  单例，每次调用时，都会判断是否登录，如已登录，则判断是否是苹果测试账号，如果是苹果测试账号，走测试环境。如果不是，直接走正式环境。
 *
 *  @return WEXUrlConfig
 */
+(instancetype)defaultManager;

/**
 *  单例，不对外使用，主要是用于防止函数递归使用的。
 *
 *  @return WEXUrlConfig
 */
+(instancetype)defaultManagerWithNoCheck;

/**
 *  修改到正式环境
 */
-(void)modifyToNormalEnvironment;

@end
