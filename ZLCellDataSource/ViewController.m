//
//  ViewController.m
//  ZLCellDataSource
//
//  Created by zhaoliang chen on 2018/9/17.
//  Copyright © 2018年 github. All rights reserved.
//

#import "ViewController.h"
#import "ZLCellDataSource.h"
#import "ZLBaseViewModel.h"

@interface ViewController ()

@property(nonatomic,strong)NSMutableArray* array;
//注意dataSource一定要声明为类的成员变量，才能生效。
@property(nonatomic,strong)ZLCellDataSource* dataSource;
@property(nonatomic,strong)UITableView* tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.array = [NSMutableArray new];
    for (int i=0; i<50; i++) {
        [self.array addObject:[NSString stringWithFormat:@"行数-----%d",i]];
    }
    
    /*
     block原来是(id cell, id item, NSIndexPath *indexPath)
     需要将cell和item的id类型替换成自己实际使用的cell类和item类
     如以下我是UITableViewCell*类和NSString*类
     */
    self.dataSource = [[ZLCellDataSource alloc]initWithItems:self.array cellIdentifier:@"ZLCell" configureCellBlock:^(UITableViewCell* cell, NSString* item, NSIndexPath *indexPath) {
        cell.textLabel.text = item;
        cell.textLabel.textColor = [UIColor redColor];
    }];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    /*
     以下两步一定要
     将self.dataSource赋值过来，才能生效
     必须注册cell的类
    */
    self.tableView.dataSource = self.dataSource;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ZLCell"];
    [self.view addSubview:self.tableView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
