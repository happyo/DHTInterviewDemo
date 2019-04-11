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

static void *PersonAccountBalanceContext = &PersonAccountBalanceContext;

@interface DHTKVOViewController ()

@end

@implementation DHTKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    Person *p = [[Person alloc] init];
    
    Account *account = [[Account alloc] init];
    account.balance = 10;
    [account addObserver:self forKeyPath:@"balance" options:NSKeyValueObservingOptionNew context:PersonAccountBalanceContext];
    [account addObserver:self forKeyPath:@"itemChanged" options:NSKeyValueObservingOptionNew context:nil];
    [account addObserver:self forKeyPath:@"balanceDesc" options:NSKeyValueObservingOptionNew context:nil];
    
    account.balance = 20;
    account.balance = 20;
    
    [account removeObserver:self forKeyPath:@"balance" context:PersonAccountBalanceContext];
    account.balance = 30;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey,id> *)change context:(nullable void *)context
{
    if ([keyPath isEqualToString:@"balance"]) {
        NSNumber *newBalance = [change objectForKey:NSKeyValueChangeNewKey];
        NSLog(@"balance : %@", newBalance);
    } else if ([keyPath isEqualToString:@"itemChanged"]) {
        NSNumber *itemChanged = [change objectForKey:NSKeyValueChangeNewKey];
        NSLog(@"itemChanged : %@", itemChanged);
    } else if ([keyPath isEqualToString:@"balanceDesc"]) {
        NSString *balanceDesc = [change objectForKey:NSKeyValueChangeNewKey];
        NSLog(@"balanceDesc : %@", balanceDesc);
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


@end
