//
//  PTCellDataSource.m
//  bodhi
//
//  Created by zhaoliang chen on 2018/8/7.
//  Copyright © 2018年 英联(厦门)金融技术服务股份有限公司. All rights reserved.
//

#import "ZLCellDataSource.h"

@implementation ZLCellDataSource

- (instancetype)initWithItems:(NSArray *)items
               cellIdentifier:(NSString *)cellIdentifier
           configureCellBlock:(CellConfigureBlock)configureCellBlock {
    self = [super init];
    if (!self) {
        return nil;
    }
    _items = items;
    _cellIdentifier = cellIdentifier;
    _configureCellBlock = configureCellBlock;
    return self;
}

- (instancetype)initWithItems:(NSArray*)items
                     delegate:(id<ZLCellDataSourceDelegate>)delegate
           configureCellBlock:(CellConfigureBlock)configureCellBlock {
    self = [super init];
    if (!self) {
        return nil;
    }
    _items = items;
    _delegate = delegate;
    _configureCellBlock = configureCellBlock;
    return self;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(getCellIdentifierByIndex:)]) {
        NSString* identify = [_delegate getCellIdentifierByIndex:indexPath];
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
        id item = [self itemAtIndexPath:indexPath];
        self.configureCellBlock(cell, item, indexPath);
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
        
        id item = [self itemAtIndexPath:indexPath];
        self.configureCellBlock(cell, item, indexPath);
        return cell;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(getCellIdentifierByIndex:)]) {
        NSString* identify = [_delegate getCellIdentifierByIndex:indexPath];
        
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
        id item = [self itemAtIndexPath:indexPath];
        self.configureCellBlock(cell, item, indexPath);
        return cell;
    } else {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
        id item = [self itemAtIndexPath:indexPath];
        self.configureCellBlock(cell, item, indexPath);
        return cell;
    }
}

- (instancetype)itemAtIndexPath:(NSIndexPath*)indexPath {
    return self.items[(NSUInteger)indexPath.row];
}

@end
