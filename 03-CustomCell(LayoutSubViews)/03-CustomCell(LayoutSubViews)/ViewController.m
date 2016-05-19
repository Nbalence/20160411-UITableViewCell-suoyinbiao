//
//  ViewController.m
//  03-CustomCell(LayoutSubViews)
//
//  Created by qingyun on 16/4/11.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"
#import "QYTableViewCell.h"
#import "QYCellModel.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *datas;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //行高
    _tableView.rowHeight = 80;
    //注册单元格
    [_tableView registerClass:[QYTableViewCell class] forCellReuseIdentifier:identifier];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark  - UITabelViewDataSource
//行数
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

//行内容
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
#if 0
    cell.textLabel.text = self.datas[indexPath.row];
    NSString *iconName = [NSString stringWithFormat:@"icon%ld.jpg",indexPath.row % 6];
    cell.imageView.image = [UIImage imageNamed:iconName];
#else
    cell.cellModel = self.datas[indexPath.row];
#endif
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
