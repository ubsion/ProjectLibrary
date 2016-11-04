//
//  UserInfoModel.m
//  NewsApp
//
//  Created by xuyong on 15/12/28.
//  Copyright © 2015年 xuyong. All rights reserved.
//

#import "UserInfoModel.h"

@implementation PushModelModel

-(id)initWithDictionary:(NSDictionary*)dict error:(NSError**)err {
    self = [super init];
    if (self) {
        self.clientId        = dict[@"clientId"];
        self.isAllPushOn     = [dict[@"isAllPushOn"] integerValue];
        self.isCollectPushOn = [dict[@"isCollectPushOn"] integerValue];
        self.isCommentPushOn = [dict[@"isCommentPushOn"] integerValue];
        
    }
    return self;
}
@end

@implementation ActionInfoModel

-(id)initWithDictionary:(NSDictionary*)dict error:(NSError**)err {
    self = [super init];
    if (self) {
        self.collectNum = [dict[@"collectNum"] integerValue];
        self.kanpingNum = [dict[@"kanpingNum"] integerValue];
    }
    return self;
}
@end

@implementation UserInfoModel
+ (NSDictionary*)mts_mapping {
    return  @{
              @"age": mts_key(age),
              @"avatar": mts_key(avatar),
              @"department": mts_key(department),
              @"enterSchTime": mts_key(enterSchTime),
              @"fansNum": mts_key(fansNum),
              @"feeNum": mts_key(feeNum),
              @"followingNum": mts_key(followingNum),
              @"gender": mts_key(gender),
              @"guestsNum": mts_key(guestsNum),
              @"nickName": mts_key(nickName),
              @"school": mts_key(school),
              @"uId": mts_key(uId),
              @"userTags": mts_key(userTags),
              @"videoSToken": mts_key(videoSToken),
              @"videoUId": mts_key(videoUId),
              @"commentNum": mts_key(commentNum),
              @"isFollowed": mts_key(isFollowed)
              };
}


+ (BOOL)mts_shouldSetUndefinedKeys {
    return NO;
}

#pragma mark - NSCoding
-(instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.age          = [decoder decodeIntForKey:@"age"];
        self.avatar       = [decoder decodeObjectForKey:@"avatar"];
        self.department   = [decoder decodeObjectForKey:@"department"];
        self.enterSchTime = [decoder decodeDoubleForKey:@"enterSchTime"];
        self.fansNum      = [decoder decodeIntForKey:@"fansNum"];
        self.feeNum       = [decoder decodeIntForKey:@"feeNum"];
        self.followingNum = [decoder decodeIntForKey:@"followingNum"];
        self.gender       = [decoder decodeIntForKey:@"gender"];
        self.guestsNum    = [decoder decodeIntForKey:@"guestsNum"];
        self.nickName     = [decoder decodeObjectForKey:@"nickName"];
        self.school       = [decoder decodeObjectForKey:@"school"];
        self.uId          = [decoder decodeIntForKey:@"uId"];
        self.school       = [decoder decodeObjectForKey:@"school"];
        self.userTags     = [decoder decodeObjectForKey:@"userTags"];
        self.videoSToken  = [decoder decodeObjectForKey:@"videoSToken"];
        self.videoUId     = [decoder decodeObjectForKey:@"videoUId"];
        self.commentNum   = [decoder decodeIntForKey:@"commentNum"];
        self.isFollowed   = [decoder decodeIntForKey:@"isFollowed"];

    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInt:(int)self.age forKey:@"age"];
    [encoder encodeObject:self.avatar forKey:@"avatar"];
    [encoder encodeObject:self.department forKey:@"department"];
    [encoder encodeDouble:(double)self.enterSchTime forKey:@"enterSchTime"];
    [encoder encodeInt:(int)self.fansNum forKey:@"fansNum"];
    [encoder encodeInt:(int)self.feeNum forKey:@"feeNum"];
    [encoder encodeInt:(int)self.followingNum forKey:@"followingNum"];
    [encoder encodeInt:(int)self.gender forKey:@"gender"];
    [encoder encodeInt:(int)self.guestsNum forKey:@"guestsNum"];
    [encoder encodeObject:self.nickName forKey:@"nickName"];
    [encoder encodeInt:(int)self.uId forKey:@"uId"];
    [encoder encodeObject:self.school forKey:@"school"];
    [encoder encodeObject:self.userTags forKey:@"userTags"];
    [encoder encodeObject:self.videoSToken forKey:@"videoSToken"];
    [encoder encodeObject:self.videoUId forKey:@"videoUId"];
    [encoder encodeInt:(int)self.commentNum forKey:@"commentNum"];
    [encoder encodeInt:(int)self.isFollowed forKey:@"isFollowed"];
}



@end
