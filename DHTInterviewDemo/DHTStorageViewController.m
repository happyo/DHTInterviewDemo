//
//  DHTStorageViewController.m
//  DHTInterviewDemo
//
//  Created by happyo on 16/1/18.
//  Copyright © 2016年 happyo. All rights reserved.
//

#import "DHTStorageViewController.h"
#import "Car.h"
#import <sqlite3.h>

@interface DHTStorageViewController ()
{
    sqlite3 *myDb;
}
@end

@implementation DHTStorageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self writeToPlist];
    
//    [self writeWithPreferences];
    
//    [self writeWithArchiver];
    
    [self writeWIthSQLite];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Private Methods --

- (void)writeWIthSQLite
{
    // 获取文件路径名
    NSString *fileName = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingString:@"person.sqlite"];
    
    // 打开数据库
    NSInteger openResult = sqlite3_open(fileName.UTF8String, &myDb);
    if (openResult == SQLITE_OK) {
        NSLog(@"打开数据库成功");
        
        // 创建表 SQL
        NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS person_info (ID INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER)";
        char *errmsg = NULL;
        
        // 执行语句
        sqlite3_exec(myDb, sqlCreateTable.UTF8String, NULL, NULL, &errmsg);
        
        if (errmsg) {
            NSLog(@"建表失败： %s", errmsg);
            return;
        } else {
            NSLog(@"建表成功");
        }
        
        
        // 插入10条数据
        for (int i = 1; i < 10; i++) {
            NSString *nameStr = [NSString stringWithFormat:@"happyo%i", i];
            NSInteger age = i;
            NSString *sqlInsertData = [NSString stringWithFormat:@"INSERT INTO person_info (name, age) VALUES ('%@', '%ld')",nameStr , age];
            
            // 执行语句
            sqlite3_exec(myDb, sqlInsertData.UTF8String, NULL, NULL, &errmsg);
            
            if (errmsg) {
                NSLog(@"插入失败： %s", errmsg);
                return;
            }
        }
        
        NSLog(@"插入成功");
        
        
        // 查询数据
        NSString *sqlQuery = @"SELECT name, age FROM person_info";
        sqlite3_stmt *stmt;
        
        NSInteger queryResult = sqlite3_prepare_v2(myDb, sqlQuery.UTF8String, -1, &stmt, NULL);
        if (queryResult == SQLITE_OK) {
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                char *name = (char *)sqlite3_column_text(stmt, 0);
                NSInteger age = sqlite3_column_int(stmt, 1);
                
                NSLog(@"name :%s , age :%ld", name, age);
            }
        }
        
        sqlite3_finalize(stmt);
        
    } else {
        NSLog(@"打开数据库失败");
        sqlite3_close(myDb);
        return;
    }
    

    
    sqlite3_close(myDb);
}

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
