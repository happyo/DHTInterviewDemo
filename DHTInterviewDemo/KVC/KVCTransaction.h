//
//  KVCTransaction.h
//  DHTInterviewDemo
//
//  Created by happyo on 2019/4/12.
//  Copyright © 2019 happyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KVCPerson.h"

NS_ASSUME_NONNULL_BEGIN

@interface KVCTransaction : NSObject

@property (nonatomic, strong) KVCPerson *payee;

@property (nonatomic, strong) NSNumber *amount;

//@property (nonatomic, strong) NSDate

@end

NS_ASSUME_NONNULL_END
