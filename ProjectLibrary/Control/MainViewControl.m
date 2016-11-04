//
//  MainViewControl.m
//  DoctorClinet
//
//  Created by xuyong on 16/9/9.
//  Copyright © 2016年 xuyong. All rights reserved.
//

#import "MainViewControl.h"

@interface MainViewControl ()

@end

@implementation MainViewControl

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setNavBarView];
    
    self.view.backgroundColor =[UIColor whiteColor];
    
}

#pragma mark - UI
//-(void)setNavBarView {
//    [self.navBarView setMiddleWithWithTitle:@"logo" type:3];
//    [self.navBarView setRightWithTitle:@"我的" type:1];
//    [self.navBarView setLeftWithTitle:@"搜索" type:1];
//}
//
//#pragma mark - 导航栏代理
//-(void)leftBtnClickByNavBarView:(SS_NavBarView *)navView {
//    NSLog(@"搜索被点击");
//}
//
////公告右边点击
//-(void)rightBtnClickByNavBarView:(SS_NavBarView *)navView {
//    NSLog(@"我的被点击");
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
