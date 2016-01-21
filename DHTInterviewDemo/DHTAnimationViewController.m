//
//  DHTAnimationViewController.m
//  DHTInterviewDemo
//
//  Created by happyo on 16/1/21.
//  Copyright © 2016年 happyo. All rights reserved.
//

#import "DHTAnimationViewController.h"

@interface DHTAnimationViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation DHTAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    [self configureImageView];
    
    // Animating and moving views
//    [self moveViews];
    
    // Animating and scaling views
//    [self scaleViews];
    
    // Animating and rotating views
//    [self rotateViews];
    
    // Capturing a screenshot of your view into an image
    [self captureScreenshot];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Private Methods --

- (void)captureScreenshot
{
    UIGraphicsBeginImageContext(self.view.bounds.size);
    
    [self.view drawViewHierarchyInRect:self.view.frame afterScreenUpdates:NO];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    NSLog(@"%@", image);
}


- (void)rotateViews
{
    //    [UIView beginAnimations:@"imageViewScaleAnimation" context:(__bridge void *)self.imageView];
    //
    //    [UIView setAnimationDuration:5.0f];
    //
    //    [UIView setAnimationDelegate:self];
    //
    //    [UIView setAnimationDidStopSelector:@selector(imageViewDidStop:finished:context:)];
    //
//        self.imageView.transform = CGAffineTransformMakeRotation((10.0 * M_PI) / 180.0);
    //
    //    [UIView commitAnimations];
    
    [UIView animateWithDuration:5.0f animations:^{
        self.imageView.transform = CGAffineTransformMakeRotation((45.0 * M_PI) / 180.0);
    }];
}

- (void)scaleViews
{
//    [UIView beginAnimations:@"imageViewScaleAnimation" context:(__bridge void *)self.imageView];
//    
//    [UIView setAnimationDuration:5.0f];
//    
//    [UIView setAnimationDelegate:self];
//    
//    [UIView setAnimationDidStopSelector:@selector(imageViewDidStop:finished:context:)];
//    
//    self.imageView.transform = CGAffineTransformMakeScale(2, 2);
//    
//    [UIView commitAnimations];
    
    [UIView animateWithDuration:5.0f animations:^{
        self.imageView.transform = CGAffineTransformMakeScale(2, 2);
    }];
}

- (void)moveViews
{
//    [UIView beginAnimations:@"imageViewAnimation" context:(__bridge void *)self.imageView];
//    
//    [UIView setAnimationDuration:5.0f];
//    
//    [UIView setAnimationDelegate:self];
//    
//    [UIView setAnimationDidStopSelector:@selector(imageViewDidStop:finished:context:)];
//    
//    CGRect endRect = CGRectMake(100, 500, 50, 50);
//    
//    [self.imageView setFrame:endRect];
//    
//    [UIView commitAnimations];
    
    [UIView animateWithDuration:5.0f animations:^{
        CGRect endRect = CGRectMake(100, 500, 50, 50);
        [self.imageView setFrame:endRect];
    }];
}

- (void)imageViewDidStop:(NSString *)paramAnimationID
                finished:(NSNumber *)paramFinished
                 context:(void *)paramContext{
    NSLog(@"Animation finished.");
    NSLog(@"Animation ID = %@", paramAnimationID);
    UIImageView *contextImageView = (__bridge UIImageView *)paramContext;
    NSLog(@"Image View = %@", contextImageView);
}
- (void)configureImageView
{
    UIImage *image = [UIImage imageNamed:@"album_add_icon"];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 60, 30, 30)];
    self.imageView.image = image;
    
    [self.view addSubview:self.imageView];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
