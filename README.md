# ZLCellDataSource
mvvm，mvp的应用。为viewcontroller瘦身，把tableview和collectionview的datasource提取出来，可节省1/3的代码量。

### 版本

#### 0.3.0
* 增加多个cell的操作，需要实现代理方法

#### 0.2.3
* 多section的操作加入了复杂类型，具体要指定一下ZLSectionModel<br>
  firstClassName : 为第一层数组的数据class类名
  secondVariate : 为第二层数组对应的元素变量名

#### 0.2.2
* 增加了多section的class数组没传全，自动以最后一个class来填充全

#### 0.2.1
* 修改了多section的bug

#### 0.2.0
* 增加多section的datasource提取


### 支持cocoapod导入


```
pod 'ZLCellDataSource'
```


### ZLCellDataSource

把UITableView和UICollectionView的代理提取出来，使用者只需要在UIViewController类中定义好ZLCellDataSource* dataSource的对象，并实现它的block即可，并且主要要将dataSource赋值给UITableView的dataSource。同理UICollectionView也是如此。

```Objective-C
@interface ViewController ()

@property(nonatomic,strong)NSMutableArray* array;
//注意dataSource一定要声明为类的成员变量，才能生效。
@property(nonatomic,strong)ZLCellDataSource* dataSource;
@property(nonatomic,strong)UITableView* tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.array = [NSMutableArray new];
    for (int i=0; i<50; i++) {
        [self.array addObject:[NSString stringWithFormat:@"行数-----%d",i]];
    }
    
    /*
     block原来是(id cell, id item, NSIndexPath *indexPath)
     需要将cell和item的id类型替换成自己实际使用的cell类和item类
     如以下我是UITableViewCell*类和NSString*类
     */
    self.dataSource = [[ZLCellDataSource alloc]initWithItems:self.array cellIdentifier:@"ZLCell" configureCellBlock:^(UITableViewCell* cell, NSString* item, NSIndexPath *indexPath) {
        cell.textLabel.text = item;
        cell.textLabel.textColor = [UIColor redColor];
    }];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    /*
     以下两步一定要
     将self.dataSource赋值过来，才能生效
     必须注册cell的类
    */
    self.tableView.dataSource = self.dataSource;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ZLCell"];
    [self.view addSubview:self.tableView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

```

### ZLSectionDataSource

同理，实现函数

```Objective-C
- (instancetype)initWithItems:(NSArray *)items
               cellIdentifier:(NSArray<NSString*> *)cellIdentifiers
           configureCellBlock:(CellConfigureBlock)configureCellBlock;
```

和单个section不同的是，cellIdentifiers需要传入数组，也可以只传入一个元素，ZLSectionDataSource会自动帮你把所有的section都匹配为同一个cellIdentifiers。

举例：
```Objective-C
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.users = [NSMutableArray new];
    for (int i=0; i<5; i++) {
        User* user = [User new];
        user.name = @"czl";
        user.phone = @"1111";
        user.age = 20;
        
        NSMutableArray* arr = [NSMutableArray new];
        for (int j=0; j<3; j++) {
            Address* addr = [Address new];
            addr.province = @"fujian";
            addr.city = @"xiamen";
            addr.address = @"123123123123";
            [arr addObject:addr];
        }
        
        user.addresses = arr;
        [self.users addObject:user];
    }
    
    ZLSectionModel* model = [ZLSectionModel new];
    model.firstClassName = @"User";
    model.secondVariate = @"addresses";
    
    self.dataSource = [[ZLSectionDataSource alloc]initWithItems:self.users cellIdentifier:@[@"UserCell"] cellClasses:@[UserCell.class] modelDic:model configureCellBlock:^(UserCell* cell, Address* item, NSIndexPath *indexPath) {
        cell.address = item;
    }];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    [self.tableView registerClass:UserCell.class forCellReuseIdentifier:@"UserCell"];
    [self.tableView registerClass:UserHeader.class forHeaderFooterViewReuseIdentifier:@"UserHeader"];
    [self.view addSubview:self.tableView];
}
```

### ZLBaseViewModel

实现viewmodel，把网络请求等数组处理也剥离开来

使用时候请继承ZLBaseViewModel。把网络请求函数写在你自己定义的viewmodel类中，让viewcontroller来调用。



