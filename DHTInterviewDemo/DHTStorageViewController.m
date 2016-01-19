//
//  DHTStorageViewController.m
//  DHTInterviewDemo
//
//  Created by happyo on 16/1/18.
//  Copyright © 2016年 happyo. All rights reserved.
//

#import "DHTStorageViewController.h"
#import "Car.h"

@interface DHTStorageViewController ()

@end

@implementation DHTStorageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self writeToPlist];
    
//    [self writeWithPreferences];
    
    [self writeWithArchiver];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Private Methods --

- (void)writeWithArchiver
{
    // 创建对象
    Car *car = [[Car alloc] init];
    car.name = @"Aventador";
    car.speed = 300;
    
    // 获得存储路径
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileName = [documentPath stringByAppendingString:@"car.data"];
    
    // 归档
    [NSKeyedArchiver archiveRootObject:car toFile:fileName];
    
    // 解档
    Car *unarchiveCar = [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
    
    NSLog(@"car :%@ , speed :%ld", unarchiveCar.name, unarchiveCar.speed);
}

- (void)writeWithPreferences
{
    // 获取 NSUserDefaults 的单例对象
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    // 存储
    [userDefaults setObject:@"happyo" forKey:@"name"];
    [userDefaults setBool:YES forKey:@"isMale"];
    [userDefaults setInteger:25 forKey:@"age"];
    
    // 立即同步
    [userDefaults synchronize];
    
    // 读取
    NSString *nameStr = [userDefaults objectForKey:@"name"];
    BOOL isMale = [userDefaults boolForKey:@"isMale"];
    NSInteger age = [userDefaults integerForKey:@"age"];
    
    NSLog(@"name : %@, isMale :%d, age :%ld", nameStr, isMale, age);
}

- (void)writeToPlist
{
    // 获取存储文件的路径
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileName = [documentPath stringByAppendingPathComponent:@"storage.plist"];
    
    // 存储
    NSArray *array = @[@"hello", @"world"];
    [array writeToFile:fileName atomically:YES];
    
    // 读取
    NSArray *result = [NSArray arrayWithContentsOfFile:fileName];
    NSLog(@"result :%@", result);
    
    // 当存入的数组含有 null 的时候写文件会失败
    NSArray *modifyArray = @[@"hello", [NSNull null]];
    [modifyArray writeToFile:fileName atomically:YES];
    
    // 结果发现取出来的还是第一次存的数组
    NSArray *modifyResult = [NSArray arrayWithContentsOfFile:fileName];
    NSLog(@"modify result :%@", modifyResult);
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
