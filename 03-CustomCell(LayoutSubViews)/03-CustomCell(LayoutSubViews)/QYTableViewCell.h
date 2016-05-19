//
//  QYTableViewCell.h
//  03-CustomCell(LayoutSubViews)
//
//  Created by qingyun on 16/4/11.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QYCellModel;
@interface QYTableViewCell : UITableViewCell
@property (nonatomic, strong) QYCellModel *cellModel;
@end
