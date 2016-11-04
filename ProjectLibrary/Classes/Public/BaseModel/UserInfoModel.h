//
//  UserInfoModel.h
//  NewsApp
//
//  Created by xuyong on 15/12/28.
//  Copyright © 2015年 xuyong. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PushModelModel : NSObject

///对应的个推clientId
@property(nonatomic,  copy) NSString           *clientId;
///是否打开推送 2 打开,1 关闭
@property(nonatomic,assign) NSInteger          isAllPushOn;
///是否打开收藏新闻消息推送 2 打开,1 关闭
@property(nonatomic,assign) NSInteger          isCollectPushOn;
///是否打开评论消息推送 2 打开,1 关闭
@property(nonatomic,assign) NSInteger          isCommentPushOn;

-(id)initWithDictionary:(NSDictionary*)dict error:(NSError**)err;
@end



@interface ActionInfoModel : NSObject

///收藏数
@property(nonatomic,assign) NSInteger          collectNum;
///侃评数
@property(nonatomic,assign) NSInteger          kanpingNum;

-(id)initWithDictionary:(NSDictionary*)dict error:(NSError**)err;
@end




@interface UserInfoModel : NSObject<NSCoding>

///年龄
@property(nonatomic,assign) NSInteger          age;
///头像
@property(nonatomic,strong) NSString           *avatar;
///学院
@property(nonatomic,strong) NSString           *department;
///入学时间
@property(nonatomic,assign) int             enterSchTime;
///粉丝数
@property(nonatomic,assign) NSInteger          fansNum;
///Feed数
@property(nonatomic,assign) NSInteger          feeNum;
///关注数
@property(nonatomic,assign) NSInteger          followingNum;
///评论数
@property(nonatomic,assign) NSInteger          commentNum;

///性别,1 男, 2 女,
@property(nonatomic,assign) NSInteger          gender;
///嘉宾数
@property(nonatomic,assign) NSInteger          guestsNum;
///昵称 最长50字符
@property(nonatomic,strong) NSString           *nickName;
///学校
@property(nonatomic,strong) NSString           *school;
///uId
@property(nonatomic,assign) NSInteger          uId;
///标签,多个用都逗号分割
@property(nonatomic,strong) NSString           *userTags;
///视频服务器Token
@property(nonatomic,strong) NSString           *videoSToken;
///视频服务器Uid
@property(nonatomic,strong) NSString           *videoUId;

@property(nonatomic,assign) NSInteger          isFollowed;


@end

