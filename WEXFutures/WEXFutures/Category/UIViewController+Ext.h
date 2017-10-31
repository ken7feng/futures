//
//  UIViewController+Ext.h
//  WEXFutures
//
//  Created by K on 2017/10/31.
//  Copyright © 2017年 K. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Ext)

-(void)setBackWithTitle:(NSString*)backTitle;

-(void)setViewControllerNavigationItemWithLeftObject:(NSObject*)left right:(NSObject*)right title:(NSObject*)title;

-(void)leftTopAction:(id)sender;

-(void)rightTopAction:(id)sender;

@end
