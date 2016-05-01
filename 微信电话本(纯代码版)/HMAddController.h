//
//  HMAddController.h
//  微信电话本(纯代码版)
//
//  Created by mac on 16/5/1.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMAddController,HMContact;

#pragma mark - 1.定义block
typedef void (^addBlock)(HMAddController *addVc,HMContact *contact);

@interface HMAddController : UIViewController

#pragma mark - 2.定义block属性
@property (nonatomic,copy) addBlock addContactBlock;

@end
