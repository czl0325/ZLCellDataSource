//
//  PTBaseViewModel.m
//  bodhi
//
//  Created by zhaoliang chen on 2018/8/8.
//  Copyright © 2018年 英联(厦门)金融技术服务股份有限公司. All rights reserved.
//

#import "ZLBaseViewModel.h"

@interface ZLBaseViewModel()

@property(nonatomic,assign)NSInteger currentIndex;

@end

@implementation ZLBaseViewModel

- (instancetype)init {
    if (self = [super init]) {
        self.currentIndex = 1;
    }
    return self;
}

- (instancetype)initWithSuccess:(ViewModelSuccessBlock)successBlock fail:(ViewModelFailBlock)failBlock {
    if (self = [self init]) {
        self.successBlock = successBlock;
        self.failBlock = failBlock;
    }
    return self;
}

@end
