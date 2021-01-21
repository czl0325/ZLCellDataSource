//
//  PTCellDataSource.h
//  bodhi
//
//  Created by zhaoliang chen on 2018/8/7.
//  Copyright © 2018年 英联(厦门)金融技术服务股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ZLCellDataSourceDelegate <NSObject>
@required

- (NSString*)getCellIdentifierByIndex:(NSIndexPath*)indexPath;

@end

typedef void (^CellConfigureBlock)(id cell, id item, NSIndexPath *indexPath);
typedef void (^HeaderConfigureBlock)(id header, NSInteger *section);

@interface ZLCellDataSource : NSObject
<UITableViewDataSource,UICollectionViewDataSource>

//适用于单一的cell
- (instancetype)initWithItems:(NSArray *)items
               cellIdentifier:(NSString *)cellIdentifier
           configureCellBlock:(CellConfigureBlock)configureCellBlock;

//适用于多种样式的cell，需要实现代理
- (instancetype)initWithItems:(NSArray*)items
                     delegate:(id<ZLCellDataSourceDelegate>)delegate
           configureCellBlock:(CellConfigureBlock)configureCellBlock;

//适用于独立tableViewCellStyle
- (instancetype)initWithItems:(NSArray*)items
                        style:(UITableViewCellStyle)style
           configureCellBlock:(CellConfigureBlock)configureCellBlock;

- (instancetype)itemAtIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, strong) NSArray* items;
@property (nonatomic, copy) NSString* cellIdentifier;
@property (nonatomic, copy) CellConfigureBlock configureCellBlock;
@property (nonatomic, weak) id<ZLCellDataSourceDelegate> delegate;
@property (nonatomic, assign) UITableViewCellStyle style;

@end
