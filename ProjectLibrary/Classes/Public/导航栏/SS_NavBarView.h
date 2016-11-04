//
//  SS_NavBarView.h
//  SchoolSociety
//
//  Created by 邱成西 on 16/6/20.
//  Copyright © 2016年 xuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NavBarViewDelegate;

@interface SS_NavBarView : UIView

///设置左侧按钮、标题
-(void)setLeftWithTitle:(NSString *)title type:(NSInteger)type;

///设置右侧按钮
-(void)setRightWithTitle:(NSString *)title type:(NSInteger)type;

///设置标题
-(void)setMiddleWithWithTitle:(NSString *)title type:(NSInteger)type;

-(void)isShowBackImageView:(BOOL)isShow;

@property (nonatomic, assign) BOOL rightEnable;//针对右侧按钮
@property (nonatomic, assign) BOOL isReding;//针对右侧按钮

@property (nonatomic, assign) id<NavBarViewDelegate>navDelegate;

-(void)setBackColor:(UIColor *)backgroundColor;
@end

@protocol NavBarViewDelegate <NSObject>

@optional

-(void)rightBtnClickByNavBarView:(SS_NavBarView *)navView;

-(void)leftBtnClickByNavBarView:(SS_NavBarView *)navView;
@end