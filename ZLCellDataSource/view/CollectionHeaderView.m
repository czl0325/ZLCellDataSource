//
//  CollectionHeaderView.m
//  ZLCellDataSource
//
//  Created by zhaoliang chen on 2019/9/29.
//  Copyright © 2019 github. All rights reserved.
//

#import "CollectionHeaderView.h"

@implementation CollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 20)];
        self.titleLabel.textColor = [UIColor orangeColor];
        [self addSubview:self.titleLabel];
    }
    return self;
}

@end
