//
//  WEXAlert.m
//  WEXFutures
//
//  Created by K on 2017/10/31.
//  Copyright © 2017年 K. All rights reserved.
//

#define kAlertWidth [SizeUtil dimenSize]*250.0f
#define kAlertHeight [SizeUtil dimenSize]*136.0f


#define kTitleYOffset [SizeUtil dimenSize]*8.0f
#define kTitleHeight [SizeUtil dimenSize]*20.0f

#define kContentOffset [SizeUtil dimenSize]*30.0f
#define kBetweenLabelOffset [SizeUtil dimenSize]*20.0f

#import "WEXAlert.h"

@interface WEXAlert()

{
    BOOL _leftLeave;
}

@property (nonatomic, strong) UILabel *alertTitleLabel;
@property (nonatomic, strong) UIButton *alertContentbtn;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *backImageView;

@end

@implementation WEXAlert

+ (CGFloat)alertWidth
{
    return kAlertWidth;
}

+ (CGFloat)alertHeight
{
    return kAlertHeight;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithTitle:(NSString *)title
contentText:(NSString *)content
leftButtonTitle:(NSString *)leftTitle
rightButtonTitle:(NSString *)rigthTitle
contentCanClicked:(BOOL)bol
{
    if (self = [super init]) {
        self.layer.cornerRadius = 8.0;
        self.backgroundColor = [UIColor whiteColor];
        self.alertTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kTitleYOffset, kAlertWidth, kTitleHeight)];
        self.alertTitleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        //app主色调
//        self.alertTitleLabel.textColor = APP_MAIN_COLOR;
        [self addSubview:self.alertTitleLabel];
        
        CGFloat contentLabelWidth = kAlertWidth - [SizeUtil dimenSize]*16;
        self.alertContentbtn = [[UIButton alloc] initWithFrame:CGRectMake((kAlertWidth - contentLabelWidth) * 0.5, CGRectGetMaxY(self.alertTitleLabel.frame), contentLabelWidth, [SizeUtil dimenSize]*60)];
        self.alertContentbtn.titleLabel.numberOfLines = 0;
        self.alertContentbtn.backgroundColor = [UIColor clearColor];
        self.alertContentbtn.titleLabel.textAlignment = self.alertTitleLabel.textAlignment = NSTextAlignmentCenter;
        //app主色调&app字体主色
//        [self.alertContentbtn setTitleColor:ALERT_TITLE_COLOR forState:UIControlStateNormal];
//        [self.alertContentbtn setTitleColor:APP_MAIN_COLOR forState:UIControlStateHighlighted];
        self.alertContentbtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        self.alertContentbtn.userInteractionEnabled =bol;
        [self addSubview:self.alertContentbtn];
        
        CGRect leftBtnFrame;
        CGRect rightBtnFrame;
        
#define kSingleButtonWidth [SizeUtil dimenSize]*160.0f
#define kCoupleButtonWidth [SizeUtil dimenSize]*107.0f
#define kButtonHeight [SizeUtil dimenSize]*40.0f
#define kButtonBottomOffset [SizeUtil dimenSize]*4.0f
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, kAlertHeight - kButtonBottomOffset - kButtonHeight-0.5,kAlertWidth,0.5)];
        //分割线颜色
