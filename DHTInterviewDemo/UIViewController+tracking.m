//
//  UIViewController+tracking.m
//  DHTInterviewDemo
//
//  Created by happyo on 16/5/23.
//  Copyright © 2016年 happyo. All rights reserved.
//

#import "UIViewController+tracking.h"
#import <objc/runtime.h>

@implementation UIViewController (Tracking)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = [self class];
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(DHT_viewWillAppear:);
        
        Method originalMethod = class_getInstanceMethod(cls, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);

        BOOL didAddMethod = class_addMethod(cls, swizzledSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

#pragma mark -- Method Swizzling --

- (void)DHT_viewWillAppear:(BOOL)animated
{
    [self DHT_viewWillAppear:animated];
    NSLog(@"view will appear : %@", self);
}

@end
