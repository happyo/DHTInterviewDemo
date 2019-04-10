//
//  DHTRunLoopViewController.m
//  DHTInterviewDemo
//
//  Created by happyo on 2019/4/9.
//  Copyright © 2019 happyo. All rights reserved.
//

#import "DHTRunLoopViewController.h"
#import "RunLoopSource.h"
#import "RunLoopContext.h"
#import "AppDelegate.h"

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

// Running a run loop
- (void)skeletonThreadMain
{
    // Set up an autorelease pool here if not using garbage collection.
    BOOL done = NO;
    
    // Add your sources or timers to the run loop and do any other setup
    
    do
    {
        // Start the run loop but return after each source is handled
        SInt32 result = CFRunLoopRunInMode(kCFRunLoopDefaultMode, 10, YES);
        
        // If a source explicitly stopped the run loop, or if there are no sources or timers, go ahead and exit.
        if ((result == kCFRunLoopRunStopped) || (result == kCFRunLoopRunFinished)) {
            done = YES;
            
            // Check for any other exit conditions here and set the done variable as needed.
        }
    }
    while (!done);
    
    // Clean up code here. Be sure to release any allocated autorelease pools.
}



@end
