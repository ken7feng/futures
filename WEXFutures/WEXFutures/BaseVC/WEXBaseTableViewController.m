//
//  WEXBaseTableViewController.m
//  WEXFutures
//
//  Created by K on 2017/10/31.
//  Copyright © 2017年 K. All rights reserved.
//

#import "WEXBaseTableViewController.h"
#import "UIViewController+Ext.h"
#import "LoadingHUD.h"
#import "WEXAlert.h"
#import "ToastView.h"

@interface WEXBaseTableViewController ()

{
    BOOL _allowRightSlide;
    
    NSString *_viewControllerName;
}

@end

@implementation WEXBaseTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _allowRightSlide = [self allowRightSlide];
    }
    return self;
}

-(BOOL)allowRightSlide
{
    return YES;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _viewControllerName = [NSString stringWithUTF8String:object_getClassName(self)];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setBackWithTitle:@""];
    
    //    if (IS_IPHONE_6 || IS_IPHONE_6_PLUS)
    //    {
    //        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(transformView:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //    }
    
    //    self.view.backgroundColor = MAIN_BackGroundColor;
    
    /**
     *  导航栏字体颜色设置
     */
    //    [self.navigationController.navigationBar setBarTintColor:Nav_Color];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:18], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    if (self.navigationController)
    {
        //        self.coreNavigationController = (NVCoreNavigationController *)self.navigationController;
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [super didReceiveMemoryWarning];
#ifdef ANTDEBUG
    DebugLog(@"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\r\n %@--------内存警告 ！！！！！！！！",_viewControllerName);
    AlertViewButtonItem* okBtn = [AlertViewButtonItem itemWithLabel:@"OK"];
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"内存警告:%@", _viewControllerName] message:nil cancelButtonItem:okBtn otherButtonItems:nil];
    [alertView show];
#endif
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void)showToastWithMSG:(NSString *)msg
{
    [[ToastView makeText:msg]showWithType:ShortTime];
}

-(void)showToastWithMSGAtLongTime:(NSString *)msg
{
    [[ToastView makeText:msg]showWithType:LongTime];
}

-(void)indicatorWithTitle:(NSString *)title
{
    [self showProgress:title];
}

//显示等待标题在页面 转圈等待
-(void)indicatorWithWait{
    CrashDebugLog(@"%@", _viewControllerName);
    [self showProgress:@"加载中...."];
}

//移除转圈等待
-(void)indicatorRemove
{
    [self hideProgress];
}

-(void)hideProgress
{
    [LoadingHUD hideInView:self.view];
}


-(void)showProgress:(NSString *)message
{
    [LoadingHUD showLoading:message inView:self.view];
}

-(void)showError:(NSError *)error{
    
    [self showError:error alertOkAction:nil alertCancelAction:nil];
}

-(void)showError:(NSError *)error alertOkAction:(void(^)())okAction alertCancelAction:(void(^)())cancelAction
{
    [self hideProgress];
}

//提示
- (void)showAlerWithcontentText:(NSString *)contentText
{
    [self showAlertWithTitle:@"提示" contentText:contentText AndleftBtnTitle:nil AndRightBtnTitle:@"确定" contentCanClicked:nil];
}

-(void) showAlertWithTitle:(NSString *)title contentText:(NSString *)contentTxt AndleftBtnTitle:(NSString *)leftTxt AndRightBtnTitle:(NSString *)rightTxt contentCanClicked:(BOOL)bol{
    
    WEXAlert *alert = [[WEXAlert alloc]initWithTitle:title contentText:contentTxt leftButtonTitle:leftTxt rightButtonTitle:rightTxt contentCanClicked:bol];
    [alert show];
    alert.leftBlock =^()
    {
        [self leftBtnClicked];
    };
    alert.rightBlock = ^() {
        [self rightBtnClicked];
        
    };
    alert.contentBlock =^(){
        [self contentClicked];
    };
    
    alert.dismissBlock = ^() {
        
    };
    
}

-(void)showMessage:(NSString *)message duration:(NSTimeInterval)time
{
    [self hideProgress];
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor grayColor];
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    
    UILabel *label = [[UILabel alloc]init];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15.f],
                                 NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [message boundingRectWithSize:CGSizeMake(207, 999)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:attributes context:nil].size;
    
    label.frame = CGRectMake(10, 5, labelSize.width +20, labelSize.height);
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    [showview addSubview:label];
    
    showview.frame = CGRectMake((screenSize.width - labelSize.width - 20)/2,
                                screenSize.height - 300,
                                labelSize.width+40,
                                labelSize.height+10);
    [UIView animateWithDuration:time animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}


-(void)leftBtnClicked
{
    
}

-(void)rightBtnClicked
{
    
}

-(void)contentClicked
{
    
}

@end