//        line.backgroundColor=LINE_BACKGROUND;
        [self addSubview:line];
        if (!leftTitle) {
            rightBtnFrame =CGRectMake(0, kAlertHeight - kButtonBottomOffset - kButtonHeight, kAlertWidth, kButtonHeight+kButtonBottomOffset);
            self.rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.rightBtn.frame = rightBtnFrame;
            
        }else {
            UIView *edge = [[UIView alloc]initWithFrame:CGRectMake(kAlertWidth/2, kAlertHeight - kButtonBottomOffset - kButtonHeight,0.5,kButtonHeight+kButtonBottomOffset)];
//            edge.backgroundColor=LINE_BACKGROUND;
            [self addSubview:edge];
            
            leftBtnFrame =  CGRectMake(0, kAlertHeight - kButtonBottomOffset - kButtonHeight, (kAlertWidth-0.5)/2, kButtonHeight+kButtonBottomOffset);
            rightBtnFrame =CGRectMake(kAlertWidth/2+0.5, kAlertHeight - kButtonBottomOffset - kButtonHeight, (kAlertWidth-0.5)/2, kButtonHeight+kButtonBottomOffset);
            self.leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.leftBtn.frame = leftBtnFrame;
            self.rightBtn.frame = rightBtnFrame;
        }
        
        self.leftBtn.backgroundColor = [UIColor clearColor];
        self.rightBtn.backgroundColor =[UIColor clearColor];
        [self.rightBtn setTitle:rigthTitle forState:UIControlStateNormal];
        [self.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
        self.leftBtn.titleLabel.font = self.rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        
        
//        [self.leftBtn setTitleColor:APP_MAIN_COLOR forState:UIControlStateNormal];
//        [self.leftBtn setTitleColor:MAIN_BACKGROUND_COLOR forState:UIControlStateHighlighted];
//
//        [self.rightBtn setTitleColor:APP_MAIN_COLOR forState:UIControlStateNormal];
//        [self.rightBtn setTitleColor:MAIN_BACKGROUND_COLOR forState:UIControlStateHighlighted];
        
        
        [self.leftBtn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.alertContentbtn addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(contentClicked:)]];
        self.leftBtn.layer.masksToBounds = self.rightBtn.layer.masksToBounds = YES;
        self.leftBtn.layer.cornerRadius = self.rightBtn.layer.cornerRadius = 8.0;
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
        
        self.alertTitleLabel.text = title;
        //        self.alertContentbtn.titleLabel.text = content;
        [self.alertContentbtn setTitle:content forState:UIControlStateNormal];
    }
    return self;
}


- (void)leftBtnClicked:(id)sender
{
    _leftLeave = YES;
    [self dismissAlert];
    if (self.leftBlock) {
        self.leftBlock();
    }
}



- (void)rightBtnClicked:(id)sender
{
    _leftLeave = NO;
    [self dismissAlert];
    if (self.rightBlock) {
        self.rightBlock();
    }
}

-(void)contentClicked:(id)sender
{
    [self dismissAlert];
    if (self.contentBlock) {
        self.contentBlock();
    }
    
}

- (void)show
{
    UIViewController *topVC = [self appRootViewController];
    self.frame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, - kAlertHeight - 30, kAlertWidth, kAlertHeight);
    [topVC.view addSubview:self];
}

- (void)dismissAlert
{
    [self removeFromSuperview];
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}


- (void)removeFromSuperview
{
    [self.backImageView removeFromSuperview];
    self.backImageView = nil;
    UIViewController *topVC = [self appRootViewController];
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, CGRectGetHeight(topVC.view.bounds), kAlertWidth, kAlertHeight);
    
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = afterFrame;
        if (_leftLeave) {
            self.transform = CGAffineTransformMakeRotation(-M_1_PI / 1.5);
        }else {
            self.transform = CGAffineTransformMakeRotation(M_1_PI / 1.5);
        }
    } completion:^(BOOL finished) {
        [super removeFromSuperview];
    }];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    UIViewController *topVC = [self appRootViewController];
    
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:topVC.view.bounds];
        self.backImageView.backgroundColor = [UIColor blackColor];
        self.backImageView.alpha = 0.6f;
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    [topVC.view addSubview:self.backImageView];
    self.transform = CGAffineTransformMakeRotation(-M_1_PI / 2);
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, (CGRectGetHeight(topVC.view.bounds) - kAlertHeight) * 0.5, kAlertWidth, kAlertHeight);
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformMakeRotation(0);
        self.frame = afterFrame;
    } completion:^(BOOL finished) {
    }];
    [super willMoveToSuperview:newSuperview];
}

@end

@implementation UIImage (colorful)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
