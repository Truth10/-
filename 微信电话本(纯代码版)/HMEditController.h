//
//  HMEditController.h
//  微信电话本(纯代码版)
//
//  Created by mac on 16/5/1.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMContact,HMEditController;
//1.定义block
typedef void (^finishEditBlock)(HMEditController *);
@interface HMEditController : UIViewController

//模型属性
@property (nonatomic,strong) HMContact *contact;

//2.定义block属性
@property (nonatomic,copy) finishEditBlock endEditBlock;
@end
