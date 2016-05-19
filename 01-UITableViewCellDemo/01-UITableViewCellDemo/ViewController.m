//
//  ViewController.m
//  01-UITableViewCellDemo
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
        _tableView.allowsMultipleSelection = YES;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加tableView
    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)switchValueChanged:(UISwitch *)sw {
    NSLog(@"%s",__func__);
    UITableViewCell *cell = (UITableViewCell *)sw.superview;
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    NSLog(@"section:%ld   row:%ld",indexPath.section,indexPath.row);
}

#pragma mark  -UITableViewDataSource
//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
//行内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
#if 1
    //从重用队列中取出闲置单元格
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //判断cell是否为nil
    if (cell == nil) {
        //创建单元格的时候，要确保重用标示符跟获取闲置单元格的时候一致
        cell = [[UITableViewCell alloc] initWithStyle:indexPath.row % 4 reuseIdentifier:identifier];
        
        //背景
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor cyanColor];
        cell.backgroundView = bgView;
        
        //选中背景
        UIView *selectedBGView = [[UIView alloc] init];
        selectedBGView.backgroundColor = [UIColor redColor];
        //cell.selectedBackgroundView = selectedBGView;
        
        //多选的背景
        //cell.multipleSelectionBackgroundView = selectedBGView;
        
        //辅助视图
        //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        
        UISwitch *sw = [[UISwitch alloc] init];
        cell.accessoryView = sw;
        [sw addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        //选中的风格
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
#else
    //获取闲置单元格的时候重用标示符跟注册单元格的时候一致
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
#endif
    //设置imageView的图片
    NSString *iconName = [NSString stringWithFormat:@"icon%ld.jpg",indexPath.row % 6];
    cell.imageView.image = [UIImage imageNamed:iconName];
    //设置textLabel的文本
    cell.textLabel.text = self.datas[indexPath.row];
    //设置detailTextLabel的文本
    cell.detailTextLabel.text = @"我是好人，哈哈哈";
    
    //把imageView向右平移200
    CGRect iconFrame = cell.imageView.frame;
    iconFrame.origin.x += 200;
    cell.imageView.frame = iconFrame;
    return cell;
    
}

//
//sdwebimage

#pragma mark  -UITableViewDelegate
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s",__func__);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
