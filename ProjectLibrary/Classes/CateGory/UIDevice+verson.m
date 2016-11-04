//
//  UIDevice+verson.m
//  AskBrotherApp
//
//  Created by xuyong on 16/7/4.
//  Copyright © 2016年 xuyong. All rights reserved.
//

#import "UIDevice+verson.h"

@implementation UIDevice (verson)
+ (float)getIOSVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}
@end
