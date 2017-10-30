//
//  SizeUtil.m
//  SH-WEX-BASE
//
//  Created by K on 2017/5/25.
//  Copyright © 2017年 Last Order. All rights reserved.
//

#import "SizeUtil.h"
#import <UIKit/UIKit.h>


@implementation SizeUtil

+(double)dimenSize {
    
    double i=1;
    if (SCREEN_WIDTH==320.0f && SCREEN_HEIGHT == 480.0f) {
        i = 1;
    }else if (SCREEN_WIDTH==320.0f && SCREEN_HEIGHT == 568.0f) {
        i = 1;
    }else if (SCREEN_WIDTH==375.0f && SCREEN_HEIGHT == 667.0f) {
        i = 375.f/320.f;
    }else if (SCREEN_WIDTH==414.0f && SCREEN_HEIGHT == 736.f) {
        i = 414.f/320.f;
    }
    return i;
}

@end
