//
//  MyClass.h
//  DHTInterviewDemo
//
//  Created by happyo on 16/5/8.
//  Copyright © 2016年 happyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, copy) NSString *string;

- (void)methodOne;

- (void)methodTwo;

+ (void)classMethodOne;

@end
