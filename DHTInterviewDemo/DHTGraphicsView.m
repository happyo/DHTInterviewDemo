//
//  DHTGraphicsView.m
//  DHTInterviewDemo
//
//  Created by happyo on 16/1/19.
//  Copyright © 2016年 happyo. All rights reserved.
//

#import "DHTGraphicsView.h"

@interface DHTGraphicsView ()

@property (nonatomic, strong) UIButton *button;

@end
@implementation DHTGraphicsView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    // Enumerating and loading fonts
//    [self printFonts];
    
    // Constructing resizable images
//    [self drawResizableImages];
    
    // Drawing lines
//    [self drawLines];
    
    // Compare line join type
//    [self compareJoinType];
    
    // Contructing paths
//    [self constructPath];
    
    // Drawing rectangles
//    [self drawRectangles];
    
    // Adding shadows to shapes
//    [self addShadows];
    
    // Save and restore context state
//    [self contextState];
    
    // Drawing gradients
    [self drawGradients];
}

#pragma mark -- Private Methods --

- (void)drawGradients
{
    CGContextRef cureentContext = UIGraphicsGetCurrentContext();
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    UIColor *startColor = [UIColor blueColor];
    CGFloat *startColorComponents = (CGFloat *)CGColorGetComponents(startColor.CGColor);
    
    UIColor *endColor = [UIColor greenColor];
    CGFloat *endColorComponents = (CGFloat *)CGColorGetComponents(endColor.CGColor);
    
    CGFloat colorComponents[8] = {
        
        startColorComponents[0],
        startColorComponents[1],
        startColorComponents[2],
        startColorComponents[3],
        
        endColorComponents[0],
        endColorComponents[1],
        endColorComponents[2],
        endColorComponents[3],
    };
    
    CGFloat colorIndices[2] = {
        0.0f,
        1.0f,
    };
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, (const CGFloat *)&colorComponents, (const CGFloat *)&colorIndices, 2);
    
    CGPoint startPoint = CGPointMake(0, 50);
    CGPoint endPoint = CGPointMake(0, 200);
    
    CGContextDrawLinearGradient(cureentContext, gradient, startPoint, endPoint, 0);
    
    CGGradientRelease(gradient);
    
}

- (void)contextState
{
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(currentContext);
    
    [[UIColor yellowColor] set];
    
    CGContextMoveToPoint(currentContext, 50, 50);
    
    CGContextAddLineToPoint(currentContext, 50, 100);
    
    CGContextStrokePath(currentContext);
    
    [[UIColor blueColor] set];
    
    CGContextMoveToPoint(currentContext, 100, 50);
    
    CGContextAddLineToPoint(currentContext, 100, 100);
    
    CGContextStrokePath(currentContext);
    
    CGContextRestoreGState(currentContext);

}

- (void)addShadows
{
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetShadowWithColor(currentContext, CGSizeMake(10, 10), 20, [UIColor grayColor].CGColor);
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGRect retangleRect = CGRectMake(50, 50, 100, 100);
    
    CGPathAddRect(path, NULL, retangleRect);
    
    [[UIColor blueColor] set];
    
    CGContextAddPath(currentContext, path);
    
    CGContextDrawPath(currentContext, kCGPathFill);
    
    CGPathRelease(path);
}

- (void)drawRectangles
{
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGRect rectangleRect = CGRectMake(50, 50, 200, 200);
    
    CGRect rectangleRect1 = CGRectMake(50, 300, 200, 200);
    
    CGRect rectangleRect2 = CGRectMake(50, 550, 200, 50);
    
    CGRect rectangles[2] = {rectangleRect1, rectangleRect2};
    
    CGPathAddRects(path, NULL, (const CGRect *)&rectangles, 2);
    
    CGPathAddRect(path, NULL, rectangleRect);
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextAddPath(currentContext, path);
    
    CGContextSetLineWidth(currentContext, 10);
    
    [[UIColor yellowColor] setFill];
    
    [[UIColor blueColor] setStroke];
    
    CGContextDrawPath(currentContext, kCGPathFillStroke);
    
    CGPathRelease(path);
}

- (void)constructPath
{
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, 0, 0);
    
    CGPathAddLineToPoint(path, NULL, 300, 500);
    
    CGPathMoveToPoint(path, NULL, 300, 0);
    
    CGPathAddLineToPoint(path, NULL, 0, 500);
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextAddPath(currentContext, path);
    
    [[UIColor orangeColor] set];
    
    CGContextDrawPath(currentContext, kCGPathStroke);
    
    CGPathRelease(path);
}


- (void)compareJoinType
{
    [self drawAtPoint:CGPointMake(160, 50) text:@"miter" joinType:kCGLineJoinMiter];
    
    [self drawAtPoint:CGPointMake(160, 200) text:@"bevel" joinType:kCGLineJoinBevel];
    
    [self drawAtPoint:CGPointMake(160, 350) text:@"round" joinType:kCGLineJoinRound];
}

- (void)drawAtPoint:(CGPoint)point text:(NSString *)text joinType:(CGLineJoin)joinType
{
    [[UIColor yellowColor] set];
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(currentContext, 10);
    
    CGContextSetLineJoin(currentContext, joinType);
    
    CGContextMoveToPoint(currentContext, point.x - 60, point.y + 60);
    
    CGContextAddLineToPoint(currentContext, point.x, point.y);
    
    CGContextAddLineToPoint(currentContext, point.x + 60, point.y + 60);
    
    CGContextStrokePath(currentContext);
    
    CGPoint textPoint = CGPointMake(point.x - 40, point.y + 60);
    UIFont *font = [UIFont systemFontOfSize:40];
    [text drawAtPoint:textPoint withAttributes:@{NSFontAttributeName : font}];
}

- (void)drawLines
{
    [[UIColor blueColor] set];
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(currentContext, 2);
    
    CGContextMoveToPoint(currentContext, 60, 60);
    
    CGContextAddLineToPoint(currentContext, 60, 300);
    
    CGContextAddLineToPoint(currentContext, 300, 300);
    
    CGContextAddLineToPoint(currentContext, 60, 60);
    
    CGContextStrokePath(currentContext);
}

- (void)drawResizableImages
{
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setFrame:CGRectMake(50, 100, 200, 50)];
    
    [self.button setTitle:@"Stretched image on button" forState:UIControlStateNormal];
    
    self.button.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    
    UIImage *image = [UIImage imageNamed:@"album_add_icon"];
    UIEdgeInsets edgeInsets;
    edgeInsets.left = 14.0f;
    edgeInsets.top = 0.0f;
    edgeInsets.right = 14.0f;
    edgeInsets.bottom = 0.0f;
    image = [image resizableImageWithCapInsets:edgeInsets];
    
    [self.button setBackgroundImage:image forState:UIControlStateNormal];
    
    [self addSubview:self.button];
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
