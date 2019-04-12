//
//  KVCBankAccount.h
//  DHTInterviewDemo
//
//  Created by happyo on 2019/4/12.
//  Copyright © 2019 happyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KVCPerson.h"
#import "KVCTransaction.h"

NS_ASSUME_NONNULL_BEGIN

@interface KVCBankAccount : NSObject

@property (nonatomic, strong) NSNumber *currentBalance; // An attribute

@property (nonatomic, strong) KVCPerson *owner; // A to-one relation

@property (nonatomic, strong) NSArray<KVCTransaction *> *transactions; // A to-many relation

@end

NS_ASSUME_NONNULL_END
