//
//  PTSectionDataSource.m
//  bodhi
//
//  Created by zhaoliang chen on 2018/8/7.
//  Copyright © 2018年 英联(厦门)金融技术服务股份有限公司. All rights reserved.
//

#import "ZLSectionDataSource.h"
#import <objc/runtime.h>

@implementation ZLSectionModel

@end

@interface ZLSectionDataSource()

@property (nonatomic, copy) NSArray* items;
@property (nonatomic, copy) NSArray<NSString*>* cellIdentifiers;
@property (nonatomic, copy) NSArray<Class>* cellClasses;
@property (nonatomic, copy) ZLSectionModel* modelDictionary;
@property (nonatomic, copy) CellConfigureBlock configureCellBlock;

@end

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
    return [self initWithItems:items cellIdentifier:cellIdentifiers cellClasses:nil modelDic:nil configureCellBlock:configureCellBlock];
}

- (instancetype)initWithItems:(NSArray *)items
               cellIdentifier:(NSArray<NSString*> *)cellIdentifiers
                  cellClasses:(NSArray<Class>*)cellClasses
                     modelDic:(ZLSectionModel*)modelDic
           configureCellBlock:(CellConfigureBlock)configureCellBlock {
    self = [super init];
    if (!self) {
        return nil;
    }
    _items = items;
    _cellIdentifiers = cellIdentifiers;
    _cellClasses = cellClasses;
    _modelDictionary = modelDic;
    
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
    NSArray* array = nil;
    if (_modelDictionary == nil) {
        array = self.items[section];
    } else {
        id item = [[(NSClassFromString(self.modelDictionary.firstClassName)) alloc] init];
        item = self.items[section];
        array = [self nameWithInstance:item];
    }
    if (array == nil) {
        return 0;
    }
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
    if (_modelDictionary == nil) {
        NSArray* array = self.items[indexPath.section];
        id item = array[indexPath.row];
        self.configureCellBlock(myCell, item, indexPath);
    } else {
        id item1 = [[(NSClassFromString(self.modelDictionary.firstClassName)) alloc] init];
        item1 = self.items[indexPath.section];
        NSArray* array = [self nameWithInstance:item1];
        id item2 = array[indexPath.row];
        self.configureCellBlock(myCell, item2, indexPath);
    }
    return myCell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.items.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray* array = nil;
    if (_modelDictionary == nil) {
        array = self.items[section];
    } else {
        id item = [[(NSClassFromString(self.modelDictionary.firstClassName)) alloc] init];
        item = self.items[section];
        array = [self nameWithInstance:item];
    }
    if (array == nil) {
        return 0;
    }
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
    if (_modelDictionary == nil) {
        NSArray* array = self.items[indexPath.section];
        id item = array[indexPath.row];
        self.configureCellBlock(myCell, item, indexPath);
    } else {
        id item1 = [[(NSClassFromString(self.modelDictionary.firstClassName)) alloc] init];
        item1 = self.items[indexPath.section];
        NSArray* array = [self nameWithInstance:item1];
        id item2 = array[indexPath.row];
        self.configureCellBlock(myCell, item2, indexPath);
    }
    return myCell;
}

- (NSArray*)nameWithInstance:(id)item {
    unsigned int numIvars = 0;
    Ivar* ivars = class_copyIvarList(NSClassFromString(self.modelDictionary.firstClassName), &numIvars);
    for (int i=0; i<numIvars; i++) {
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        const char * type = ivar_getTypeEncoding(ivar);
        //NSLog(@"Person拥有的成员变量的类型为%s，名字为 %s ",type, name);
        if ((strcmp(type, "@\"NSArray\"") == 0 || strcmp(type, "@\"NSMutableArray\"") == 0) && strcmp(name, self.modelDictionary.secondVariate.UTF8String)) {
            NSArray* array = object_getIvar(item, ivar);
            return array;
        }
    }
    return nil;
}

@end
