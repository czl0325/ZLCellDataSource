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
    self = [super init];
    if (!self) {
        return nil;
    }
    _items = items;
    _cellIdentifiers = cellIdentifiers;
    if (cellIdentifiers.count < items.count && cellIdentifiers.count > 0) {
        NSMutableArray* arr = [NSMutableArray new];
        [arr addObjectsFromArray:cellIdentifiers];
        NSString* identifier = cellIdentifiers[cellIdentifiers.count-1];
        for (NSInteger i=cellIdentifiers.count; i<items.count; i++) {
            [arr addObject:identifier];
        }
        _cellIdentifiers = [arr copy];
    }
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifiers[indexPath.section] forIndexPath:indexPath];
    
    NSArray* array = self.items[indexPath.section];
    id item = array[indexPath.row];
    self.configureCellBlock(cell, item, indexPath);
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.items.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray* array = self.items[section];
    return array.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifiers[indexPath.section] forIndexPath:indexPath];
    NSArray* array = self.items[indexPath.section];
    id item = array[indexPath.row];
    self.configureCellBlock(cell, item, indexPath);
    return cell;
}

@end
