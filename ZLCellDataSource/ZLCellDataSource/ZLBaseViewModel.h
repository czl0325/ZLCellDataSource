//
//  PTBaseViewModel.h
//  bodhi
//
//  Created by zhaoliang chen on 2018/8/8.
//  Copyright © 2018年 英联(厦门)金融技术服务股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ViewModelSuccessBlock)(id data);
typedef void(^ViewModelFailBlock)(id data);

@interface ZLBaseViewModel : NSObject

@property(nonatomic,copy)ViewModelSuccessBlock successBlock;
@property(nonatomic,copy)ViewModelFailBlock failBlock;

- (instancetype)initWithSuccess:(ViewModelSuccessBlock)successBlock fail:(ViewModelFailBlock) failBlock;

@end
