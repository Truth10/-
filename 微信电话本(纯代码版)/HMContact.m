//
//  HMContact.m
//  phoneBook
//
//  Created by mac on 16/4/26.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMContact.h"

@implementation HMContact

+ (instancetype)contactWithName:(NSString *)name andPhoneNumber:(NSString *)phoneNumber{
    //1.创建模型
    HMContact *model = [[HMContact alloc] init];
    
    //2.给模型属性赋值
    model.name = name;
    model.phoneNumber = phoneNumber;
    
    //3.返回模型
    return model;
}

#pragma mark - 归档方法
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:HM_NAME];
    [aCoder encodeObject:self.phoneNumber forKey:HM_PHONENUM];

}

#pragma mark - 解档方法

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.name = [coder decodeObjectForKey:HM_NAME];
        self.phoneNumber = [coder decodeObjectForKey:HM_PHONENUM];
    }
    return self;
}


@end
