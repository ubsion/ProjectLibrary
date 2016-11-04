//
//  RequestData.h
//  NewsApp
//
//  Created by xuyong on 15/12/28.
//  Copyright © 2015年 xuyong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface RequestData : NSObject

#pragma mark --- 用户信息
+ (void )setPushModelModel:(PushModelModel *)pushSetting;
+ (PushModelModel *)getPushModelModel;

+ (void )setUserInfo:(UserInfoModel *)userInfo;
+ (UserInfoModel *)getUserInfo;

+ (void )setActionInfo:(ActionInfoModel *)userInfo;
+ (ActionInfoModel *)getActionInfo;

@end
