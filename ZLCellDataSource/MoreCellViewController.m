//
//  MoreCellViewController.m
//  ZLCellDataSource
//
//  Created by zhaoliang chen on 2019/9/9.
//  Copyright © 2019 github. All rights reserved.
//

#import "MoreCellViewController.h"
#import "ZLCellDataSource.h"
#import "MyCell1.h"
#import "MyCell2.h"

@interface MoreCellViewController ()
<ZLCellDataSourceDelegate>

@property(nonatomic,strong)NSMutableArray* array;
//注意dataSource一定要声明为类的成员变量，才能生效。
@property(nonatomic,strong)ZLCellDataSource* dataSource;
@property(nonatomic,strong)UITableView* tableView;

@end

@implementation MoreCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.array = [NSMutableArray new];
    for (int i=0; i<50; i++) {
        [self.array addObject:[NSString stringWithFormat:@"行数-----%d",i]];
    }
    
    /*
     block原来是(id cell, id item, NSIndexPath *indexPath)
     需要将cell和item的id类型替换成自己实际使用的cell类和item类
     如以下我是UITableViewCell*类和NSString*类
     */
    self.dataSource = [[ZLCellDataSource alloc]initWithItems:self.array delegate:self configureCellBlock:^(UITableView* cell, NSString* item, NSIndexPath *indexPath) {
        if (indexPath.row%2==0) {
            MyCell1* cell1 = (MyCell1*)cell;
            [cell1 updateMyCell1:item];
        } else {
            //MyCell2* cell2 = (MyCell1*)cell;
        }
    }];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    /*
     以下两步一定要
     将self.dataSource赋值过来，才能生效
     必须注册cell的类
     */
    self.tableView.dataSource = self.dataSource;
    [self.tableView registerClass:[MyCell1 class] forCellReuseIdentifier:@"MyCell1"];
    [self.tableView registerClass:[MyCell2 class] forCellReuseIdentifier:@"MyCell2"];
    [self.view addSubview:self.tableView];
}

- (NSString*)getCellIdentifierByIndex:(NSIndexPath*)indexPath {
    if (indexPath.row % 2 == 0) {
        return @"MyCell1";
    } else {
        return @"MyCell2";
    }
}

@end
