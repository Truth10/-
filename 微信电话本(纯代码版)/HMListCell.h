//
//  HMListCell.h
//  phoneBook
//
//  Created by mac on 16/4/27.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HMContact;
@interface HMListCell : UITableViewCell
/**
 *  数据模型
 */
@property (nonatomic,strong) HMContact *contact;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
