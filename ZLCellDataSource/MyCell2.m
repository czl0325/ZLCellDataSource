//
//  MyCell2.m
//  ZLCellDataSource
//
//  Created by zhaoliang chen on 2019/9/9.
//  Copyright © 2019 github. All rights reserved.
//

#import "MyCell2.h"

@implementation MyCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel* l1 = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width-160, 10, 150, 30)];
        l1.textAlignment = NSTextAlignmentRight;
        l1.text = @"我是样式2";
        [self.contentView addSubview:l1];
    }
    return self;
}

@end
