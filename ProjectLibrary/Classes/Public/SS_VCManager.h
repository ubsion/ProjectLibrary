//
//  SS_VCManager.h
//  SchoolSociety
//
//  Created by xuyong on 16/6/22.
//  Copyright © 2016年 xuyong. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @author xuyong, 16-06-22 10:06:56
 *
 *  @brief 控制器管理
 */

@interface SS_VCManager : NSObject
+(instancetype)defaultManager;

@property (nonatomic, strong) UIViewController *rootViewController;

@end
