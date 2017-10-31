//
//  LodingHUD.h
//  SH-WEX-BASE
//
//  Created by K on 2017/5/25.
//  Copyright © 2017年 Last Order. All rights reserved.
//

#import "ProgressHUD.h"

@interface LoadingHUD : ProgressHUD

#pragma mark - HUD 添加到 KeyWindow

/**
 *  显示 HUD 到 KeyWindow 上
 *
 *  @param text 文字
 */
+ (void)showLoading:(NSString *)text;

/**
 *  隐藏添加到 KeyWindow 上的 HUD
 */
+ (void)hideInKeyWindow;

#pragma mark - HUD 添加到 View

/**
 *  显示 HUD 到 View 上
 *
 *  @param text 文字
 *  @param view view
 */
+ (void)showLoading:(NSString *)text inView:(UIView *)view;

/**
 *  隐藏添加到 View 上的 HUD
 *
 *  @param view view
 */
+ (void)hideInView:(UIView *)view;


@end
