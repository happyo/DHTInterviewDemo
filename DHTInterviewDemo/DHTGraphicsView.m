//
//  DHTGraphicsView.m
//  DHTInterviewDemo
//
//  Created by happyo on 16/1/19.
//  Copyright © 2016年 happyo. All rights reserved.
//

#import "DHTGraphicsView.h"

@implementation DHTGraphicsView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    // Enumerating and loading fonts
    [self printFonts];
    
}

#pragma mark -- Private Methods --

- (void)printFonts
{
    for (NSString *familyName in [UIFont familyNames]) {
        NSLog(@"Font Family : %@", familyName);
        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
            NSLog(@"\t%@", fontName);
        }
    }
}

@end
