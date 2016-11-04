//
//  ViewController.h
//  SchoolSociety
//
//  Created by xuyong on 16/6/15.
//  Copyright © 2016年 xuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SS_NavBarView.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) UIImageView *defaultView;
@property (nonatomic, strong) UILabel *infoLab;
//导航栏
@property (nonatomic, strong) SS_NavBarView *navBarView;

//导航栏代理
-(void)leftBtnClickByNavBarView:(SS_NavBarView *)navView;
-(void)rightBtnClickByNavBarView:(SS_NavBarView *)navView;

-(void)showDefultView:(CGFloat)top text:(NSString *)info view:(UIView *)view;
-(void)hiddenDefultView;



@end

