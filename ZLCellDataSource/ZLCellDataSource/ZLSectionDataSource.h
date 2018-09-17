//
//  PTSectionDataSource.h
//  bodhi
//
//  Created by zhaoliang chen on 2018/8/7.
//  Copyright © 2018年 英联(厦门)金融技术服务股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^CellConfigureBlock)(id cell, id item, NSIndexPath *indexPath);

@interface ZLSectionDataSource : NSObject<UITableViewDataSource,UICollectionViewDataSource>

- (instancetype)initWithItems:(NSArray *)items
               cellIdentifier:(NSArray<NSString*> *)cellIdentifiers
           configureCellBlock:(CellConfigureBlock)configureCellBlock;

@property (nonatomic, copy) NSArray* items;
@property (nonatomic, copy) NSArray<NSString*>* cellIdentifiers;
@property (nonatomic, copy) CellConfigureBlock configureCellBlock;

@end
