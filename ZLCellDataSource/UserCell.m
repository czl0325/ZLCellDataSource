//
//  UserCell.m
//  ZLCellDataSource
//
//  Created by zhaoliang chen on 2018/11/5.
//  Copyright © 2018 github. All rights reserved.
//

#import "UserCell.h"

@interface UserCell ()

@property(nonatomic,strong)UILabel* lAddress;

@end

@implementation UserCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.lAddress = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 320, 100)];
        self.lAddress.numberOfLines = 0;
        [self.contentView addSubview:self.lAddress];
    }
    return self;
}

- (void)setAddress:(Address *)address {
    self.lAddress.text = [NSString stringWithFormat :@"%@%@%@,",address.province,address.city,address.address];
}

@end
