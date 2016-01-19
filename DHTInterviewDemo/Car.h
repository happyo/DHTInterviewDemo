//
//  Car.h
//  DHTInterviewDemo
//
//  Created by happyo on 16/1/18.
//  Copyright © 2016年 happyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger speed;

@end
