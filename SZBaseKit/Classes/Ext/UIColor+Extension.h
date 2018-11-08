//
//  UIColor+Extension.h
//  MeJob
//
//  Created by maopao-ios on 2017/8/28.
//  Copyright © 2017年 Mizhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kCOLOR_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define kCOLOR_RGB(r,g,b) kCOLOR_RGBA(r,g,b,1)
#define kCOLOR(hex) [UIColor colorWithHexString:hex]
@interface UIColor (Extension)
+ (UIColor *)colorWithHexString:(NSString *)hexColorString;
+ (UIColor *)colorWithHexString:(NSString *)hexColorString alpha:(CGFloat)alpha;

/// 通用背景色
+ (UIColor *)commonBGColor;

@end
