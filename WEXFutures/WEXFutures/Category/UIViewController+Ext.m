//
//  UIViewController+Ext.m
//  WEXFutures
//
//  Created by K on 2017/10/31.
//  Copyright © 2017年 K. All rights reserved.
//

#import "UIViewController+Ext.h"

@implementation UIViewController (Ext)

-(void)setBackWithTitle:(NSString*)backTitle
{
    if (![backTitle isKindOfClass:[NSString class]]) {
        return;
    }
    
    UIImage* image = [UIImage imageNamed:@""];
    UIFont* font = [UIFont getFontWithFontName:nil displayStr:(NSString*)backTitle fontSize:17.0f];
    
    UIButton* leftTopBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, font.fontSize.width+image.size.width, font.fontSize.height)];
    leftTopBtn.titleLabel.font = font;
    
    //标题主颜色
//    [leftTopBtn setTitleColor:NAVBAR_TITLE_COLOR forState:UIControlStateNormal];
    [leftTopBtn setTitle:(NSString*)backTitle forState:UIControlStateNormal];
    [leftTopBtn setImage:image forState:UIControlStateNormal];
    
    UIBarButtonItem* leftBar = [[UIBarButtonItem alloc]initWithCustomView:leftTopBtn];
    [leftTopBtn addTarget:self action:@selector(leftTopAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -5;
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, leftBar, nil];
}

-(void)setViewControllerNavigationItemWithLeftObject:(NSObject*)left right:(NSObject*)right title:(NSObject*)title
{
    if (left != nil)
    {
        if ([left isKindOfClass:[UIImage class]])
        {
            UIButton* leftTopBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ((UIImage*)left).size.width, ((UIImage*)left).size.height)];
            [leftTopBtn setImage:(UIImage*)left forState:UIControlStateNormal];
            UIBarButtonItem* leftBar = [[UIBarButtonItem alloc]initWithCustomView:leftTopBtn];
            [leftTopBtn addTarget:self action:@selector(leftTopAction:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                               target:nil action:nil];
            negativeSpacer.width = -5;
            
            self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, leftBar, nil];
        }
        
        if ([left isKindOfClass:[NSString class]])
        {
            UIFont* font = [UIFont getFontWithFontName:nil displayStr:(NSString*)left fontSize:15.0f];
            
            UIButton* leftTopBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, font.fontSize.width, font.fontSize.height)];
            leftTopBtn.titleLabel.font = font;
            //导航左键按钮颜色
//            [leftTopBtn setTitleColor:NAVBAR_TITLE_COLOR forState:UIControlStateNormal];
            [leftTopBtn setTitle:(NSString*)left forState:UIControlStateNormal];
            
            UIBarButtonItem* leftBar = [[UIBarButtonItem alloc]initWithCustomView:leftTopBtn];
            [leftTopBtn addTarget:self action:@selector(leftTopAction:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                               target:nil action:nil];
            negativeSpacer.width = -5;
            
            self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, leftBar, nil];
        }
        
        if ([left isKindOfClass:[UIView class]])
        {
            UIBarButtonItem* leftBar = [[UIBarButtonItem alloc]initWithCustomView:(UIView*)left];
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                               target:nil action:nil];
            negativeSpacer.width = -5;
            
            self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, leftBar, nil];
        }
    }
    
    if (right != nil) {
        if ([right isKindOfClass:[UIImage class]]) {
            UIButton* rightTopBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ((UIImage*)right).size.width, ((UIImage*)right).size.height)];
            [rightTopBtn setImage:((UIImage*)right) forState:UIControlStateNormal];
            [rightTopBtn addTarget:self action:@selector(onTouchUpInside:withEvents:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem* rightBar = [[UIBarButtonItem alloc]initWithCustomView:rightTopBtn];
            
            UIBarButtonItem * RightPositiveSpacer = [[UIBarButtonItem alloc]
                                                     initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                     target:nil action:nil];
            RightPositiveSpacer.width = -5;
            
            self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:RightPositiveSpacer, rightBar, nil];
        }
        
        if ([right isKindOfClass:[NSString class]]) {
            UIFont* font = [UIFont getFontWithFontName:nil displayStr:(NSString*)right fontSize:15.0f];
            UIButton* rightTopBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, font.fontSize.width + 12, font.fontSize.height + 8)];
            rightTopBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            [rightTopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [rightTopBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
            [rightTopBtn setTitle:(NSString*)right forState:UIControlStateNormal];
            //            [rightTopBtn.layer setContentsRect:5];
            [rightTopBtn.layer setCornerRadius:5];
            [rightTopBtn.layer setMasksToBounds:YES];
            
            //导航背景色
//            [rightTopBtn setBackgroundColor:APP_MAIN_COLOR];
            
            [rightTopBtn addTarget:self action:@selector(onTouchUpInside:withEvents:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem* rightBar = [[UIBarButtonItem alloc]initWithCustomView:rightTopBtn];
            
            UIBarButtonItem * RightPositiveSpacer = [[UIBarButtonItem alloc]
                                                     initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                     target:nil action:nil];
            RightPositiveSpacer.width = -5;
            
            self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:RightPositiveSpacer, rightBar, nil];
        }
        
        if ([right isKindOfClass:[UIView class]]) {
            UIBarButtonItem* rightBar = [[UIBarButtonItem alloc]initWithCustomView:(UIView*)right];
            
            UIBarButtonItem * RightPositiveSpacer = [[UIBarButtonItem alloc]
                                                     initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                     target:nil action:nil];
            RightPositiveSpacer.width = -5;
            
            self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:RightPositiveSpacer, rightBar, nil];
        }
    }
    
    if (title != nil) {
        if ([title isKindOfClass:[NSString class]]) {
            UIFont* font = [UIFont getFontWithFontName:nil displayStr:(NSString*)title fontSize:18.0f];
            UILabel* lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 10.5, font.fontSize.width, font.fontSize.height)];
            lab.font = font;
            lab.text = (NSString*)title;
            
            //导航栏字体颜色
//            lab.textColor = NAVBAR_TITLE_COLOR;
            lab.frame = CGRectMake(SCREEN_WIDTH/2.0f - (lab.frame.size.width/2.0f), lab.frame.origin.y, lab.frame.size.width, lab.frame.size.height);
            //            [lab modifyCenterX:SCREEN_WIDTH/2.0f];
            
            self.navigationItem.titleView = lab;
        } else if ([title isKindOfClass:[UIView class]]) {
            self.navigationItem.titleView = (UIView *)title;
        }
    }
}

-(void)leftTopAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)onTouchUpInside:(id)sender withEvents:(UIEvent*)event{
    UITouch* touch = [[event allTouches] anyObject];
    
    //判断点击次数
    if (touch.tapCount == 1)
    {
        [self rightTopAction:sender];
    }else{
        return;
    }
}

-(void)rightTopAction:(id)sender
{
    
}

@end
