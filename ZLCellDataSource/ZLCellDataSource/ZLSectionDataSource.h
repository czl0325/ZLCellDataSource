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

/**
 firstClassName : 为第一层数组的数据class类名
 secondVariate : 为第二层数组对应的元素变量名
 **/
@interface ZLSectionModel : NSObject

@property(nonatomic,copy)NSString* firstClassName;
@property(nonatomic,copy)NSString* secondVariate;
//@property(nonatomic,copy)NSString* secondClassName;

@end

@interface ZLSectionDataSource : NSObject<UITableViewDataSource,UICollectionViewDataSource>

- (instancetype)initWithItems:(NSArray *)items
               cellIdentifier:(NSArray<NSString*> *)cellIdentifiers
           configureCellBlock:(CellConfigureBlock)configureCellBlock;

- (instancetype)initWithItems:(NSArray *)items
               cellIdentifier:(NSArray<NSString*> *)cellIdentifiers
                  cellClasses:(NSArray<Class>*)cellClasses
           configureCellBlock:(CellConfigureBlock)configureCellBlock;

- (instancetype)initWithItems:(NSArray *)items
               cellIdentifier:(NSArray<NSString*> *)cellIdentifiers
                  cellClasses:(NSArray<Class>*)cellClasses
                     modelDic:(ZLSectionModel*)modelDic
           configureCellBlock:(CellConfigureBlock)configureCellBlock;



@end
