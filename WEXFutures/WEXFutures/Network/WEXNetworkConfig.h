//
//  WEXNetworkConfig.h
//  WEXFutures
//
//  Created by K on 2017/10/30.
//  Copyright © 2017年 K. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WEXNetworkConfig : NSObject

+ (instancetype)defaultManager;

- (NSString*)getCurrentServer;

- (void)setCurrentServer:(NSString *)server;

@end
