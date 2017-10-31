//
//  LodingHUD.m
//  SH-WEX-BASE
//
//  Created by K on 2017/5/25.
//  Copyright © 2017年 Last Order. All rights reserved.
//

#import "LoadingHUD.h"
#import "ProgressHUD.h"

@interface LoadingHUD ()

@property (nonatomic, strong) LoadingHUD *loadingHUD;

+ (instancetype)shared;

@end


@implementation LoadingHUD

- (LoadingHUD *)loadingHUD {
    
    if (!_loadingHUD) {
        
        _loadingHUD       = [[LoadingHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
        _loadingHUD.shape = ProgressHUDShapeLinear;
        _loadingHUD.type  = ProgressHUDTypeDarkForground;
    }
    return _loadingHUD;
}

+ (instancetype)shared {
    
    static LoadingHUD *loadingHUD = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loadingHUD = [[LoadingHUD alloc] init];
    });
    return loadingHUD;
}

+ (void)showLoading:(NSString *)text inView:(UIView *)view {
    
    LoadingHUD *hud = [[LoadingHUD alloc] initWithView:view];
    hud.text  = text ?: @"加载中 ...";
    hud.shape = ProgressHUDShapeLinear;
    hud.type  = ProgressHUDTypeDarkForground;
    [view addSubview:hud];
    [hud show];
}

+ (void)showLoading:(NSString *)text {
    
    if (![UIApplication sharedApplication].keyWindow) {
        return;
    }
    
    LoadingHUD *loadingHUD = [LoadingHUD shared].loadingHUD;
    loadingHUD.text = text ?: @"加载中 ...";
    [[UIApplication sharedApplication].keyWindow addSubview:loadingHUD];
    [loadingHUD show];
}

+ (void)hideInKeyWindow {
    
    LoadingHUD *loadingHUD = [LoadingHUD shared].loadingHUD;
    [NSThread sleepForTimeInterval:1.0f];
    [loadingHUD dismiss];
    [LoadingHUD shared].loadingHUD = nil;
}

+ (void)hideInView:(UIView *)view {
    
    for (UIView *childView in view.subviews) {
        
        if ([childView isKindOfClass:[LoadingHUD class]]) {
            
            [NSThread sleepForTimeInterval:1.0f];
            [(LoadingHUD *)childView dismiss];
        }
    }
}


@end
