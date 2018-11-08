//
//  UIView+Extension.h
//  MeJob
//
//  Created by maopao-ios on 2017/10/25.
//  Copyright © 2017年 Mizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (assign ,nonatomic) CGFloat left;
@property (assign ,nonatomic) CGFloat top;
@property (assign ,nonatomic) CGFloat right;
@property (assign ,nonatomic) CGFloat bottom;
@property (assign ,nonatomic) CGFloat width;
@property (assign ,nonatomic) CGFloat height;
@property (assign ,nonatomic) IBInspectable CGFloat cornerRadius;
@property (assign, nonatomic) IBInspectable CGFloat borderWidth;
@property (strong, nonatomic) IBInspectable UIColor *borderColor;

/**
 获取xib的view
 */
+ (instancetype)xd_getFromXib;

- (UIViewController *)currentController;
@end
