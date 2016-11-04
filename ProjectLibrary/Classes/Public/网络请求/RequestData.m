//
//  RequestData.m
//  NewsApp
//
//  Created by xuyong on 15/12/28.
//  Copyright © 2015年 xuyong. All rights reserved.
//

#import "RequestData.h"

@implementation RequestData

#pragma mark --- 用户信息
static PushModelModel   *pushSettingModel;
static UserInfoModel    *userInfoModel;
static ActionInfoModel  *actionInfoModel;

+ (void )setPushModelModel:(PushModelModel *)pushSetting
{
    pushSettingModel = pushSetting;
}

+ (PushModelModel *)getPushModelModel
{
    return pushSettingModel;
}

+ (void )setUserInfo:(UserInfoModel *)userInfo
{
    userInfoModel = userInfo;
}

+ (UserInfoModel *)getUserInfo
{
    return userInfoModel;
}

+ (void )setActionInfo:(ActionInfoModel *)actionInfo
{
    actionInfoModel = actionInfo;
}

+ (ActionInfoModel *)getActionInfo
{
    return actionInfoModel;
}

@end
