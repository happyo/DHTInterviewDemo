//
//  DHTRuntimeMethodHelper.m
//  DHTInterviewDemo
//
//  Created by happyo on 16/5/23.
//  Copyright © 2016年 happyo. All rights reserved.
//

#import "DHTRuntimeMethodHelper.h"

@implementation DHTRuntimeMethodHelper

- (void)methodBackup
{
    NSLog(@"%@, %p", self, _cmd);
}

@end
