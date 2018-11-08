//
//  UIControl+Event.h
//  mapgo
//
//  Created by maopao-ios on 2017/8/16.
//  Copyright © 2017年 Aladdin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (Event)
- (void)addClick:(dispatch_block_t)callback;
- (void)addEvent:(UIControlEvents)event callback:(dispatch_block_t)callback;
- (void)addEvent:(UIControlEvents)event handler:(void(^)(id sender))handler;
@end
