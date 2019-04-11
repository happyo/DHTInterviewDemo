//
//  Account.m
//  DHTInterviewDemo
//
//  Created by happyo on 2019/4/10.
//  Copyright © 2019 happyo. All rights reserved.
//

#import "Account.h"

@implementation Account

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key
{
    BOOL automatic = NO;
    
    if ([key isEqualToString:@"balance"]) {
        automatic = NO;
    } else {
        automatic = [super automaticallyNotifiesObserversForKey:key];
    }
    
    return automatic;
}

- (void)setBalance:(double)balance
{
    if (balance != _balance) {
        [self willChangeValueForKey:@"balance"];
        [self willChangeValueForKey:@"itemChanged"];
        _itemChanged = _itemChanged + 1;
        _balance = balance;
        [self didChangeValueForKey:@"balance"];
        [self didChangeValueForKey:@"itemChanged"];
    }
}

- (NSString *)balanceDesc
{
    return [NSString stringWithFormat:@"%f : %i", self.balance, self.itemChanged];
}

//+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key
//{
//    NSSet<NSString *> *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
//
//    if ([key isEqualToString:@"balanceDesc"]) {
//        NSArray *affectingKeys = @[@"balance", @"itemChanged"];
//        [keyPaths setByAddingObjectsFromArray:affectingKeys];
//    }
//
//    return keyPaths;
//}

+ (NSSet<NSString *> *)keyPathsForValuesAffectingBalanceDesc
{
    return [NSSet setWithObjects:@"balance", @"itemChanged", nil];
}

@end
