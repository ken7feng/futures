//
//  WEXUrlConfig.m
//  WEXFutures
//
//  Created by K on 2017/10/30.
//  Copyright © 2017年 K. All rights reserved.
//

#import "WEXUrlConfig.h"
#import "WEXNetworkConfig.h"

static WEXUrlConfig * _kUrlConfig_sharedInstance = nil;

@implementation WEXUrlConfig

+ (instancetype)defaultManager
{
    if (!_kUrlConfig_sharedInstance)
    {
        @synchronized (self)
        {
            if (!_kUrlConfig_sharedInstance)
            {
                _kUrlConfig_sharedInstance = [[WEXUrlConfig alloc]init];
                
            }
        }
    }
    
    
    return _kUrlConfig_sharedInstance;
}

+ (instancetype)defaultManagerWithNoCheck
{
    if (!_kUrlConfig_sharedInstance) {
        @synchronized(self){
            if (!_kUrlConfig_sharedInstance) {
                _kUrlConfig_sharedInstance = [[WEXUrlConfig alloc] init];
            }
        }
    }
    return _kUrlConfig_sharedInstance;
}

-(instancetype)init
{
    self = [super init];
    if(self)
    {
        [self modifyToNormalEnvironment];
    }
    return self;
}



/**
 *  修改环境
 */
-(void)modifyToNormalEnvironment
{
    //#ifdef DEBUG
    //    _webInterfaceSite = @"http://interface.shwex.com/";
    //#else
    //    _webInterfaceSite = @"https://b2bapi.shwex.com/";
    //#endif
    _webInterfaceSite = @"https://b2bapi.shwex.com";
    [[WEXNetworkConfig defaultManager] setCurrentServer:_webInterfaceSite];
}

@end
