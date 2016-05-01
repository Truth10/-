//
//  HMEditController.m
//  微信电话本(纯代码版)
//
//  Created by mac on 16/5/1.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMEditController.h"
#import "HMContact.h"
@interface HMEditController ()
//姓名
@property (nonatomic,weak) UITextField *nameField;
//电话
@property (nonatomic,weak) UITextField *phoneNum;
//添加按钮
@property (nonatomic,weak) UIButton *saveBtn;
//编辑按钮
@property (nonatomic,weak) UIBarButtonItem *editBtnItem;
@end

@implementation HMEditController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.搭建界面
    [self setupUI];
    //2.添加约束
    [self setupConstraints];
    HMLog(@"edit--%@",self.contact);
    //MARK: - 显示列表中选中行的数据
    self.nameField.text = self.contact.name;
    self.phoneNum.text = self.contact.phoneNumber;
    
    //MARK: - 监听保存按钮的点击事件
    [self.saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 保存按钮的点击事件
- (void)saveBtnClick{
    //1.直接修改模型数据
    self.contact.name = self.nameField.text;
    self.contact.phoneNumber = self.phoneNum.text;
    
    //    self.contact = [HMContact contactWithName:name andPhoneNumber:phoneNum];
    
    //2.调用代理方法刷新列表
    //    if ([self.delegate respondsToSelector:@selector(saveEditedData:)]) {
    //        [self.delegate saveEditedData:self];
    //    }
    
    //2.调用block方法刷新列表
    if (self.endEditBlock) {
        self.endEditBlock(self);
    }
    //3.自己pop出去
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 搭建界面
- (void)setupUI{
    self.navigationItem.title = @"编辑联系人";//标题
    //导航条上的编辑按钮
    UIBarButtonItem *editBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editBtnItemClick:)];
    self.navigationItem.rightBarButtonItem = editBtnItem;
    self.editBtnItem = editBtnItem;
    
    //姓名文本框
    UITextField *nameField = [[UITextField alloc] init];
    nameField.placeholder = @"姓名";
    nameField.clearButtonMode = UITextFieldViewModeWhileEditing;//右侧的清除按钮
    [self.view addSubview:nameField];
    //默认不能编辑
    nameField.enabled = NO;
    self.nameField = nameField;
    
    //电话文本框
    UITextField *phoneNum = [[UITextField alloc] init];
    phoneNum.placeholder = @"电话";
    phoneNum.clearButtonMode = UITextFieldViewModeWhileEditing;//右侧的清除按钮
    [self.view addSubview:phoneNum];
    //默认不能编辑
    phoneNum.enabled = NO;
    self.phoneNum = phoneNum;
    
    //保存按钮
    UIButton *saveBtn = [[UIButton alloc] init];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//给正常状态下文字设置背景色
    //[saveBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];//给不可用状态下文字设置背景色
    
    [self.view addSubview:saveBtn];
    //保存按钮默认隐藏
    saveBtn.hidden = YES;
    self.saveBtn = saveBtn;
    
}

#pragma mark - 当点击编辑按钮时来调用此方法
- (void)editBtnItemClick:(UIBarButtonItem *)sender{
    //MARK: - 点击"编辑"按钮
    if ([self.editBtnItem.title isEqualToString:@"编辑"]) {
        //1.点击后"编辑"变为"取消"
        self.editBtnItem.title = @"取消";
        
        //2.两个文本框均可以编辑
        self.nameField.enabled = YES;
        self.phoneNum.enabled = YES;
        
        //3.添加按钮隐藏
        self.saveBtn.hidden = NO;
        
    }else if([self.editBtnItem.title isEqualToString:@"取消"]){
        //MARK: - 点击"取消"按钮
        //1.点击取消后显示文字是"编辑"
        self.editBtnItem.title = @"编辑";
        
        //2.两个文本框均不能编辑
        self.nameField.enabled = NO;
        self.phoneNum.enabled = NO;
        
        //3.添加按钮隐藏
        self.saveBtn.hidden = YES;
        
    }
    
    
    
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
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneNum.mas_bottom).offset(70);//顶部等于密码文本框底部+90
        make.left.right.equalTo(self.nameField);//左右两侧与用户名文本框对齐
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
