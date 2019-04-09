//
//  DHTRunLoopViewController.m
//  DHTInterviewDemo
//
//  Created by happyo on 2019/4/9.
//  Copyright © 2019 happyo. All rights reserved.
//

#import "DHTRunLoopViewController.h"

@interface DHTRunLoopViewController ()

@end

@implementation DHTRunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self threadMain];
}

// Creating a run loop observer
- (void)threadMain
{
    NSRunLoop *myRunLoop = [NSRunLoop currentRunLoop];
    
    // Create a run loop observer and attach it to the run loop
    CFRunLoopObserverContext context = {0, (__bridge void *)(self), NULL, NULL, NULL};
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, &myRunLoopObserver, &context);
    
    if (observer) {
        CFRunLoopRef cfLoop = [myRunLoop getCFRunLoop];
        CFRunLoopAddObserver(cfLoop, observer, kCFRunLoopDefaultMode);
    }
    
    // Create and schedule the timer
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(doFireTimer:) userInfo:nil repeats:YES];
    
    NSInteger loopCount = 10;
    
    do
    {
        // Run the run loop 10 times to let the timer fire.
        [myRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
        loopCount--;
    }
    while (loopCount);
}

- (void)doFireTimer:(NSTimer *)timer
{
    NSLog(@"timer");
}

void myRunLoopObserver(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
    NSLog(@"ob");
}



@end
