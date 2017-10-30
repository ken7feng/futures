//
//  UIFont+Ext.h
//  WEXWineMall
//
//  Created by K on 2017/7/21.
//  Copyright © 2017年 K. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Ext)

@property(nonatomic, assign) CGSize fontSize;

+(UIFont*)getFontWithFontName:(NSString*)fontName displayStr:(NSString*)string fontSize:(CGFloat)size;

@end
