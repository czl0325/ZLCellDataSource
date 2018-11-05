//
//  SectionViewController.m
//  ZLCellDataSource
//
//  Created by zhaoliang chen on 2018/11/5.
//  Copyright © 2018 github. All rights reserved.
//

#import "SectionViewController.h"
#import "ZLSectionDataSource.h"
#import "UserCell.h"
#import "UserHeader.h"

@interface SectionViewController ()
<UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray* users;
@property(nonatomic,strong)ZLSectionDataSource* dataSource;
@property(nonatomic,strong)UITableView* tableView;

@end

@implementation SectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.users = [NSMutableArray new];
    for (int i=0; i<5; i++) {
        User* user = [User new];
        user.name = @"czl";
        user.phone = @"1111";
        user.age = 20;
        
        NSMutableArray* arr = [NSMutableArray new];
        for (int j=0; j<3; j++) {
            Address* addr = [Address new];
            addr.province = @"fujian";
            addr.city = @"xiamen";
            addr.address = @"123123123123";
            [arr addObject:addr];
        }
        
        user.addresses = arr;
        [self.users addObject:user];
    }
    
    ZLSectionModel* model = [ZLSectionModel new];
    model.firstClassName = @"User";
    model.secondVariate = @"addresses";
    
    self.dataSource = [[ZLSectionDataSource alloc]initWithItems:self.users cellIdentifier:@[@"UserCell"] cellClasses:@[UserCell.class] modelDic:model configureCellBlock:^(UserCell* cell, Address* item, NSIndexPath *indexPath) {
        cell.address = item;
    }];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    [self.tableView registerClass:UserCell.class forCellReuseIdentifier:@"UserCell"];
    [self.tableView registerClass:UserHeader.class forHeaderFooterViewReuseIdentifier:@"UserHeader"];
    [self.view addSubview:self.tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UserHeader* header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UserHeader"];
    header.user = self.users[section];
    return header;
}

@end
