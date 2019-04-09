//
//  Person+CoreDataProperties.h
//  DHTInterviewDemo
//
//  Created by happyo on 16/1/18.
//  Copyright © 2016年 happyo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSNumber *age;

@end

NS_ASSUME_NONNULL_END
