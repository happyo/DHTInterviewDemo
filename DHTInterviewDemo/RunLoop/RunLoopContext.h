//
//  RunLoopContext.h
//  DHTInterviewDemo
//
//  Created by happyo on 2019/4/10.
//  Copyright © 2019 happyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RunLoopSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface RunLoopContext : NSObject
{
    CFRunLoopRef runLoop;
    RunLoopSource *source;
}

@property (readonly) CFRunLoopRef runLoop;

@property (readonly) RunLoopSource *source;

- (id)initWithSource:(RunLoopSource *)source andLoop:(CFRunLoopRef)loop;

@end

NS_ASSUME_NONNULL_END
