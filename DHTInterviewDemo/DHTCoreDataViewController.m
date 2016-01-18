//
//  DHTCoreDataViewController.m
//  DHTInterviewDemo
//
//  Created by happyo on 16/1/18.
//  Copyright © 2016年 happyo. All rights reserved.
//

#import "DHTCoreDataViewController.h"
#import <CoreData/CoreData.h>
#import "Person.h"

@interface DHTCoreDataViewController ()

@property (nonatomic, strong) NSManagedObjectContext *context;

@property (nonatomic, strong) NSManagedObjectModel *model;

@end

@implementation DHTCoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.model = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model];
    
    // 设置sqlite文件路径
    NSString *path = [self archivePath];
    NSURL *storeUrl = [NSURL fileURLWithPath:path];
    
    NSError *error = nil;
    
    if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
        @throw [NSException exceptionWithName:@"open failure" reason:[error localizedDescription] userInfo:nil];
    }
    
    self.context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [self.context setPersistentStoreCoordinator:psc];
    
    
    [self insertEntity];
    
    [self searchEntitys];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Private Methods --

- (void)searchEntitys
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
    
    NSError *error = nil;
    NSArray *persones = [self.context executeFetchRequest:fetchRequest error:&error];
    
    NSLog(@"%@", persones);
}

- (void)insertEntity
{
    Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.context];
    person.firstName = @"Happyo";
    person.lastName = @"Jones";
    person.age = @(25);
    
    NSError *error = nil;
    if (![self.context save:&error]) {
        //
        NSLog(@"%@", error);
    } else {
        NSLog(@"success");
    }
}

- (NSString *)archivePath
{
    NSArray *documentDictionaries = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDictionary = [documentDictionaries firstObject];
    
    return [documentDictionary stringByAppendingString:@"store.data"];
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
