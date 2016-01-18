//
//  DHTCustomOperation.m
//  DHTInterviewDemo
//
//  Created by happyo on 16/1/17.
//  Copyright © 2016年 happyo. All rights reserved.
//

#import "DHTCustomOperation.h"
#import <UIKit/UIKit.h>

@implementation DHTCustomOperation

- (void) main
{
    @autoreleasepool {
        NSString *imageUrlStr = @"http://cl.ly/020Z312W233b/download/Image%202016-01-12%20at%205.08.18%20%E4%B8%8B%E5%8D%88.png";
        NSURL *imageUrl = [NSURL URLWithString:imageUrlStr];
        
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:imageUrl];
        
        NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error == nil && data != nil) {
                UIImage *image = [UIImage imageWithData:data];
                NSLog(@"%@", image);
            }
        }];
        
        [dataTask resume];
        
//        for (int i = 1; i < 100; i++) {
//            NSLog(@"%i", i);
//        }
    }
    
}

@end
