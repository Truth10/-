//
//  HMListController.m
//  微信电话本(纯代码版)
//
//  Created by mac on 16/5/1.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMListController.h"
#import "HMContact.h"
#import "HMListCell.h"
#import "HMAddController.h"
#import "HMEditController.h"
@interface HMListController ()

@property (nonatomic,strong) NSMutableArray *contactArrM;
@end

@implementation HMListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
    //MARK: - 删除多余的cell
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //MARK: - 删除系统自带的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

#pragma mark - 当选中某一行cell的时候,跳转到编辑VC
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.创建编辑VC
    HMEditController *editVc = [[HMEditController alloc] init];
    
    //2.把当前cell的数据模型赋值给编辑VC的模型属性
    editVc.contact = self.contactArrM[indexPath.row];
    //给编辑VC设置背景颜色
    editVc.view.backgroundColor = [UIColor whiteColor];
    
    HMLog(@"%@",editVc.contact);
    //3.跳转到编辑VC
    [self.navigationController pushViewController:editVc animated:YES];
    
    editVc.endEditBlock = ^(HMEditController *editVc){
        //刷新表格
        [self.tableView reloadData];
    
    };
    
    
#pragma mark - 编辑的时候存储一下
    [self saveContacts];
    
}


#pragma mark - 搭建界面
- (void)setUpUI{
    //MARK: - 创建带头部标题的导航条
    
    self.navigationItem.title = @"微信通讯录";
    self.navigationItem.backBarButtonItem.title = @"返回";
    //MARK: - 注销按钮
    UIBarButtonItem *cancelBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style: UIBarButtonItemStylePlain target:self action:@selector(cancelBtnItemClick)];
    self.navigationItem.leftBarButtonItem = cancelBtnItem;
    
    //MARK: - trash按钮
    UIBarButtonItem *trashBtnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(trashBtnItemClick)];
    
    //MARK: - 添加按钮
    UIBarButtonItem *addBtnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBtnItemClick)];
    
    self.navigationItem.rightBarButtonItems = @[addBtnItem,trashBtnItem];
}

#pragma mark - 注销按钮的点击事件
- (void)cancelBtnItemClick{
    //1.创建UIAlertController控制器
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定退出吗?" preferredStyle:UIAlertControllerStyleActionSheet];
    
    //2.创建按钮
    //创建注销按钮
    UIAlertAction *logOutBtn = [UIAlertAction actionWithTitle:@"注销" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //返回到登陆控制器
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    //创建取消按钮
    UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    
    //3.将按钮添加到控制器
    [alertC addAction:logOutBtn];
    [alertC addAction:cancelBtn];
    
    //4.显示控制器
    [self presentViewController:alertC animated:YES completion:nil];
}


#pragma mark - 添加按钮的点击事件
- (void)addBtnItemClick{
    //MARK: - 跳转到添加VC
    //1.创建添加VC
    HMAddController *addVc = [[HMAddController alloc] init];
    //1.1设置控制器视图的背景颜色
    addVc.view.backgroundColor = [UIColor whiteColor];
    
    //MARK: - 给Block类型的变量赋值
    addVc.addContactBlock = ^(HMAddController *addVc,HMContact *contact){
        // 1.将传进来的模型添加到模型数组中
        [self.contactArrM addObject:contact];
        
        //2.获取最后一行cell的索引
        NSIndexPath *path = [NSIndexPath indexPathForItem:(self.contactArrM.count - 1) inSection:0];
        
        //3.直接刷新最后一行cell
        [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
        
#pragma mark - 1.添加数据的时候,存储一下
        [self saveContacts];
        
    };
    
    
    //2.跳转到添加VC
    [self.navigationController pushViewController:addVc animated:YES];
}


#pragma mark - trash按钮的点击事件
//MARK: - 显示减号
- (void)trashBtnItemClick{
    //显示减号
    self.tableView.editing = !self.tableView.isEditing;
    
}
//MARK: - 实现此代理方法,即可实现向左滑动,显示delete按钮
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.从集合中删除对应的联系人
    [self.contactArrM removeObjectAtIndex:indexPath.row];
    
    //2.刷新列表
    [self.tableView reloadData];
    
#pragma mark - 3.删除数据的时候,保存一下
    [self saveContacts];
}


//MARK: - 修改向左滑动后,右侧显示的删除按钮的title
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

#pragma mark - 保存用户数据的方法
- (void)saveContacts{
    //1.获取文件路径
    NSString *filePath = [self filePathWithName:@"contacts.plist"];
    
    //2.保存
    [NSKeyedArchiver archiveRootObject:self.contactArrM toFile:filePath];
    
}

//MARK: - 返回存储文件路径的方法
- (NSString *)filePathWithName:(NSString *)fileName {
    
    // 1.doc的路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 2.拼接文件路径并返回
    return [docPath stringByAppendingPathComponent:fileName];
}

#pragma mark - tableView数据源方法
//MARK: - 返回组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
//MARK: - 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.contactArrM.count;
}

#pragma mark - tableView代理方法
//MARK: - 返回每一组每一行都是什么内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //1.创建cell
    HMListCell *cell = [HMListCell cellWithTableView:tableView];
    //2.设置数据
    cell.contact = self.contactArrM[indexPath.row];
    //3.返回cell
    return cell;
}

#pragma mark - 懒加载模型数组
- (NSMutableArray *)contactArrM{
    if (_contactArrM == nil) {
        //        _contactArrM = [NSMutableArray array];
        //
        //        //1.创建模型
        //        HMContact *contact = [HMContact contactWithName:@"姚明" andPhoneNumber:@"13828282828"];
        //        HMContact *contact1 = [HMContact contactWithName:@"刘翔" andPhoneNumber:@"15858585858"];
        //        //2.添加到模型数组中
        //        [_contactArrM addObject:contact];
        //        [_contactArrM addObject:contact1];
        
        //MARK: - 读取数据
        //1.获取文件路径
        NSString *filePath = [self filePathWithName:@"contacts.plist"];
        
        //2.读取数据
        _contactArrM = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        
        //MARK: - 避免数组为空
        if (_contactArrM == nil) {
            _contactArrM = [NSMutableArray array];
            
        }
        
    }
    return _contactArrM;
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
