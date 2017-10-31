//
//  ToastView.h
//  WEXFutures
//
//  Created by K on 2017/10/31.
//  Copyright © 2017年 K. All rights reserved.
//

#import <UIKit/UIKit.h>

enum TimeType
{
    LongTime,
    ShortTime
};

@interface ToastView : UIView

{
    UILabel* _label;
    NSString * _text;
    enum TimeType _time;
}
+(ToastView *)makeText:(NSString *)text;
-(void)showWithType:(enum TimeType)type;

@end
