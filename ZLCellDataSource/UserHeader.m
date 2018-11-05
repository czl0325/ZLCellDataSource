//
//  UserHeader.m
//  ZLCellDataSource
//
//  Created by zhaoliang chen on 2018/11/5.
//  Copyright © 2018 github. All rights reserved.
//

#import "UserHeader.h"

@interface UserHeader ()

@property(nonatomic,strong)UILabel* lName;
@property(nonatomic,strong)UILabel* lPhone;

@end

@implementation UserHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        self.lName = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
        [self.contentView addSubview:self.lName];
        
        self.lPhone = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, 100, 20)];
        [self.contentView addSubview:self.lPhone];
    }
    return self;
}

- (void)setUser:(User *)user {
    _user = user;
    
    self.lName.text = user.name;
    self.lPhone.text = user.phone;
}

@end
