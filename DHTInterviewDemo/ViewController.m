//
//  ViewController.m
//  DHTInterviewDemo
//
//  Created by happyo on 16/1/15.
//  Copyright © 2016年 happyo. All rights reserved.
//

#import "ViewController.h"

typedef struct{
    char *title;
    char *message;
    char *cancelBtnTitle;
} AlertViewData;

@interface ViewController () <UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor redColor];
    
    __block int i = 0;
    
    void (^haha)(void) = ^() {
        i = 1;
    };
    
    void (^other)(void) = ^() {
        i = 2;
    };
    
    haha();
    other();
    
    NSLog(@"%i", i);
    
    
    
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:webView];
//    webView.backgroundColor = [UIColor blueColor];
//    webView.scalesPageToFit = YES;
//    webView.delegate = self;
//    
////    [webView loadHTMLString:@"<strong>hello world</strong>" baseURL:nil];
//    
//    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    [webView loadRequest:request];
    
    
//    dispatch_queue_t mainQueue = dispatch_get_main_queue();
//    dispatch_async(mainQueue, ^{
//        NSLog(@"hello");
//    });
    
//    AlertViewData *alertViewData = (AlertViewData *)malloc(sizeof(AlertViewData));
//    alertViewData->title = "haha";
//
//    dispatch_async_f(dispatch_get_main_queue(), (void *)alertViewData, displayData);
    
//    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//
//    void (^printHandle)() = ^(){
//        for (int i = 1; i <= 100; i++) {
//            NSLog(@"%i thread :%@", i, [NSThread currentThread]);
//        }
//    };
//    dispatch_sync(concurrentQueue, printHandle);
//    dispatch_sync(concurrentQueue, printHandle);
}


#pragma mark -- hha --
//
//- (void)webViewDidStartLoad:(UIWebView *)webView
//{
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
//}
//
//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//}
//
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
//{
//    NSLog(@"%@", error);
//}

void displayData(void *paramContext){
    AlertViewData *alertViewData = (AlertViewData *)paramContext;
    NSLog(@"%@", [NSString stringWithUTF8String:alertViewData->title]);
    
    free(alertViewData);
}

void printFrom1To100(void *paramContext){
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
