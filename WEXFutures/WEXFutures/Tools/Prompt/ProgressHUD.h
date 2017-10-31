//
//  ProgressHUD.h
//  SH-WEX-BASE
//
//  Created by K on 2017/5/25.
//  Copyright © 2017年 Last Order. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, ProgressHUDType) {
    ProgressHUDTypeDarkForground,
    ProgressHUDTypeDarkBackground
};

typedef NS_ENUM(NSUInteger, ProgressHUDShape) {
    ProgressHUDShapeLinear,
    ProgressHUDShapeCircle
};


@interface ProgressHUD : UIView


@property (nonatomic, assign) ProgressHUDType type;
@property (nonatomic, assign) ProgressHUDShape shape;
@property (nonatomic, assign) CGFloat diameter;
@property (nonatomic, strong) NSString *text;

- (id)initWithView:(UIView *)view;

- (void)show;

- (void)dismiss;

@end
