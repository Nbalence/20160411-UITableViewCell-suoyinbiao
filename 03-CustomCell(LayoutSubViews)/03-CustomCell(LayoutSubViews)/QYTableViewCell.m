//
//  QYTableViewCell.m
//  03-CustomCell(LayoutSubViews)
//
//  Created by qingyun on 16/4/11.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYTableViewCell.h"
#import "QYCellModel.h"

@interface QYTableViewCell ()
@property (nonatomic, strong) UISwitch *sw;
@end

@implementation QYTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //添加其他子视图
        UISwitch *sw = [[UISwitch alloc] init];
        [self.contentView addSubview:sw];
        
        _sw = sw;
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    //重新布局子视图
    self.textLabel.frame = CGRectMake(10, 10, 200, 60);
    self.imageView.frame = CGRectMake(375 - 60 - 10, 10, 60, 60);
    _sw.frame = CGRectMake(220, 25, 0, 0);
}

-(void)setCellModel:(QYCellModel *)cellModel {
    //对属性赋值
    _cellModel = cellModel;
    
    //设置子视图属性
    self.textLabel.text = cellModel.title;
    self.imageView.image = [UIImage imageNamed:cellModel.icon];
    _sw.on = cellModel.on;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
