//
//  UIControl+Event.m
//  mapgo
//
//  Created by maopao-ios on 2017/8/16.
//  Copyright © 2017年 Aladdin. All rights reserved.
//

#import "UIControl+Event.h"
#import <objc/runtime.h>
static char EventsMapKey;

@interface EventWrapper : NSObject
@property (assign ,nonatomic) UIControlEvents events;

@property (copy, nonatomic) void(^handler)(id sender);

- (instancetype)initWithHandler:(void(^)(id sender))handler
                         events:(UIControlEvents)events;
- (void)invoke:(id)sender;
@end

@implementation EventWrapper
- (instancetype)initWithHandler:(void (^)(id))handler events:(UIControlEvents)events {
    if (self = [super init]) {
        self.handler = handler;
        self.events = events;
    }
    return self;
}

- (void)invoke:(id)sender {
    __weak typeof(sender) weakSender = sender;
    if (self.handler) {
        self.handler(weakSender);
    }
}
@end

@implementation UIControl (Event)

- (NSMutableDictionary<NSString *,EventWrapper *> *)eventsMap {
    NSMutableDictionary *eventsMap = objc_getAssociatedObject(self, &EventsMapKey);
    if (eventsMap == nil) {
        eventsMap = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, &EventsMapKey, eventsMap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return eventsMap;
}
- (void)addClick:(dispatch_block_t)callback {
    [self addEvent:UIControlEventTouchUpInside callback:callback];
}

- (void)addDown:(dispatch_block_t)callback {
    [self addEvent:UIControlEventTouchDown callback:callback];
}
- (void)addEvent:(UIControlEvents)event handler:(void(^)(id sender))handler {
    NSString *eventsKey = [NSString stringWithFormat:@"%ld",event];
    EventWrapper *eventWrapper = [[self eventsMap] valueForKey:eventsKey];
    if (!eventWrapper) {
        eventWrapper = [[EventWrapper alloc] initWithHandler:handler events:event];
        [[self eventsMap] setValue:eventWrapper forKey:eventsKey];
    }else {
        // 更新事件行为
        eventWrapper.handler = handler;
    }
    [self addTarget:eventWrapper action:@selector(invoke:) forControlEvents:event];
}
- (void)addEvent:(UIControlEvents)event callback:(dispatch_block_t)callback {
    [self addEvent:event handler:^(id sender) {
        if (callback) {
            callback();
        }
    }];
}

@end
