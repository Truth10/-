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
    self.navigationItem.title = @"欢迎使用微信电话本";//标题
    
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
    [loginBtn setTitle:@"登  录" forState:UIControlStateNormal];
    loginBtn.backgroundColor = [UIColor blueColor];
    //loginBtn.
    [self.view addSubview:loginBtn];
    self.loginBtn = loginBtn;
   // loginBtn.enabled = NO;//默认按钮不能点击
    
    
}

#pragma mark - 设置约束
- (void)setUpConstraints{
    //用户名文本框
    [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(124);
        make.right.equalTo(self.view).offset(-20);
    }];
    
    //密码文本框
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.nameField);
        make.top.equalTo(self.nameField.mas_bottom).offset(30);
    }];
    
    //记住密码标签
    [self.remLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passwordField);
        make.top.equalTo(self.passwordField.mas_bottom).offset(30);
    }];
    
    //记住密码开关
    [self.remSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.remLbl.mas_right).offset(20);
        make.centerY.equalTo(self.remLbl);
    }];
    
    //自动登录开关
    [self.autoLoginSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.nameField);//右侧与文本框对齐
        make.centerY.equalTo(self.remLbl);//与记住密码标签垂直中心对齐
    }];
    
    //自动登录标签
    [self.autoLoginLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.autoLoginSwitch.mas_left).offset(-20);//自动登录标签右部x等于自动登录开关左侧x-20
        make.centerY.equalTo(self.remLbl);//与记住密码标签垂直中心对齐
    }];
    
    //登录按钮
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordField.mas_bottom).offset(90);//顶部等于密码文本框底部+90
        make.left.right.equalTo(self.nameField);//左右两侧与用户名文本框对齐
    
    }];
    
}


@end
