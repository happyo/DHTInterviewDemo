//
//  DHTKVOViewController.m
//  DHTInterviewDemo
//
//  Created by happyo on 2019/4/10.
//  Copyright © 2019 happyo. All rights reserved.
//

#import "DHTKVOViewController.h"
#import "Person.h"
#import "Account.h"

@interface DHTKVOViewController ()

@end

@implementation DHTKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Person *p = [[Person alloc] init];
    [p addObserver:self forKeyPath:@"" options:NSKeyValueObservingOptionOld context:nil];
}

@end
