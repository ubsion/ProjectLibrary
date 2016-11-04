//
//  MessageModel.h
//  SchoolSociety
//
//  Created by xuyong on 16/8/10.
//  Copyright © 2016年 xuyong. All rights reserved.
//


#import "UserInfoModel.h"

@interface MessageModel : NSObject
@property (nonatomic,copy) NSString *actionUrl;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,assign) double created;
@property (nonatomic,assign) NSInteger mId;
@property (nonatomic,assign) NSInteger receiverUid;
@property (nonatomic,assign) NSInteger senderUid;
@property (nonatomic,strong) UserInfoModel *sender;

@property(nonatomic,  copy) NSString *createTimerStr;

@end
