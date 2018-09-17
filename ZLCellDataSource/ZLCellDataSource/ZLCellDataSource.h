//
//  PTCellDataSource.h
//  bodhi
//
//  Created by zhaoliang chen on 2018/8/7.
//  Copyright © 2018年 英联(厦门)金融技术服务股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^CellConfigureBlock)(id cell, id item, NSIndexPath *indexPath);

@interface ZLCellDataSource : NSObject
<UITableViewDataSource,UICollectionViewDataSource>

- (instancetype)initWithItems:(NSArray *)items
               cellIdentifier:(NSString *)cellIdentifier
           configureCellBlock:(CellConfigureBlock)configureCellBlock;

- (instancetype)itemAtIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, strong) NSArray* items;
@property (nonatomic, copy) NSString* cellIdentifier;
@property (nonatomic, copy) CellConfigureBlock configureCellBlock;

@end
