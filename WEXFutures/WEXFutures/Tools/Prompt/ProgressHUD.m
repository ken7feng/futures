//
//  ProgressHUD.m
//  SH-WEX-BASE
//
//  Created by K on 2017/5/25.
//  Copyright © 2017年 Last Order. All rights reserved.
//

#import "ProgressHUD.h"
#import "ProgressView.h"
#import "AFNetworking.h"

static float const xMargin = 10;
#define close_btn_width          40
#define close_btn_height         40
float Degrees2Radians(float degrees) { return degrees * M_PI / 180; }

@interface ProgressHUD () {
    NSInteger   _animationIndex;
}

@property (nonatomic, strong) UIView            *hudView;
@property (nonatomic, strong) ProgressView    *progressView;
@property (nonatomic, weak) UILabel             *stringLabel;
@property (nonatomic, weak) UIButton            *closeBtn;
@property (nonatomic, strong) NSArray           *ringsColor;
@property (nonatomic, strong) NSArray           *shapeLayers;

@end

@implementation ProgressHUD
{
    CGFloat viewWidth;
    CGFloat viewHeight;
}
- (void)dealloc {
    [self unregisterKVO];
}

- (id)initWithView:(UIView *)view {
    return [self initWithFrame:view.bounds];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 0.0;
        self.backgroundColor = ClearColor;
        viewWidth = frame.size.width;
        viewHeight = frame.size.height;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        if ([UIDevice currentDevice].userInterfaceIdiom != UIUserInterfaceIdiomPad) {
            _diameter = 10.0;
        } else {
            _diameter = 12.0;
        }
        [self initSubviews];
        [self registerKVO];
        self.type = ProgressHUDTypeDarkForground;
        self.shape = ProgressHUDShapeLinear;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layout];
}

- (void)layout {
    CGFloat hudWidth;
    CGFloat hudHeight;
    
    hudWidth = [SizeUtil dimenSize] * 120.0;
    hudHeight = [SizeUtil dimenSize] * 120.0;
    
    self.hudView.frame = CGRectMake((CGRectGetWidth(self.bounds)-hudWidth)*0.5, (CGRectGetHeight(self.bounds)-hudHeight)*0.5, hudWidth, hudHeight);
    if (_shape == ProgressHUDShapeLinear) {
        self.stringLabel.frame = CGRectMake([SizeUtil dimenSize]*xMargin, [SizeUtil dimenSize] * 84, CGRectGetWidth(_hudView.bounds)-xMargin * 2, [SizeUtil dimenSize] * 16);
    } else {
        self.stringLabel.frame = CGRectMake([SizeUtil dimenSize]*xMargin, CGRectGetHeight(_hudView.bounds) - 20, CGRectGetWidth(_hudView.bounds)-xMargin * 2, [SizeUtil dimenSize] * 16);
    }
}

#pragma mark - init Method
- (void)initSubviews {
    
    NSArray *colors = @[
                        [UIColor purpleColor],
                        [UIColor orangeColor],
                        [UIColor cyanColor],
                        [UIColor redColor],
                        [UIColor greenColor],
                        [UIColor yellowColor]
                        ];
    _progressView= [[ProgressView alloc] initWithFrame:CGRectMake([SizeUtil dimenSize] * 34, [SizeUtil dimenSize] * 16,[SizeUtil dimenSize] * 52, [SizeUtil dimenSize] * 52) andLineWidth:2.0 andLineColor:colors];
    
    _hudView = [[UIView alloc]init];
    [self addSubview:_hudView];
    [_hudView addSubview:_progressView];
    
    UILabel *stringLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    stringLabel.backgroundColor = ClearColor;
    stringLabel.font = [UIFont systemFontOfSize:16.0f];
    stringLabel.textColor = UIColorFromRGB(0x333333);
    stringLabel.textAlignment = NSTextAlignmentCenter;
    self.stringLabel = stringLabel;
    [self.hudView addSubview:_stringLabel];
    
    CGFloat hudWidth;
    CGFloat hudHeight;
    
    hudWidth = [SizeUtil dimenSize] * 120.0;
    hudHeight = [SizeUtil dimenSize] * 120.0;
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.bounds)-hudWidth)*0.5 + hudWidth - close_btn_width / 2, (CGRectGetHeight(self.bounds)-hudHeight)*0.5 - close_btn_height / 2, close_btn_width, close_btn_height)];
    [button setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancelNetworkAndHidLoading) forControlEvents:UIControlEventTouchUpInside];
    self.closeBtn = button;
    [self addSubview:_closeBtn];
}

- (void)registerKVO {
    for (NSString *keyPath in [self observableKeypaths]) {
        [self addObserver:self
               forKeyPath:keyPath
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
    }
}

- (void)unregisterKVO {
    for (NSString *keyPath in [self observableKeypaths]) {
        [self removeObserver:self forKeyPath:keyPath];
    }
}

- (NSArray *)observableKeypaths {
    return @[@"text", @"shape", @"type"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"text"]) {
        self.stringLabel.text = self.text;
    } else if ([keyPath isEqualToString:@"type"]) {
        if (_type == ProgressHUDTypeDarkBackground) {
            self.backgroundColor = ClearColor;
            _hudView.backgroundColor = [UIColorFromRGB(0xf1f1f1)  colorWithAlphaComponent:0.9f];
            _hudView.layer.cornerRadius =8;
            
            
        } else {
            self.backgroundColor = ClearColor;
            _hudView.backgroundColor = [UIColorFromRGB(0xf1f1f1)  colorWithAlphaComponent:0.9f];
            _hudView.layer.cornerRadius =8;
        }
    } else if ([keyPath isEqualToString:@"shape"]) {
        
    }
    [self setNeedsDisplay];
}

#pragma mark - Show/Dismiss Method

- (void)show{
    [self layout];
    for (CAShapeLayer *layer in _shapeLayers) {
        [_hudView.layer addSublayer:layer];
        self.backgroundColor = ClearColor;
        _hudView.backgroundColor = [UIColorFromRGB(0xf1f1f1)  colorWithAlphaComponent:0.9f];
        _hudView.layer.cornerRadius =8;
        
    }
    if (_type == ProgressHUDTypeDarkBackground) {
    } else {
        self.backgroundColor = ClearColor;
        _hudView.backgroundColor = [UIColorFromRGB(0xf1f1f1)  colorWithAlphaComponent:0.9f];
        _hudView.layer.cornerRadius =8;
        
        
    }
    self.alpha = 1.0f;
}

- (void)dismiss {
    [self removeFromSuperview];
}

- (void)cancelNetworkAndHidLoading
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager.operationQueue cancelAllOperations];
    [self dismiss];
}


@end
