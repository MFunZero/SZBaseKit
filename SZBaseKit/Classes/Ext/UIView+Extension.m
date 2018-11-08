//
//  UIView+Extension.m
//  MeJob
//
//  Created by maopao-ios on 2017/10/25.
//  Copyright © 2017年 Mizhi. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
- (void)setLeft:(CGFloat)left {
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}
- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setTop:(CGFloat)top {
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}
- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}
- (CGFloat)right {
    CGRect frame = self.frame;
    return frame.origin.x + frame.size.width;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}
- (CGFloat)bottom {
    CGRect frame = self.frame;
    return frame.origin.y + frame.size.height;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}
- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}
- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}
- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

+ (instancetype)xd_getFromXib {
    NSString *nibName = NSStringFromClass([self class]);
    NSArray *list = [[NSBundle bundleForClass:[self class]] loadNibNamed:nibName owner:nil options:nil];
    for (id item in list) {
        if ([item isKindOfClass:[self class]]) {
            return item;
        }
    }
    NSAssert(NO, @"没有找到'%@'对应的xib",nibName);
    return nil;
}

- (UIViewController *)currentController{
    UIResponder *nextResponder = self.nextResponder;
    while (nextResponder != nil) {
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            break;
        }
        nextResponder = nextResponder.nextResponder;
    }
    return (UIViewController *)nextResponder;
}
@end
