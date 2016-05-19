//
//  ViewController.m
//  02-CustomCell(contentView)
//
//  Created by qingyun on 16/4/11.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *datas;
@end

@implementation ViewController

static NSString *identifier = @"cell";
-(NSArray *)datas {
    if (_datas == nil) {
        _datas = @[@"zhangsan",@"lisi",@"wangwu",@"zhaoliu",@"tianqi",@"songba"];
    }
    return _datas;
}

-(UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        //设置数据源和代理
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //设置行高
        _tableView.rowHeight = 80;
        
        //使用第二种获取闲置单元格的方式的时候必须注册单元格
        //[_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
        
        //设置允许多选
        //_tableView.allowsMultipleSelection = YES;
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //添加tableView
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark  -UITableViewDataSource
//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
//行内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //从重用队列中取出闲置单元格
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //判断cell是否为nil
    if (cell == nil) {
        //创建单元格的时候，要确保重用标示符跟获取闲置单元格的时候一致
        cell = [[UITableViewCell alloc] initWithStyle:indexPath.row % 4 reuseIdentifier:identifier];
        //添加右边的图标
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(tableView.frame) - 60 - 20, 10, 60, 60)];
        [cell.contentView addSubview:iconView];
        iconView.tag = 101;
        
        //添加左边的标题Label
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, CGRectGetWidth(cell.frame) - 100, 60)];
        [cell.contentView addSubview:titleLabel];
        titleLabel.tag = 102;
    }
    
    UIImageView *iconView = [cell.contentView viewWithTag:101];
    UILabel *titleLabel = [cell.contentView viewWithTag:102];
    
    //设置内容
    NSString *iconName = [NSString stringWithFormat:@"icon%ld.jpg",indexPath.row % 6];
    iconView.image = [UIImage imageNamed:iconName];
    
    titleLabel.text = self.datas[indexPath.row];
    
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
