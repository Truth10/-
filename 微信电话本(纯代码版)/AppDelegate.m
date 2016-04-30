//
//  AppDelegate.m
//  微信电话本(纯代码版)
//
//  Created by mac on 16/5/1.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "AppDelegate.h"
#import "HMLoginController.h"
#import "HMListController.h"
#import "HMAddController.h"
#import "HMEditController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //1.实例化窗口对象
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
#pragma mark - 创建几个子控制器
    HMLoginController *loginVc = [[HMLoginController alloc] init];
//    HMListController *listVc = [[HMListController alloc] init];
//    HMAddController *addVc = [[HMAddController alloc] init];
//    HMEditController *editVc = [[HMEditController alloc] init];
    //设置子控制器的颜色
    loginVc.view.backgroundColor = [UIColor whiteColor];
//    addVc.view.backgroundColor = [UIColor whiteColor];
//    editVc.view.backgroundColor = [UIColor whiteColor];
    
    //2.创建导航控制器,同时指定其根控制器为登录控制器
    UINavigationController *naVc = [[UINavigationController alloc] initWithRootViewController:loginVc];
    
    
#pragma mark - 管理子控制器
  //  [naVc pushViewController:loginVc animated:YES];
//    [naVc pushViewController:listVc animated:YES];
//    [naVc pushViewController:addVc animated:YES];
//    [naVc pushViewController:editVc animated:YES];
    
    //3.将导航控制器设置为窗口的根控制器
    self.window.rootViewController = naVc;
    
    //4.将窗口设置为控制器的主窗口并可见
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
