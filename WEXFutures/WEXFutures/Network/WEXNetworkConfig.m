//
//  WEXNetworkConfig.m
//  WEXFutures
//
//  Created by K on 2017/10/30.
//  Copyright © 2017年 K. All rights reserved.
//

#import "WEXNetworkConfig.h"
#import "WEXUrlConfig.h"

@interface WEXNetworkConfig ()

{
    NSString * _serverAddress;
}

@end

static WEXNetworkConfig * _Networking_config_sharedInstance = nil;

@implementation WEXNetworkConfig

+ (instancetype)defaultManager
{
    if (!_Networking_config_sharedInstance)
    {
        @synchronized (self)
        {
            if (!_Networking_config_sharedInstance)
            {
                _Networking_config_sharedInstance = [[WEXNetworkConfig alloc]init];
                [_Networking_config_sharedInstance initParam];
            }
        }
    }
    return _Networking_config_sharedInstance;
}

- (void)initParam
{
    _serverAddress = kWebInterfaceSite;
}

- (NSString*)getCurrentServer
{
    return _serverAddress;
}

- (void)setCurrentServer:(NSString *)server
{
    if (server) {
        _serverAddress = server;
    }
}

@end
