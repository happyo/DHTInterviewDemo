//
//  RunLoopSource.h
//  DHTInterviewDemo
//
//  Created by happyo on 2019/4/10.
//  Copyright © 2019 happyo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RunLoopSource : NSObject
{
    CFRunLoopSourceRef runLoopSource;
    NSMutableArray *commands;
}

- (id)init;

- (void)addToCurrentRunLoop;

- (void)invalidate;

// Handler method
- (void)sourceFired;

// Client interface for registering commands to process
- (void)addCommand:(NSInteger)command withData:(id)data;

- (void)fireAllCommandsOnRunLoop:(CFRunLoopRef)runloop;

@end

NS_ASSUME_NONNULL_END
