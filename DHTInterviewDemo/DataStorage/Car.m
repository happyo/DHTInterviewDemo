//
//  Car.m
//  DHTInterviewDemo
//
//  Created by happyo on 16/1/18.
//  Copyright © 2016年 happyo. All rights reserved.
//

#import "Car.h"

@implementation Car

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.speed forKey:@"speed"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.speed = [aDecoder decodeIntegerForKey:@"speed"];
    
    return self;
}

@end
