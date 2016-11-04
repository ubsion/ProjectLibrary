//
//  MacroDefinition.h
//  WatchAPP
//
//  Created by xuyong on 15/9/23.
//  Copyright (c) 2015年 xuyong. All rights reserved.
//

#ifndef WatchAPP_MacroDefinition_h
#define WatchAPP_MacroDefinition_h


#endif

#define   APPID                 @"com.luosuo.newsApp"

//内网
//#define   FILE_URL              @"http://192.168.100.58/v1/file/"
//#define   SERVER_URL            @"http://192.168.100.58:8084/v1/"

////外网
#define   FILE_URL              @""
#define   SERVER_URL            @""

/// 个推开发者网站中申请App时注册的AppId、AppKey、AppSecret
#define    KAppSecret            @""
#define    KAppID                @""
#define    KAppKey               @""


///环信
//#define    HXAppKey
#define    HXAppKey              @""
#define    HXApnsName            @""

//微信登录：
#define    WXAppID               @""
#define    WXAppSecret           @""


#define    SYSTEM_FONT(A)       [UIFont systemFontOfSize:A]
#define    BOLD_FONT(A)         [UIFont boldSystemFontOfSize:A]
#define    RGB_COLOR(A,B,C,D)   [UIColor colorWithRed:A/255.0f green:B/255.0f blue:C/255.0f alpha:D]

#define    BTN_ON_COLOR         [UIColor colorWithRed:0/255.0f green:132/255.0f blue:254/255.0f alpha:1.0f]//主色调蓝
#define    CELL_LINE_COLOR      [UIColor colorWithRed:229/255.0f green:233/255.0f blue:245/255.0f alpha:1.0f]//cell灰
#define    MAIN_BLUE_COLOR      [UIColor colorWithRed:50/255.0f green:132/255.0f blue:255/255.0f alpha:1.0f]//主色调蓝
#define    BG_GRAY_COLOR        [UIColor colorWithRed:229/255.0f green:233/255.0f blue:245/255.0f alpha:1.0f]//背景灰
#define    CELL_TITLE_COLOR     [UIColor colorWithRed:77/255.0f green:77/255.0f blue:77/255.0f alpha:1.0f]//背景灰
#define    TEXT_GRAY_COLOR     [UIColor colorWithRed:201/255.0f green:199/255.0f blue:219/255.0f alpha:1.0f]//文字灰






#define    SCREEN_WIDTH         [UIScreen mainScreen].bounds.size.width
#define    SCREEN_HEIGHT        [UIScreen mainScreen].bounds.size.height
#define Platform [[[UIDevice currentDevice] systemVersion] floatValue]

#ifdef DEBUG
#define debugLog(...)    NSLog(__VA_ARGS__)
#define debugMethod()    NSLog(@"%s", __func__)
#define debugError()     NSLog(@"Error at %s Line:%d", __func__, __LINE__)
#define DLog(fmt, ...)   NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define debugLog(...)
#define debugMethod()
#define debugError()
#define DLog(...)
#endif

#define LOADVC(string) [[NSClassFromString(string) alloc]initWithNibName:string bundle:nil];

#define VCHeight     49
#define TabbarHeight 90


#define GaryColor [UIColor colorWithRed:0.556863 green:0.556863 blue:0.576471 alpha:1];

//登录用户
#define LoginUserInfo [RequestData getUserInfo]
#define LoginUserUid [RequestData getUserInfo].uId

