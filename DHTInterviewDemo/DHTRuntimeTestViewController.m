//
//  DHTRuntimeTestViewController.m
//  DHTInterviewDemo
//
//  Created by happyo on 16/5/6.
//  Copyright © 2016年 happyo. All rights reserved.
//

#import "DHTRuntimeTestViewController.h"
#import <objc/runtime.h>

void TestMetaClass(id self, SEL _cmd) {
    
    NSLog(@"This object is : %@", self);
    
    NSLog(@"Class is : %@, super class is : %@", [self class], [self superclass]);
    
    
    Class currentClass = [self class];
    
    for (int i = 0; i < 4; i++) {
        
        NSLog(@"Following the isa pointer %d times gives %p", i, currentClass);
        
        currentClass = objc_getClass((__bridge void *)currentClass);
    }
    
    
    NSLog(@"NSObject's class is %@", [NSObject class]);
    
    NSLog(@"NSObject's meta class is %p", objc_getClass((__bridge void *)[NSObject class]));
    
}

@implementation DHTRuntimeTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self logClassIsaInfo];
}


- (void)logClassIsaInfo
{
    Class newClass = objc_allocateClassPair([NSError class], "TestClass", 0);
    
    class_addMethod(newClass, @selector(testMetaClass), (IMP)TestMetaClass, "v@:");
    
    objc_registerClassPair(newClass);
    
    
    id instance = [[newClass alloc] initWithDomain:@"some domain" code:0 userInfo:nil];
    
    [instance performSelector:@selector(testMetaClass)];
}



@end
