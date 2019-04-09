//
//  DHTAsynchronouslyOperation.m
//  DHTInterviewDemo
//
//  Created by happyo on 16/1/17.
//  Copyright © 2016年 happyo. All rights reserved.
//

#import "DHTAsynchronouslyOperation.h"
#import <UIKit/UIKit.h>

@interface DHTAsynchronouslyOperation ()
{
    BOOL finished;
    BOOL executing;
}
@end
@implementation DHTAsynchronouslyOperation

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        finished = NO;
        executing = NO;
    }
    
    return self;
}

- (void)main
{
    @try {
        // do job here
        
        if ([self isCancelled]) {
            [self completeOperation];
            NSLog(@"1");
            return;
        }
        NSString *imageUrlStr = @"http://cl.ly/020Z312W233b/download/Image%202016-01-12%20at%205.08.18%20%E4%B8%8B%E5%8D%88.png";
        NSURL *imageUrl = [NSURL URLWithString:imageUrlStr];
        
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:imageUrl];
        if ([self isCancelled]) {
            [self completeOperation];
            NSLog(@"2");
            return;
        }
        NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if ([self isCancelled]) {
                [self completeOperation];
                NSLog(@"3");
                return;
            }
            if (error == nil && data != nil) {
                UIImage *image = [UIImage imageWithData:data];
                if ([self isCancelled]) {
                    [self completeOperation];
                    NSLog(@"4");
                    return;
                }
                NSLog(@"%@", image);
                
                [self completeOperation];
            }
        }];
        if ([self isCancelled]) {
            [self completeOperation];
            NSLog(@"5");
            return;
        }
        
        [dataTask resume];
    }
    @catch (NSException *exception) {
        //
    }
}

- (void)start
{
    if ([self isCancelled]) {
        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    
    
    [self willChangeValueForKey:@"isExecuting"];
    
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    
    executing = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)completeOperation
{
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    
    finished = YES;
    executing = NO;
    
    [self didChangeValueForKey:@"isFinished"];
    [self didChangeValueForKey:@"isExecuting"];
    
    NSLog(@"current%@", [NSThread currentThread]);
    NSLog(@"main%@", [NSThread mainThread]);
}

- (BOOL)isConcurrent
{
    return YES;
}

- (BOOL)isFinished
{
    return finished;
}

- (BOOL)isExecuting
{
    return executing;
}

@end
