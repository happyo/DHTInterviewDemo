//
//  DHTGCDViewController.m
//  DHTInterviewDemo
//
//  Created by happyo on 16/1/16.
//  Copyright © 2016年 happyo. All rights reserved.
//

#import "DHTGCDViewController.h"
#import "DHTCustomOperation.h"
#import "DHTAsynchronouslyOperation.h"

@interface DHTGCDViewController ()

@property (nonatomic, strong) NSOperation *simpleOepration;

@property (nonatomic, strong) NSOperationQueue *operationQueue;

@property (nonatomic, strong) NSOperation *firstOperation;

@property (nonatomic, strong) NSOperation *secondOperation;

@property (nonatomic, strong) NSTimer *printTimer;

@property (nonatomic, strong) NSThread *myThread;

@end

@implementation DHTGCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // download image with gcd
//    [self demo1];
    
    // Perform tasks after a delay with GCD
//    [self demo2];
    
    // Perform tasks only once with GCD
//    [self demo3];
    
    // Grouping tasks together with GCD
    // 如果在主线程中使用group async 还是会串行执行，在别的线程中会并发执行
//    [self demo4];
    
    // Constructing your own dispatch queues with GCD
//    [self demo5];
    
    // Running tasks synchronously with operation
//    [self demo6];
    
    // Running tasks asynchronously with operation
//    [self demo7];
    
    // Creating NSTimer
//    [self demo8];
    
    // Creating concurrency with threads
//    [self demo9];
    
    // Invoking background methods
//    [self demo10];
    
    // Exiting threads and timers
    [self demo11];
}

#pragma mark -- each demo --

- (void)demo1
{
    __block UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:imageView];
    
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(concurrentQueue, ^{
        __block UIImage *image = nil;
        
        dispatch_sync(concurrentQueue, ^{
            // download the image
            NSString *imageUrlStr = @"http://cl.ly/020Z312W233b/download/Image%202016-01-12%20at%205.08.18%20%E4%B8%8B%E5%8D%88.png";
            NSURL *imageUrl = [NSURL URLWithString:imageUrlStr];
            
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:imageUrl];
            
            NSURLSessionDataTask *imageTask = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (error == nil && data != nil) {
                    image = [UIImage imageWithData:data];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        imageView.image = image;
                    });
                }
            }];
            [imageTask resume];
            
        });
    });
}

- (void)demo2
{
    [self performSelector:@selector(printString:) withObject:@"hello world" afterDelay:3.0f];
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, 3.0 * NSEC_PER_SEC);
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        NSLog(@"hello");
    });
}

- (void)demo3
{
    static dispatch_once_t onceToken;
    static dispatch_once_t twiceToken;
    
    dispatch_once(&onceToken, onlyOnce);
    dispatch_once(&onceToken, onlyOnce);
    dispatch_once(&twiceToken, onlyOnce);
}

- (void)demo4
{
    dispatch_group_t taskGroup = dispatch_group_create();
//    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_async(taskGroup, concurrentQueue, ^{
        [self reloadTableView];
    });
    
    dispatch_group_async(taskGroup, concurrentQueue, ^{
        [self reloadScrollView];
    });
    
    dispatch_group_async(taskGroup, concurrentQueue, ^{
        [self reloadImageView];
    });
    
    dispatch_group_async_f(taskGroup, concurrentQueue, (__bridge void *)self, reloadAllViews);
    
    dispatch_group_notify(taskGroup, concurrentQueue, ^{
        NSLog(@"all task finished!");
    });
}

- (void)demo5
{
    dispatch_queue_t serialQueue = dispatch_queue_create("com.happyo.interview.firstSerialQueue", 0);
    dispatch_async(serialQueue, ^{
        NSLog(@"first");
    });
    
    dispatch_async(serialQueue, ^{
        NSLog(@"second");
    });
    
    dispatch_async(serialQueue, ^{
        NSLog(@"third");
    });
}

- (void)demo6
{
//    self.simpleOepration = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(printString:) object:@"invocation method"];
//    [self.simpleOepration start];
//    
//    self.simpleOepration = [NSBlockOperation blockOperationWithBlock:^{
//        for (int i = 1; i < 100; i++) {
//            NSLog(@"%i", i);
//        }
//    }];
//    [self.simpleOepration start];
//    
//    DHTCustomOperation *customOperation = [[DHTCustomOperation alloc] init];
//    [customOperation start];
    
    self.simpleOepration = [[DHTAsynchronouslyOperation alloc] init];
    [self.simpleOepration start];
//    [self.simpleOepration performSelector:@selector(cancel) withObject:nil afterDelay:0.5f];
    [self.simpleOepration cancel];
    
    NSLog(@"end");
    
}

