//
//  HMLoginController.m
//  微信电话本(纯代码版)
//
//  Created by mac on 16/5/1.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMLoginController.h"
#import "HMListController.h"
#define HM_USERNAME @"HM_USERNAME"//用户名
#define HM_PASSWORD @"HM_PASSWORD"//密码
#define HM_REMSWITCH @"HM_REMSWITCH"//密码
#define HM_AUTOSWITCH @"HM_AUTOSWITCH"//密码
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
#pragma mark - 当控制器的view加载完成时来调用此方法
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置界面
    [self setUpUI];
    
    //添加约束
    [self setUpConstraints];
    
#pragma mark - 读取用户登录信息
    //1.创建偏好设置对象
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //2.读取数据
    self.nameField.text = [defaults objectForKey:HM_USERNAME];
    self.passwordField.text = [defaults objectForKey:HM_PASSWORD];
    self.remSwitch.on = [defaults boolForKey:HM_REMSWITCH];
    self.autoLoginSwitch.on = [defaults boolForKey:HM_AUTOSWITCH];
    HMLog(@"%@",self.nameField.text);
    //3.执行相应的操作
    //如果记住密码开关关闭
    if (!self.remSwitch.isOn) {
        //将密码框文字设为nil
        self.passwordField.text = nil;
    }
    //如果自动登录开关打开,就点击登录按钮
    if (self.autoLoginSwitch.isOn) {
        [self loginBtnClick:self.loginBtn];
    }
    
    
    
    //MARK: - 监听文本框的编辑事件
    [self.nameField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self.passwordField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    
    //MARK: - 监听开关的值改变事件
    [self.remSwitch addTarget:self action:@selector(remSwitchValueChange:) forControlEvents:UIControlEventValueChanged];
    [self.autoLoginSwitch addTarget:self action:@selector(autoLoginSwitchValueChange:) forControlEvents:UIControlEventValueChanged];
    
    //MARK: - 监听按钮的点击事件
    [self.loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //调用文本框的编辑事件,判断文本框内容是否为空
    [self textChange:nil];
}

#pragma mark - 文本框的编辑事件
- (void)textChange:(UITextField *)sender{
    //MARK: - 获取文本框数据
    NSString *name = self.nameField.text;
    NSString *password = self.passwordField.text;
    
    HMLog(@"%@",sender.text);
    //当两个文本框内内容都不为空时登录按钮才能点击
    if (name.length > 0 && password.length > 0) {
        self.loginBtn.enabled = YES;
    }else{
        self.loginBtn.enabled = NO;
    }
}

#pragma mark - 开关的值改变事件,开关的联动
//记录密码开关
- (void)remSwitchValueChange:(UISwitch *)sender{
    //如果记录密码开关关闭,则自动登录开关也必须关闭
    if (!self.remSwitch.isOn) {
        self.autoLoginSwitch.on = NO;
        
    }

}

//自动登录开关
- (void)autoLoginSwitchValueChange:(UISwitch *)sender{
    //如果自动登录开关打开,则记录密码开关也必须打开
    if (self.autoLoginSwitch.isOn) {
        self.remSwitch.on = YES;
        
    }
    
}
#pragma mark - 按钮的点击事件
- (void)loginBtnClick:(UIButton *)sender{
    HMLog(@"登录按钮被点击了");
    //1.获取用户名和密码
    NSString *name = self.nameField.text;
    NSString *password = self.passwordField.text;
    
#pragma mark - 显示登录动画
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];//添加到父控件
    hud.mode = MBProgressHUDAnimationFade;//只显示文本
    hud.labelText = @"正在登录中...";//显示的内容
    [hud show:YES];
    
    //延迟2秒执行下边的代码
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //2.如果用户名和密码输入正确,则登录成功,并跳转到列表VC
        if ([name isEqualToString:@"wang"] && [password isEqualToString:@"0510"]) {
            //1.隐藏登录动画
            [hud hide:NO];
            [hud removeFromSuperview];//从父控件移除
            
            //2.创建列表控制器
            HMListController *listVc = [[HMListController alloc] init];

            //3.跳转到列表控制器
            [self.navigationController pushViewController:listVc animated:YES];
            
            //4.保存用户登录信息
            //4.1创建偏好设置对象
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            //4.2保存数据
            [defaults setObject:name forKey:HM_USERNAME];
            [defaults setObject:password forKey:HM_PASSWORD];
            [defaults setBool:self.remSwitch.isOn forKey:HM_REMSWITCH];
            [defaults setBool:self.autoLoginSwitch.isOn forKey:HM_AUTOSWITCH];

            //4.3同步
            [defaults synchronize];
            HMLog(@"%@",NSHomeDirectory());
        }else {
            
            //仅显示文字
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"您输入的用户名或密码错误";
            //显示1秒后隐藏
            [hud hide:YES afterDelay:1.0];
        
        }
        
    });
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
    passwordField.secureTextEntry = YES;//密文显示
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
    [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//给正常状态下文字设置背景色
    [loginBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];//给不可用状态下文字设置背景色
    
    [self.view addSubview:loginBtn];
    self.loginBtn = loginBtn;
    loginBtn.enabled = NO;//默认按钮不能点击
    
    
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
