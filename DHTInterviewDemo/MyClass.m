//
//  MyClass.m
//  DHTInterviewDemo
//
//  Created by happyo on 16/5/8.
//  Copyright © 2016年 happyo. All rights reserved.
//

#import "MyClass.h"


@interface MyClass () {
    
    NSInteger _instanceOne;
    
    NSString *_instanceTwo;
    
}

@property (nonatomic, assign) NSUInteger integer;

- (void)methodThreeWithArgOne:(NSInteger)argOne argTwo:(NSString *)argTwo;

@end
@implementation MyClass

- (void)methodOne
{
    NSLog(@"Call method one");
}

- (void)methodTwo
{
    
}

- (void)methodThreeWithArgOne:(NSInteger)argOne argTwo:(NSString *)argTwo
{
    NSLog(@"argOne : %ld, argTwo : %@", argOne, argTwo);
}

+ (void)classMethodOne
{
    
}


@end
