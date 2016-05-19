//
//  QYTableViewCell.m
//  04-CustomCell(XIB)
//
//  Created by qingyun on 16/4/11.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYTableViewCell.h"
#import "QYCellModel.h"
@interface QYTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *sw;
//定义属性名称的时候，要避免与它本身的属性（即使从父类继承的）重名
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation QYTableViewCell

//对子视图属性设置
-(void)setCellModel:(QYCellModel *)cellModel {
    //1、对属性的成员变量赋值
    _cellModel = cellModel;
    //2、子视图属性设置
    _titleLabel.text = cellModel.title;
    _sw.on = cellModel.on;
    _imgView.image = [UIImage imageNamed:cellModel.icon];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
