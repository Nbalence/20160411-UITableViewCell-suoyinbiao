//
//  ViewController.m
//  06-索引表
//
//  Created by qingyun on 16/4/11.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) NSArray *keys;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController
static NSString *identifier = @"cell";
//加载数据
-(void)loadDictionaryForFile {
    //获取数据文件的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sortednames" ofType:@"plist"];
    _dict = [NSDictionary dictionaryWithContentsOfFile:path];
    _keys = [_dict.allKeys sortedArrayUsingSelector:@selector(compare:)];
}

//懒加载tableView
-(UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        //设置数据源和代理
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //注册单元格
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
        
        //索引表视图对应的属性
        //限制显示右边索引的最新行数
        _tableView.sectionIndexMinimumDisplayRowCount = 1000;
        //索引文字颜色
        _tableView.sectionIndexColor = [UIColor redColor];
        //索引条的背景颜色
        _tableView.sectionIndexBackgroundColor = [UIColor greenColor];
        //点击的时候索引条的背景颜色
        _tableView.sectionIndexTrackingBackgroundColor = [UIColor blueColor];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDictionaryForFile];
    //添加tableView
    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark -UITableViewDataSource
//组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _keys.count;
}

//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //取出当前section数据对应的key
    NSString *key = _keys[section];
    //当前section对应的array
    NSArray *array = _dict[key];
    return array.count;
}

//行内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    //取出当前section数据对应的key
    NSString *key = _keys[indexPath.section];
    //当前section对应的array
    NSArray *array = _dict[key];
    cell.textLabel.text = array[indexPath.row];
    return cell;
}

//设置section头标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _keys[section];
}

//section索引
-(NSArray <NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return _keys;
}

//当点击索引条上的索引，跳转至对应的section
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return index + 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
