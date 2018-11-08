//
//  NSString+Date.h
//  Xdpx
//
//  Created by apple on 2018/7/10.
//  Copyright © 2018年 XDPX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Date)

/**
 默认格式 yyyy-MM-dd HH:mm:ss
 */
- (NSDate *)toDate;
- (NSDate *)toDate:(NSString *)formatter;

+ (NSString *)showTimeWithTimeInterval:(NSTimeInterval)timeInterval;
+ (NSString *)showNormalTime:(NSTimeInterval)timeInterval;

/// 显示最后活跃时间
+ (NSString *)xd_showActivityTime:(NSTimeInterval)time;
@end
