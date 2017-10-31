//
//  ToastView.m
//  WEXFutures
//
//  Created by K on 2017/10/31.
//  Copyright © 2017年 K. All rights reserved.
//

#import "ToastView.h"

static ToastView * _toast = nil;

@implementation ToastView

- (id)initWithText:(NSString*)text
{
    self = [super init];
    if (self) {
        _text = [text copy];
        // Initialization code
        UIFont *font = [UIFont systemFontOfSize:16];
        
//        CGSize textSize = [_text sizeWithFont:font constrainedToSize:CGSizeMake(SCREEN_WIDTH/3*2, 66)];
        CGRect textSize = [_text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH / 3 * 2, 66) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil];
        //leak;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 8, textSize.size.width, textSize.size.height)];
        //tosat字体颜色
//        label.backgroundColor = RandomColor;
        label.textColor = [UIColor blackColor];
        label.font = font;
        label.text = _text;
        label.numberOfLines = 0;
        label.shadowColor = [UIColor darkGrayColor];
        label.shadowOffset = CGSizeMake(1, 1);
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        CGRect rect;
        rect.size = CGSizeMake(textSize.size.width + 40, textSize.size.height + 16);
        rect.origin = CGPointMake((SCREEN_WIDTH-rect.size.width)/2, SCREEN_HEIGHT/2-33);
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        [self setFrame:rect];
        [self addSubview:label];
    }
    return self;
}


+(ToastView *)makeText:(NSString *)text{
    @synchronized(self){
        if(_toast == nil){
            _toast = [[ToastView alloc]initWithText:text];
        }
    }
    
    return _toast;
}

-(void)showWithType:(enum TimeType)type{
    if (type == LongTime) {
        _time = 3.0f;
    }
    else{
        _time = 1.0f;
    }
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    NSTimer *timer1 = [NSTimer timerWithTimeInterval:(_time/4.0f)  target:self selector:@selector(removeToast) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:timer1 forMode:NSDefaultRunLoopMode];
    [window addSubview:self];
}

-(void)removeToast
{
    [UIView animateWithDuration:_time animations:^{
        if (_toast.alpha!=0.0f) {
            _toast.alpha -= 0.3f;
        }
    }
                     completion:^(BOOL finished) {
                         [_toast setAlpha:0];
                         [_toast removeFromSuperview];
                         _toast = nil;
                     }
     ];
}

@end
