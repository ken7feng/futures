//
//  WEXBaseViewController.h
//  WEXFutures
//
//  Created by K on 2017/10/31.
//  Copyright © 2017年 K. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WEXBaseViewController : UIViewController

//显示标题在页面 转圈等待
-(void)indicatorWithTitle:(NSString *)title;
//移除转圈等待
-(void)indicatorRemove;

//显示等待标题在页面 转圈等待
-(void)indicatorWithWait;

/**
 *  隐藏菊花，判断并显示error
 *
 *
 */
-(void)showError:(NSError *)error;


-(void)showError:(NSError *)error alertOkAction:(void(^)(void))okAction alertCancelAction:(void(^)(void))cancelAction;

-(BOOL)allowRightSlide;

/**
 *  显示提示消息
 *
 *  @param message 显示文字
 */
//-(void)showToast:(NSString *)message;

/**
 *  删除提示性文字
 */
-(void)hideProgress;


/**
 *  添加在window的子view，整个页面都无法动弹
 *
 *  @param message 显示文字
 */
-(void)showProgress:(NSString *)message;


/**
 弹框提示
 
 @param contentText 提示信息，默认确认键
 */
- (void)showAlerWithcontentText:(NSString *)contentText;


-(void) showAlertWithTitle:(NSString *)title contentText:(NSString *)contentTxt AndleftBtnTitle:(NSString *)leftTxt AndRightBtnTitle:(NSString *)rightTxt contentCanClicked:(BOOL)bol;


/**
 弱提示
 
 @param message 提示信息
 @param time 提示时间
 */
-(void)showMessage:(NSString *)message duration:(NSTimeInterval)time;


-(void)leftBtnClicked;
-(void)rightBtnClicked;
-(void)contentClicked;


-(void)hideNavcationBarLine:(BOOL)isHide;

/**
 *  toast
 *
 *  @param msg       提示文字
 */
-(void)showToastWithMSG:(NSString *)msg;//时间短1.5s
-(void)showToastWithMSGAtLongTime:(NSString *)msg;//时间长3s

- (UIViewController *)getCurrentVC;

@end
