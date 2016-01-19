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
//    [self printFonts];
    
    // Drawing text
//    [self drawText];
    
    // Constructing, setting and using colors
//    [self drawTextWithColor];
    
    // Print color components
//    [self printColorComponents];
    
    // Drawing images
    [self drawImages];
}

#pragma mark -- Private Methods --

- (void)drawImages
{
    UIImage *image = [UIImage imageNamed:@"album_add_icon"];
    
    [image drawAtPoint:CGPointMake(40, 40)];
    
    [image drawInRect:CGRectMake(100, 100, 50, 20)];
}

- (void)printColorComponents
{
    UIColor *red = [UIColor redColor];
    CGColorRef redColorRef = red.CGColor;
    
    const CGFloat *components = CGColorGetComponents(redColorRef);
    NSInteger componentsCount = CGColorGetNumberOfComponents(redColorRef);
    
    for (int i = 0; i < componentsCount; i++) {
        NSLog(@"component %i : %0.2f", i, components[i]);
    }
}

- (void)drawTextWithColor
{
    // set color in graphical context
    UIColor *magentaColor = [UIColor colorWithRed:0.5f green:0.0f blue:0.5f alpha:1.0f];
    
    UIFont *helveticaBold = [UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0f];

    NSString *colorfulStr = @"I learn really fast";
    
    [colorfulStr drawWithRect:CGRectMake(100, 120, 100, 200)
                      options:NSStringDrawingUsesLineFragmentOrigin
                   attributes:@{NSFontAttributeName : helveticaBold, NSForegroundColorAttributeName : magentaColor}
                      context:nil];
}

- (void)drawText
{
    UIFont *helveticaBold = [UIFont fontWithName:@"HelveticaNeue-Bold" size:40.0f];
    
    NSString *someStr = @"Some String";
    
    [someStr drawAtPoint:CGPointMake(40, 180)
          withAttributes:@{NSFontAttributeName : helveticaBold}];
    
}

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
