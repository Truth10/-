//
//  HMAddController.m
//  微信电话本(纯代码版)
//
//  Created by mac on 16/5/1.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMAddController.h"
#import "HMContact.h"
@interface HMAddController ()
//姓名
@property (nonatomic,weak) UITextField *nameField;
//电话
@property (nonatomic,weak) UITextField *phoneNum;
//添加按钮
@property (nonatomic,weak) UIButton *addBtn;
@end

@implementation HMAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.搭建界面
    [self setupUI];
    //2.添加约束
    [self setupConstraints];
    
    //MARK: - 通知监听文本框的编辑事件
    //1.通知中心
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    //2.监听姓名文本框编辑
    [center addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:self.nameField];
    //3.监听电话文本框编辑
    [center addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:self.phoneNum];

    //MARK: - 监听添加按钮的点击事件
     [self.addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 按钮的点击事件
- (void)addBtnClick{
    //1.获取文本框输入的姓名和电话号码
    NSString *name = self.nameField.text;
    NSString *phoneNum = self.phoneNum.text;
    
    //2.将文本框输入的内容转化为模型
    HMContact *contact = [HMContact contactWithName:name andPhoneNumber:phoneNum];

   //MARK: - 调用block方法,实现在列表中显示保存的联系人
    if (self.addContactBlock) {
        self.addContactBlock(self,contact);
    }
    //4.把自己pop出去
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - 文本框改变事件
- (void)textChange:(NSNotification *)noti{
    //输出文本框输入的内容
    HMLog(@"%@",[[noti object] text]);
    //姓名
    NSString *name = self.nameField.text;
    
    //电话
    NSString *phoneNum = self.phoneNum.text;
    
    //只有当姓名文本框和电话文本框内都有内容的时候,添加按钮才能够点击
    if (name.length > 0 && phoneNum.length > 0) {
        self.addBtn.enabled = YES;
    }else{
        self.addBtn.enabled = NO;
    }
}


#pragma mark - 搭建界面
- (void)setupUI{
    self.navigationItem.title = @"添加联系人";//标题
    
    //姓名文本框
    UITextField *nameField = [[UITextField alloc] init];
    nameField.placeholder = @"姓名";
    nameField.clearButtonMode = UITextFieldViewModeWhileEditing;//右侧的清除按钮
    [self.view addSubview:nameField];
    self.nameField = nameField;
    
    //电话文本框
    UITextField *phoneNum = [[UITextField alloc] init];
    phoneNum.placeholder = @"电话";
    phoneNum.clearButtonMode = UITextFieldViewModeWhileEditing;//右侧的清除按钮
    [self.view addSubview:phoneNum];
    self.phoneNum = phoneNum;
    
    //添加按钮
    UIButton *addBtn = [[UIButton alloc] init];
    [addBtn setTitle:@"添加" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//给正常状态下文字设置背景色
    [addBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];//给不可用状态下文字设置背景色
    
    [self.view addSubview:addBtn];
    self.addBtn = addBtn;
    addBtn.enabled = NO;//默认按钮不能点击
    
    
}

#pragma mark - 设置约束
- (void)setupConstraints{
    //用户名文本框
    [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(124);
        make.right.equalTo(self.view).offset(-20);
    }];
    
    //电话文本框
    [self.phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.nameField);
        make.top.equalTo(self.nameField.mas_bottom).offset(30);
    }];
    
    //添加按钮
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneNum.mas_bottom).offset(70);//顶部等于密码文本框底部+90
        make.left.right.equalTo(self.nameField);//左右两侧与用户名文本框对齐
        
    }];
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
