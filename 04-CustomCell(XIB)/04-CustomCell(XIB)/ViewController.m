//
//  ViewController.m
//  04-CustomCell(XIB)
//
//  Created by qingyun on 16/4/11.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"
#import "QYCellModel.h"
#import "QYTableViewCell.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController
static NSString *identifier = @"cell";
-(NSArray *)datas {
    if (_datas == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Test" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            QYCellModel *cellModel = [QYCellModel modelWithDictionary:dict];
            [models addObject:cellModel];
        }
        _datas = models;
    }
    return _datas;
}
//懒加载tableView
-(UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        //设置数据源和代理
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //设置行高
        _tableView.rowHeight = 80;
        
        //使用第二种获取闲置单元格的方式，必须注册单元格
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QYTableViewCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加tableView
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark  -UITabelViewDataSource

//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

//行内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
#if 0
    QYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"QYTableViewCell" owner:self options:nil][0];
    }
#else
    QYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
#endif
    cell.cellModel = self.datas[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
