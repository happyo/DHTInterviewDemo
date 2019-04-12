//
//  DHTKVCViewController.m
//  DHTInterviewDemo
//
//  Created by happyo on 2019/4/12.
//  Copyright © 2019 happyo. All rights reserved.
//

#import "DHTKVCViewController.h"
#import "KVCBankAccount.h"

@interface DHTKVCViewController ()

@end

@implementation DHTKVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    KVCBankAccount *bankAccount = [[KVCBankAccount alloc] init];
    [bankAccount setValue:@(100.0) forKey:@"currentBalance"];
    
    KVCPerson *owner = [[KVCPerson alloc] init];
    owner.name = @"owner";
    
    KVCPerson *payeeOne = [[KVCPerson alloc] init];
    payeeOne.name = @"payeeOne";
    KVCTransaction *transactionOne = [[KVCTransaction alloc] init];
    transactionOne.payee = payeeOne;
    
    KVCPerson *payeeTwo = [[KVCPerson alloc] init];
    payeeTwo.name = @"payeeTwo";
    KVCTransaction *transactionTwo = [[KVCTransaction alloc] init];
    transactionTwo.payee = payeeTwo;
    
    [bankAccount setValue:@[transactionOne, transactionTwo] forKey:@"transactions"];
    
    NSLog(@"currentBlance : %@", bankAccount.currentBalance);
    NSLog(@"payee names : %@", [bankAccount valueForKeyPath:@"transactions.payee.name"]);
}

@end
