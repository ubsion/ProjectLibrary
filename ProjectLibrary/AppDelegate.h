//
//  AppDelegate.h
//  ProjectLibrary
//
//  Created by xuyong on 16/11/4.
//  Copyright © 2016年 xuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (AppDelegate*)shareInstance;

@property (nonatomic,strong)  UIViewController *ss_rootViewController;

@property (nonatomic, assign) NSInteger interfaceStatus;

@end

