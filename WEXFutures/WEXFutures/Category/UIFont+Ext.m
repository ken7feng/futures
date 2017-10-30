//
//  UIFont+Ext.m
//  WEXWineMall
//
//  Created by K on 2017/7/21.
//  Copyright © 2017年 K. All rights reserved.
//

#import "UIFont+Ext.h"
#import "objc/runtime.h"

static char* sizeWidthKey = "sizeWidth";
static char* sizeHeightKey = "sizeHeightKey";

@implementation UIFont (Ext)

-(void)setFontSize:(CGSize)fontSize
{
    objc_setAssociatedObject(self, sizeWidthKey, [NSNumber numberWithDouble:fontSize.width], OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, sizeHeightKey, [NSNumber numberWithDouble:fontSize.height], OBJC_ASSOCIATION_RETAIN);
}

-(CGSize)fontSize
{
    NSNumber* sizeWidth = objc_getAssociatedObject(self, sizeWidthKey);
    NSNumber* sizeHeight = objc_getAssociatedObject(self, sizeHeightKey);
    
    CGSize tempSize;
    tempSize.width = [sizeWidth doubleValue];
    tempSize.height = [sizeHeight doubleValue];
    return tempSize;
}



+(UIFont*)getFontWithFontName:(NSString*)fontName displayStr:(NSString*)string fontSize:(CGFloat)size
{
    UIFont * titleFont = nil;
    NSString* _tempName = nil;
    if (fontName == nil) {
        _tempName = @"Helvetica";
    }
    else
    {
        _tempName = fontName;
    }
    
    if (size < 0.001) {
        size = 17.0f;
    }
    titleFont = [UIFont fontWithName:_tempName size:size];
    CGSize titleSize;
    
    if (string == nil) {
        titleSize.height = 0;
        titleSize.width = 0;
    }
    else
    {
        // if (SYSTEM_VERSION >= 7.0)
        {
            titleSize = [string sizeWithAttributes: @{NSFontAttributeName: titleFont}];
            //   titleSize = [string boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:titleFont,NSFontAttributeName, nil] context:nil].size;
        }
        
    }
    
    titleFont.fontSize = titleSize;
    
    return titleFont;
}

@end
