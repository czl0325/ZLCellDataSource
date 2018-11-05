//
//  UserHeader.h
//  ZLCellDataSource
//
//  Created by zhaoliang chen on 2018/11/5.
//  Copyright © 2018 github. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserHeader : UITableViewHeaderFooterView

@property(nonatomic,strong)User* user;

@end

NS_ASSUME_NONNULL_END
