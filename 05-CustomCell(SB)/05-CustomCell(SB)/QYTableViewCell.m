//
//  QYTableViewCell.m
//  05-CustomCell(SB)
//
//  Created by qingyun on 16/4/11.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYTableViewCell.h"
#import "QYCellModel.h"
@interface QYTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *sw;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation QYTableViewCell
//借用setCellModel方法，设置子视图属性
-(void)setCellModel:(QYCellModel *)cellModel {
    _cellModel = cellModel;
    
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
