//
//  CitysViewController.m
//  ZLCellDataSource
//
//  Created by zhaoliang chen on 2019/9/29.
//  Copyright © 2019 github. All rights reserved.
//

#import "CitysViewController.h"
#import "ZLSectionDataSource.h"
#import "CollectionHeaderView.h"
#import "CollectionCellView.h"

@interface CitysViewController ()
<ZLSectionDataSourceDelegate>

@property(nonatomic,strong)NSMutableArray* cities;
@property(nonatomic,strong)ZLSectionDataSource* dataSource;
@property(nonatomic,strong)UICollectionView* collectionView;

@end

@implementation CitysViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.collectionView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //self.dataSource.test = @"1111";
        [self.cities addObject:@[@"福州",@"青岛",@"济南",@"大连",@"广州"]];
        [self.collectionView reloadData];
    });
}


- (NSString*)getSectionHeaderIdentifierByIndex:(NSInteger)section {
    return @"CollectionHeaderView";
}

- (NSMutableArray *)cities{
    if(!_cities){
        _cities = ({
            NSMutableArray * object = [[NSMutableArray alloc]init];
            [object addObject:@[@"厦门"]];
            [object addObject:@[@"北京",@"上海",@"南京",@"杭州",@"深圳"]];
            object;
       });
    }
    return _cities;
}

- (ZLSectionDataSource *)dataSource{
    if(!_dataSource){
        _dataSource = ({
            ZLSectionDataSource * object = [[ZLSectionDataSource alloc]initWithItems:self.cities cellIdentifier:@[@"CollectionCellView"] cellClasses:@[[CollectionCellView class]] modelDic:nil delegate:self configureCellBlock:^(CollectionCellView* cell, NSString* item, NSIndexPath *indexPath) {
                cell.label.text = item;
            } configureSectionBlock:^(CollectionHeaderView *section, NSIndexPath *indexPath) {
                if (indexPath.section==0) {
                    section.titleLabel.text = @"当前城市";
                    section.backgroundColor = [UIColor grayColor];
                } else if (indexPath.section == 1) {
                    section.backgroundColor = [UIColor blueColor];
                    section.titleLabel.text = @"热门城市";
                } else {
                    section.backgroundColor = [UIColor greenColor];
                    section.titleLabel.text = @"全部城市";
                }
            }];
            object;
       });
    }
    return _dataSource;
}

- (UICollectionView *)collectionView{
    if(!_collectionView){
        _collectionView = ({
            UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
            layout.minimumLineSpacing = 0;
            layout.minimumInteritemSpacing = 5;
            layout.itemSize = CGSizeMake(100, 50);
            layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 40);
            UICollectionView * object = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
            object.dataSource = self.dataSource;
            object.backgroundColor = [UIColor whiteColor];
            [object registerClass:[CollectionCellView class] forCellWithReuseIdentifier:@"CollectionCellView"];
            [object registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHeaderView"];
            object;
       });
    }
    return _collectionView;
}
@end
