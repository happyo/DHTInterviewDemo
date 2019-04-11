//
//  ViewController.m
//  DHTInterviewDemo
//
//  Created by happyo on 16/1/15.
//  Copyright © 2016年 happyo. All rights reserved.
//

#import "ViewController.h"
#import "DHTRunLoopViewController.h"
#import "DHTKVOViewController.h"

@interface DHTVCModel : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) UIViewController *vc;

@end

@implementation DHTVCModel

@end

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray<DHTVCModel *> *vcList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor redColor];
    
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
}
#pragma mark -- UITableViewDataSource --

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.vcList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    DHTVCModel *vcModel = self.vcList[indexPath.row];
    
    cell.textLabel.text = vcModel.name;
    
    return cell;
}

#pragma mark -- UITableViewDelegate --

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DHTVCModel *vcModel = self.vcList[indexPath.row];
    
    [self.navigationController pushViewController:vcModel.vc animated:YES];
}

#pragma mark -- Getters && Setters --

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    
    return _tableView;
}

- (NSArray<DHTVCModel *> *)vcList
{
    if (!_vcList) {
        DHTVCModel *runLoopModel = [[DHTVCModel alloc] init];
        runLoopModel.name = @"Run Loop";
        runLoopModel.vc = [[DHTRunLoopViewController alloc] init];
        
        DHTVCModel *kvoModel = [[DHTVCModel alloc] init];
        kvoModel.name = @"KVO";
        kvoModel.vc = [[DHTKVOViewController alloc] init];
        
        _vcList = @[runLoopModel, kvoModel];
    }
    
    return _vcList;
}

@end
