//
//  HMListCell.m
//  phoneBook
//
//  Created by mac on 16/4/27.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMListCell.h"
#import "HMContact.h"


@interface HMListCell (){
    
    /**
     *  分割线
     */
    UIView *_divideLine;
}

@end


@implementation HMListCell

//类方法创建cell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    //1.创建重用标识
    static NSString *ID = @"contact";
    
    //2.从缓存池中找带有重用标识的cell
    HMListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    //3.如果找不到,就创建才有重用标识的cell
    if (cell == nil) {
        cell = [[HMListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    //设置辅助视图
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //创建下划线
    [cell setUpseparateLine];
    //4.返回cell
    return cell;
    
}

//#pragma mark - 创建分割线
//MARK: - 纯代码创建cell时
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpseparateLine];
    }
    return self;
}

//MARK: - xib创建cell时
- (void)awakeFromNib{
    [self setUpseparateLine];
    
}

//MARK: - 创建分割线的方法
- (void)setUpseparateLine{
    //1.创建分割线
    UIView *divideLine = [[UIView alloc] init];
    
    //设置颜色
    divideLine.backgroundColor = [UIColor lightGrayColor];
    
    divideLine.alpha = 0.5;
    
    
    
    //2.添加到父控件
    [self.contentView addSubview:divideLine];
    
    _divideLine = divideLine;
    
}

//MARK: - 设置frame
- (void)layoutSubviews{
#warning mark - 一定要super一下
    [super layoutSubviews];
    
    CGFloat divideLineW = self.bounds.size.width;
    CGFloat divideLineH = 1;
    CGFloat divideLineX = 0;
    CGFloat divideLineY = self.bounds.size.height - divideLineH;
    
    _divideLine.frame = CGRectMake(divideLineX, divideLineY, divideLineW, divideLineH);
}

#pragma mark - 重写模型属性set方法给控件属性赋值.
- (void)setContact:(HMContact *)contact{
    _contact = contact;
    
    self.textLabel.text = contact.name;
    
    self.detailTextLabel.text = contact.phoneNumber;
    
}


@end
