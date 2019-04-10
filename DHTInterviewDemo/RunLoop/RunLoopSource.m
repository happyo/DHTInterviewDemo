//
//  RunLoopSource.m
//  DHTInterviewDemo
//
//  Created by happyo on 2019/4/10.
//  Copyright © 2019 happyo. All rights reserved.
//

#import "RunLoopSource.h"
#import "RunLoopContext.h"
#import "AppDelegate.h"

@implementation RunLoopSource

- (id)init
{
    CFRunLoopSourceContext context = {0, (__bridge void *)(self), NULL, NULL, NULL, NULL, NULL,
        &RunLoopSourceScheduleRoutine,
        RunLoopSourceCancelRoutine,
        RunLoopSourcePerformRoutine
    };
    
    runLoopSource = CFRunLoopSourceCreate(NULL, 0, &context);
    commands = [[NSMutableArray alloc] init];
    
    return self;
}

- (void)addToCurrentRunLoop
{
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFRunLoopAddSource(runLoop, runLoopSource, kCFRunLoopDefaultMode);
}

- (void)fireAllCommandsOnRunLoop:(CFRunLoopRef)runloop
{
    CFRunLoopSourceSignal(runLoopSource);
    CFRunLoopWakeUp(runloop);
}

#pragma mark -- These are the CFRunLoopSourceRef callback functions --

void RunLoopSourceScheduleRoutine (void *info, CFRunLoopRef rl, CFStringRef mode)
{
    RunLoopSource *obj = (__bridge RunLoopSource *)info;
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    RunLoopContext *theContext = [[RunLoopContext alloc] initWithSource:obj andLoop:rl];
    
    [del performSelectorOnMainThread:@selector(registerSource:) withObject:theContext waitUntilDone:NO];
}

void RunLoopSourcePerformRoutine (void *info)
{
    RunLoopSource *obj = (__bridge RunLoopSource *)info;
    [obj sourceFired];
}

void RunLoopSourceCancelRoutine (void *info, CFRunLoopRef rl, CFStringRef mode)
{
    RunLoopSource *obj = (__bridge RunLoopSource *)info;
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    RunLoopContext *theContext = [[RunLoopContext alloc] initWithSource:obj andLoop:rl];
    [del performSelectorOnMainThread:@selector(removeSource:) withObject:theContext waitUntilDone:YES];
}

@end
