//
//  HMContact.h
//  phoneBook
//
//  Created by mac on 16/4/26.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMContact : NSObject<NSCoding>

//姓名
@property (nonatomic,copy) NSString *name;

//电话
@property (nonatomic,copy) NSString *phoneNumber;

//类方法生成模型
+ (instancetype)contactWithName:(NSString *)name andPhoneNumber:(NSString *)phoneNumber;
@end
