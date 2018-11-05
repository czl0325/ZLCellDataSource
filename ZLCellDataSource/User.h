//
//  User.h
//  ZLCellDataSource
//
//  Created by zhaoliang chen on 2018/11/5.
//  Copyright © 2018 github. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Address : NSObject

@property(nonatomic,copy)NSString* province;
@property(nonatomic,copy)NSString* city;
@property(nonatomic,copy)NSString* address;

@end

@interface User : NSObject

@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* phone;
@property(nonatomic,assign)int age;
@property(nonatomic,copy)NSArray<Address*>* addresses;

@end

NS_ASSUME_NONNULL_END
