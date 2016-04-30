//
//  HMLoginController.m
//  微信电话本(纯代码版)
//
//  Created by mac on 16/5/1.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMLoginController.h"

@interface HMLoginController ()

@property (nonatomic,weak) UITextField *nameField;//用户名
@property (nonatomic,weak) UITextField *passwordField;//密码
@property (nonatomic,weak) UILabel *remLbl;//记住密码标签
@property (nonatomic,weak) UILabel *autoLoginLbl;//自动登录标签
@property (nonatomic,weak) UISwitch *remSwitch;//记住密码开关
@property (nonatomic,weak) UISwitch *autoLoginSwitch;//自动登录开关
@property (nonatomic,weak) UIButton *loginBtn;//登录按钮

@end

@implementation HMLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置界面
    [self setUpUI];
    
    //添加约束
    [self setUpConstraints];
}
#pragma mark - 设置界面
- (void)setUpUI{
    //用户名文本框
    UITextField *nameField = [[UITextField alloc] init];
    nameField.placeholder = @"请输入用户名";
    nameField.clearButtonMode = UITextFieldViewModeWhileEditing;//右侧的清除按钮
    [self.view addSubview:nameField];
    self.nameField = nameField;
    
    //密码文本框
    UITextField *passwordField = [[UITextField alloc] init];
    passwordField.placeholder = @"请输入密码";
    passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;//右侧的清除按钮
    [self.view addSubview:passwordField];
    self.passwordField = passwordField;
    
    //记住密码标签
    UILabel *remLbl = [[UILabel alloc] init];
    remLbl.text = @"记住密码";
    [self.view addSubview:remLbl];
    self.remLbl = remLbl;
    
    //自动登录标签
    UILabel *autoLoginLbl = [[UILabel alloc] init];
    autoLoginLbl.text = @"自动登录";
    [self.view addSubview:autoLoginLbl];
    self.autoLoginLbl = autoLoginLbl;

    //记住密码开关
    UISwitch *remSwitch = [[UISwitch alloc] init];
    [self.view addSubview:remSwitch];
    self.remSwitch = remSwitch;
    
    //自动登录开关
    UISwitch *autoLoginSwitch = [[UISwitch alloc] init];
    [self.view addSubview:autoLoginSwitch];
    self.autoLoginSwitch = autoLoginSwitch;
    
    //登录按钮
    UIButton *loginBtn = [[UIButton alloc] init];
    [self.view addSubview:loginBtn];
    self.loginBtn = loginBtn;
    

}

#pragma mark - 设置约束
- (void)setUpConstraints{


}
@end
