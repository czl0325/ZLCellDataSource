//
//  CollectionCellView.m
//  ZLCellDataSource
//
//  Created by zhaoliang chen on 2019/9/29.
//  Copyright © 2019 github. All rights reserved.
//

#import "CollectionCellView.h"

@implementation CollectionCellView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.label = [[UILabel alloc]initWithFrame:self.bounds];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.label];
    }
    return self;
}

@end