- (void)demo7
{
    self.operationQueue = [[NSOperationQueue alloc] init];
    
    self.firstOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(firstPrint:) object:@"hello"];
    
    self.secondOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(secondPrint:) object:@"world"];
    
    [self.firstOperation addDependency:self.secondOperation];
    [self.operationQueue addOperation:self.firstOperation];
    [self.operationQueue addOperation:self.secondOperation];
    
//    self.operationQueue = [[NSOperationQueue alloc] init];
//    
//    self.firstOperation = [[DHTAsynchronouslyOperation alloc] init];
//    
//    self.secondOperation = [[DHTAsynchronouslyOperation alloc] init];
//    
//    
//    
//    [self.operationQueue addOperation:self.firstOperation];
//    [self.operationQueue addOperation:self.secondOperation];
    
    NSLog(@"main thread is here");
}

- (void)demo8
{
//    self.printTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(reloadTableView) userInfo:nil repeats:YES];
//    [self.printTimer performSelector:@selector(invalidate) withObject:nil afterDelay:3.0f];
    
//    self.printTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(reloadTableView) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:self.printTimer forMode:NSDefaultRunLoopMode];
//    [self.printTimer performSelector:@selector(invalidate) withObject:nil afterDelay:3.0f];
    
//    NSMethodSignature *methodSignature = [[self class] instanceMethodSignatureForSelector:@selector(reloadTableView)];
//    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
//    [invocation setTarget:self];
//    [invocation setSelector:@selector(reloadTableView)];
//    
//    self.printTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 invocation:invocation repeats:YES];
}

- (void)demo9
{
//    NSString *urlStr = @"http://cl.ly/020Z312W233b/download/Image%202016-01-12%20at%205.08.18%20%E4%B8%8B%E5%8D%88.png";
//    [NSThread detachNewThreadSelector:@selector(downloadWithUrl:) toTarget:self withObject:urlStr];
    
//    [NSThread detachNewThreadSelector:@selector(firstCounter) toTarget:self withObject:nil];
//    [NSThread detachNewThreadSelector:@selector(secondCounter) toTarget:self withObject:nil];
//    [self thirdCounter];
    
    [NSThread detachNewThreadSelector:@selector(testAutorelease:) toTarget:self withObject:self];
}

- (void)demo10
{
    [self performSelectorInBackground:@selector(firstCounter) withObject:nil];
    [self performSelectorInBackground:@selector(secondCounter) withObject:nil];
}

- (void)demo11
{
    NSString *urlStr = @"http://cl.ly/020Z312W233b/download/Image%202016-01-12%20at%205.08.18%20%E4%B8%8B%E5%8D%88.png";
    self.myThread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadWithUrl:) object:urlStr];
//    [self.myThread performSelector:@selector(cancel) withObject:nil afterDelay:1.0f];
    [self.myThread start];
}

#pragma mark -- hhaha --

- (void)testAutorelease:(id)paramSender
{
    @autoreleasepool {
        
        UIImage *image = [UIImage imageNamed:@"album_add_icon"];
        
        NSLog(@"%@", image);
    }
}

- (void)firstCounter
{
    @autoreleasepool {
        for (int i = 1; i < 100; i++) {
            NSLog(@"firstCounter%i", i);
            NSLog(@"current thread:%@", [NSThread currentThread]);
        }
    }
}

- (void)secondCounter
{
    @autoreleasepool {
        for (int i = 1; i < 100; i++) {
            NSLog(@"secondCounter%i", i);
            NSLog(@"current thread:%@", [NSThread currentThread]);
        }
    }
}

- (void)thirdCounter
{
    for (int i = 1; i < 100; i++) {
        NSLog(@"thirdCounter%i", i);
        NSLog(@"current thread:%@", [NSThread currentThread]);
    }
}

- (void)downloadWithUrl:(NSString *)urlStr
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"end download");
    }];
    [dataTask resume];
    
}

- (void)firstPrint:(NSString *)firstStr
{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@", firstStr);
    NSLog(@"current thread:%@", [NSThread currentThread]);
    NSLog(@"main thread:%@", [NSThread mainThread]);
}

- (void)secondPrint:(NSString *)secondStr
{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@", secondStr);
    NSLog(@"current thread:%@", [NSThread currentThread]);
    NSLog(@"main thread:%@", [NSThread mainThread]);
}

- (void)printString:(NSString *)str
{
    NSLog(@"%@", str);
    NSLog(@"main thread:%@", [NSThread mainThread]);
    NSLog(@"current thread:%@", [NSThread currentThread]);
}

void (^onlyOnce) (void) = ^{
    NSLog(@"111");
};

- (void)reloadTableView
{
    NSLog(@"reloadTableView");
}

- (void)reloadScrollView
{
    NSLog(@"reloadScrollView");
}

- (void)reloadImageView
{
    NSLog(@"reloadImageView");
}

void reloadAllViews(void *paramContext){
    DHTGCDViewController *self = (__bridge DHTGCDViewController *)paramContext;
    
    [self reloadTableView];
    [self reloadScrollView];
    [self reloadImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
