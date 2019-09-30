//
//  MyCell1.m
//  ZLCellDataSource
//
//  Created by zhaoliang chen on 2019/9/9.
//  Copyright © 2019 github. All rights reserved.
//

#import "MyCell1.h"

@interface MyCell1 ()


@property(nonatomic,strong)UILabel* label1;

@end

@implementation MyCell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel* l1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 150, 30)];
        l1.text = @"我是样式1";
        [self.contentView addSubview:l1];
        
        self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(250, 10, 150, 30)];
        [self.contentView addSubview:self.label1];
    }
    return self;
}

- (void)updateMyCell1:(NSString*)str {
    self.label1.text = str;
}

@end
