//
//  DHTRuntimeTestViewController.m
//  DHTInterviewDemo
//
//  Created by happyo on 16/5/6.
//  Copyright © 2016年 happyo. All rights reserved.
//

#import "DHTRuntimeTestViewController.h"
#import <objc/runtime.h>
#import "MyClass.h"
#import "DHTRuntimeMethodHelper.h"

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
    
//    [self logClassIsaInfo];
    
//    [self logClassInfo];
    
    [self testMethodForwarding];
}

#pragma mark -- Class Methods --

//+ (BOOL)resolveInstanceMethod:(SEL)sel
//{
//    NSString *selName = NSStringFromSelector(sel);
//    
//    if ([selName isEqualToString:@"methodNotFound"]) {
//        class_addMethod(self, sel, (IMP)functionForMethodNotFound, "@:");
//    }
//    
//    return [super resolveInstanceMethod:sel];
//}



#pragma mark -- Method Forwarding --

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    
    if (!signature) {
        if ([DHTRuntimeMethodHelper instancesRespondToSelector:aSelector]) {
            signature = [DHTRuntimeMethodHelper instanceMethodSignatureForSelector:aSelector];
        }
    }
    
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    if ([DHTRuntimeMethodHelper instancesRespondToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:[[DHTRuntimeMethodHelper alloc] init]];
    }
}

//- (id)forwardingTargetForSelector:(SEL)aSelector
//{
//    NSString *selName = NSStringFromSelector(aSelector);
//    
//    if ([selName isEqualToString:@"methodBackup"]) {
//        return [[DHTRuntimeMethodHelper alloc] init];
//    }
//    
//    return [super forwardingTargetForSelector:aSelector];
//}
#pragma mark -- Private Methods --

void functionForMethodNotFound (id self, SEL _cmd)
{
    NSLog(@"%@, %p", self, _cmd);
}

- (void)testMethodForwarding
{
    // 动态方法解析
//    [self performSelector:@selector(methodNotFound)];
    
    // 备用接受者
//    [self performSelector:@selector(methodBackup)];
    
    // 完整消息转发
    [self performSelector:@selector(methodBackup)];
}

- (void)logClassInfo
{
    MyClass *myClass = [[MyClass alloc] init];
    
    Class cls = myClass.class;
    
    unsigned int outCount = 0;
    
    // 类名
    NSLog(@"class name : %s", class_getName(cls));
    
    
    // 父类
    NSLog(@"super class name : %s", class_getName(class_getSuperclass(cls)));
    
    
    // 是否是元类
    NSLog(@"MyClass is %@ a meta-class", class_isMetaClass(cls) ? @"" : @"not");
    
    
    Class metaClass = objc_getMetaClass(class_getName(cls));
    
    NSLog(@"%s's meta-class is %s", class_getName(cls), class_getName(metaClass));
    
    
    // 实例变量的大小
    NSLog(@"instance size is %zu", class_getInstanceSize(cls));
    
    
    // 成员变量
    Ivar *ivars = class_copyIvarList(cls, &outCount);
    
    for (int i = 0; i < outCount; i++) {
        
        Ivar ivar = ivars[i];
        
        NSLog(@"instance variable name : %s at index %d", ivar_getName(ivar), i);
        
    }
    
    free(ivars);
    
    
    objc_property_t array = class_getProperty(cls, "array");
    
    if (array != NULL) {
        NSLog(@"property %s", property_getName(array));
    }
    
    
    // 方法操作
    Method *methods = class_copyMethodList(cls, &outCount);
    
    for (int i = 0; i < outCount; i++) {
        
        Method method = methods[i];
        
        NSLog(@"method's signature : %s", sel_getName(method_getName(method)));
        
    }
    
    free(methods);
    
    
    Method methodOne = class_getInstanceMethod(cls, @selector(methodOne));
    
    if (methodOne != NULL) {
        
        NSLog(@"method %s", sel_getName(method_getName(methodOne)));
        
    }
    
    
    NSLog(@"MyClass is %@ response to selector : methodThreeWithArgOne:argTwo:", class_respondsToSelector(cls, @selector(methodThreeWithArgOne:argTwo:)) ? @"" : @"not");
    
    
    IMP impOne = method_getImplementation(methodOne);
    
    impOne();
    
    // 协议
    Protocol * __unsafe_unretained * protocols = class_copyProtocolList(cls, &outCount);
    
    Protocol *protocol;
    
    for (int i = 0; i < outCount; i++) {
        
        protocol = protocols[i];
        
        NSLog(@"protocol name : %s", protocol_getName(protocol));
        
    }
    
    NSLog(@"MyClass is %@ response to protocol %s ", class_conformsToProtocol(cls, protocol) ? @"" : @"not", protocol_getName(protocol));
    
    
    
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
