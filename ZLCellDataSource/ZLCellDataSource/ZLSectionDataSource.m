//
//  PTSectionDataSource.m
//  bodhi
//
//  Created by zhaoliang chen on 2018/8/7.
//  Copyright © 2018年 英联(厦门)金融技术服务股份有限公司. All rights reserved.
//

#import "ZLSectionDataSource.h"

@implementation ZLSectionDataSource

- (instancetype)initWithItems:(NSArray *)items
               cellIdentifier:(NSArray<NSString*> *)cellIdentifiers
           configureCellBlock:(CellConfigureBlock)configureCellBlock {
    return [self initWithItems:items cellIdentifier:cellIdentifiers cellClasses:nil configureCellBlock:configureCellBlock];
}

- (instancetype)initWithItems:(NSArray *)items
               cellIdentifier:(NSArray<NSString*> *)cellIdentifiers
                  cellClasses:(NSArray<Class>*)cellClasses
           configureCellBlock:(CellConfigureBlock)configureCellBlock  {
    self = [super init];
    if (!self) {
        return nil;
    }
    _items = items;
    _cellIdentifiers = cellIdentifiers;
    _cellClasses = cellClasses;
    if (cellIdentifiers.count < items.count && cellIdentifiers.count > 0) {
        NSMutableArray* arr = [NSMutableArray new];
        [arr addObjectsFromArray:cellIdentifiers];
        NSString* identifier = cellIdentifiers[cellIdentifiers.count-1];
        for (NSInteger i=cellIdentifiers.count; i<items.count; i++) {
            [arr addObject:identifier];
        }
        _cellIdentifiers = [arr copy];
    }
    NSMutableArray* arrayClasses = [NSMutableArray new];
    if (cellClasses == nil) {
        for (NSUInteger i=0; i<_cellIdentifiers.count; ++i) {
            NSString* identify = _cellIdentifiers[i];
            [arrayClasses addObject:NSClassFromString(identify)];
        }
    } else {
        for (NSUInteger i=0; i<_cellClasses.count; i++) {
            if (i<_cellClasses.count) {
                [arrayClasses addObject:_cellClasses[i]];
            } else {
                [arrayClasses addObject:_cellClasses[_cellClasses.count-1]];
            }
        }
        if (arrayClasses.count < _cellIdentifiers.count && arrayClasses.count > 0) {
            Class lastClass = arrayClasses[arrayClasses.count-1];
            for (NSUInteger i=_cellClasses.count; i<_cellIdentifiers.count; i++) {
                [arrayClasses addObject:lastClass];
            }
        }
    }
    _cellClasses = [arrayClasses copy];
    _configureCellBlock = configureCellBlock;
    return self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.items.count;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray* array = self.items[section];
    return array.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    Class class = self.cellClasses[indexPath.section];
    id myCell = [[class alloc]init];
    if (!myCell) {
        return nil;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifiers[indexPath.section] forIndexPath:indexPath];
    myCell = cell;
    NSArray* array = self.items[indexPath.section];
    id item = array[indexPath.row];
    self.configureCellBlock(myCell, item, indexPath);
    return myCell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.items.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray* array = self.items[section];
    return array.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Class class = self.cellClasses[indexPath.section];
    id myCell = [[class alloc]init];
    if (!myCell) {
        return nil;
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifiers[indexPath.section] forIndexPath:indexPath];
    myCell = cell;
    NSArray* array = self.items[indexPath.section];
    id item = array[indexPath.row];
    self.configureCellBlock(myCell, item, indexPath);
    return myCell;
}

@end
