//
//  WEXAlert.h
//  WEXFutures
//
//  Created by K on 2017/10/31.
//  Copyright © 2017年 K. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WEXAlert : UIView

- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)content
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rigthTitle
  contentCanClicked:(BOOL)bol;


- (void)show;

@property (nonatomic, copy) dispatch_block_t leftBlock;
@property (nonatomic, copy) dispatch_block_t rightBlock;
@property (nonatomic, copy) dispatch_block_t contentBlock;
@property (nonatomic, copy) dispatch_block_t dismissBlock;

@end

@interface UIImage (colorful)

+ (UIImage *)imageWithColor:(UIColor *)color;

@end
