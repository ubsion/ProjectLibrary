//
//  SS_VCManager.m
//  SchoolSociety
//
//  Created by xuyong on 16/6/22.
//  Copyright © 2016年 xuyong. All rights reserved.
//

#import "SS_VCManager.h"

@implementation SS_VCManager

#pragma mark - View
+(instancetype)defaultManager{
    static SS_VCManager *shareInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareInstance = [[self alloc]init];
    });
    return shareInstance;
}

#pragma mark - 根控制器
- (UIViewController *)rootViewController
{
    return [(AppDelegate *)[[UIApplication sharedApplication] delegate] ss_rootViewController];
}
@end
