//
//  RequestServer.m
//  WatchAPP
//
//  Created by xuyong on 15/9/23.
//  Copyright (c) 2015年 xuyong. All rights reserved.
//

#import "RequestServer.h"

#import "LabelTextSize.h"
#import "SSKeychain.h"

NSString * const kuser            = @"user/";
NSString * const kactioninfo      = @"user/actioninfo";
NSString * const kmedias          = @"user/medias";

#pragma mark publick:公共接口
NSString * const kvericode        = @"public/vericode";
NSString * const ksignup          = @"public/signup";
NSString * const ksignin          = @"public/signin";
NSString * const kresetpassword   = @"public/resetpassword";
NSString * const kthirdpartsignin = @"public/third-part-signin";

#pragma mark user:用户接口
NSString * const kuserSearch     = @"user/search";

#pragma mark banner
NSString * const kbannerall      = @"banner/all";
NSString * const kbanner         = @"banner/";

#pragma mark feed:Feed接口
NSString * const kfeedad         = @"feed/ad-recommend";
NSString * const kfeedall        = @"feed/all";
NSString * const kfeeddetail     = @"feed/detail/";
NSString * const kfeed           = @"feed/";
NSString * const kfeedlike       = @"feed/likes/";

#pragma mark follow:关注接口
NSString * const kfollowfollows  = @"follow/follows/";
NSString * const kfollowfans     = @"follow/fans/";
NSString * const kfollow         = @"follow/";

#pragma mark follow:点赞接口
NSString * const klike           = @"like/";

#pragma mark comment:评论接口
NSString * const kcommentfeed    = @"comment/feed/";
NSString * const kcommentprogram = @"comment/program/";
NSString * const kcommenttrend   = @"comment/trend/";
NSString * const kcommentproject = @"comment/project/";
NSString * const kcommentforum   = @"comment/forum/";
NSString * const kcomment        = @"comment/";

#pragma mark program:官方发布-节目接口
NSString * const kprogramall    = @"program/all";
NSString * const kprogram       = @"comment/";

#pragma mark forum:官方发布-论坛接口
NSString * const kforumall      = @"forum/all";
NSString * const kforum         = @"forum/";

#pragma mark project:官方发布-项目接口
NSString * const kprojectall      = @"project/all";
NSString * const kproject         = @"project/";
NSString * const kprojectDetail   = @"project/detail";
NSString * const kprojectcandidate= @"/project/candidate/";
NSString * const kprojectcandidateagree= @"project/candidate/agree/";
NSString * const kprojectcandidateall= @"project/candidate/all";
NSString * const kprojectresult= @"project/result";

#pragma mark trend:官方发布-动态接口
NSString * const ktrendall        = @"trend/all";
NSString * const ktrend           = @"trend/";



NSString * const kmsgRegitser   = @"message/register";
NSString * const kmsgUnregitser = @"message/unregister";

NSString * const knews          = @"news/";
NSString * const knewsState     = @"news/state";
NSString * const knewsCategory  = @"news/category";
NSString * const knewsRelated   = @"news/related";


NSString * const kmedia         = @"media/";
NSString * const kmediaPublish  = @"media/publish";
NSString * const kmediaDetail   = @"media/detail";

NSString * const kcollectnews   = @"collect/news";
NSString * const kcollectnewsList= @"collect/newsList";
NSString * const kcollectState  = @"collect/state";
/*评论*/
NSString * const ksendComment   = @"comment/";//发布评论
NSString * const kcommentList   = @"comment/comment-list";//获取评论列表
NSString * const kcommentState  = @"comment/praise-state";//获取点评状态

@implementation RequestServer

+ (BOOL)checkInterfaceDataCode:(NSDictionary *)dic
{
    NSLog(@"response-->%@",dic);
    NSInteger code = [dic[@"code"] integerValue];
    if (code==1000) {
        return YES;
    }else {
        //        [RequestServer showAlert:dic[@"description"]];
        return NO;
    }
}

#pragma mark public
///获取验证码++
+(void)requestVerifyCode:(NSString *)phoneNum
                 success:(successBlock)success
                   error:(errorBlock)error
{
    NSDictionary *params = @{@"phoneNum":phoneNum};
    
    [[self class] requestPath:kvericode requestMethod:SZRequestMethodGet parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"description"]);
         }
         else
             [self showTip:@"获取验证码失败"];
         
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         [self showTip:@"获取验证码失败"];
     }];
}

///注册++
+(void)requestsignup:(NSString *)phoneNum
            password:(NSString *)password
            vericode:(NSString *)vericode
             success:(successBlock)success
               error:(errorBlock)errorr
{
    NSDictionary *params = @{@"phoneNum":phoneNum,@"password":password,@"veriCode":vericode};
    
    [[self class] requestPath:ksignup requestMethod:SZRequestMethodPost parameters:params doNotSerializer:true finish:^(NSURLSessionDataTask *task, id responseObject) {
        if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             UserInfoModel *instance = [[UserInfoModel alloc] init];
             [instance mts_setValuesForKeysWithDictionary:responseObject[@"data"]];
             [RequestData setUserInfo:instance];
             [[NSUserDefaults standardUserDefaults] setObject:phoneNum forKey:@"ACCOUNT"];
             [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",(long)[RequestData getUserInfo].uId] forKey:@"USERUID"];
             [[NSUserDefaults standardUserDefaults] synchronize];
             [SSKeychain setPassword: [NSString stringWithFormat:@"%@", password] forService:APPID account:phoneNum];
             
             
             //            SS_PersonalPage *vc = [[SS_PersonalPage alloc] init];
             //            [weakSelf.navigationController pushViewController:vc animated:true];
             
             NSString *devideToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"DEVICETOKEN"];
             //添加登陆信息
             [RequestServer requestUserSignInInfo:devideToken success:^(NSDictionary *dic, NSString *tipInfo) {
                 
             } error:^(NSString *errorInfo) {
                 
             }];
             
//             EMError *error = [[EMClient sharedClient] loginWithUsername:[NSString stringWithFormat:@"%ld",(long)[RequestData getUserInfo].uId]
//                                                                password:[NSString stringWithFormat:@"password_%ld",(long)[RequestData getUserInfo].uId]];
//             if (!error)
//             {
//                 [[EMClient sharedClient].options setIsAutoLogin:YES];
//             }
             
             //登录成功
             [[NSNotificationCenter defaultCenter] postNotificationName:@"LOGIN_SUCCESS" object:nil];

             
             
             success(responseObject[@"result"]);
         }
         else{
             errorr(@"注册失败");
             [self showTip:@"注册失败，请重新尝试"];
         }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        errorr(@"注册失败");
        NSLog(@"%@",error);
        [self showTip:@"注册失败，请重新尝试"];
    }];
    
//    [[self class] requestPath:ksignup requestMethod:SZRequestMethodPost parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
//     {
//         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
//         {
//             UserInfoModel *instance = [[UserInfoModel alloc] init];
//             [instance mts_setValuesForKeysWithDictionary:responseObject[@"data"]];
//             [RequestData setUserInfo:instance];
//             success(responseObject[@"result"]);
//         }
//         else{
//             [self showTip:@"注册失败，请重新尝试"];
//         }
//     } failure:^(NSURLSessionDataTask *task, NSError *err) {
//         NSLog(@"%@",err);
//         [self showTip:@"注册失败，请重新尝试"];
//     }];
}

///登陆++
+(void)requestsignin:(NSString *)phoneNum
            password:(NSString *)password
             success:(successBlock)success
               error:(errorBlock)error
{
    NSDictionary *params = @{@"phoneNum":phoneNum,@"password":password};
    
    [[self class] requestPath:ksignin requestMethod:SZRequestMethodGet parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             UserInfoModel *instance = [[UserInfoModel alloc] init];
             [instance mts_setValuesForKeysWithDictionary:responseObject[@"data"]];
             [RequestData setUserInfo:instance];
             success(responseObject[@"data"]);
         }
         else{
             error(@"");
             [self showTip:@"登录失败，请重新尝试"];
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         error(@"");
         NSLog(@"%@",err);
         [self showTip:@"登录失败，请重新尝试"];
     }];
}

///第三方登陆
+(void)requestThirdSignin:(NSString *)thirdAuthId
                   avatar:(NSString *)avatar
                 nickName:(NSString *)nickName
                   gender:(NSInteger )gender
           thirdAuthToken:(NSString *)thirdAuthToken
            thirdAuthType:(NSInteger )thirdAuthType //1微信
                  success:(successBlock)success
                    error:(errorBlock)error
{
    NSDictionary *params = @{@"thirdAuthId":thirdAuthId,
                             @"avatar":avatar,
                             @"nickName":nickName,
                             @"gender":@(gender),
                             @"thirdAuthToken":thirdAuthToken,
                             @"thirdAuthType":@(thirdAuthType),
                             @"avatar":avatar
                             };
    
    [[self class] requestPath:kthirdpartsignin requestMethod:SZRequestMethodPost parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             UserInfoModel *instance = [[UserInfoModel alloc] init];
             [instance mts_setValuesForKeysWithDictionary:responseObject[@"data"]];
             [RequestData setUserInfo:instance];
             success(responseObject[@"data"]);
         }
         else{
             [self showTip:@"登录失败，请重新尝试"];
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
         [self showTip:@"注册失败，请重新尝试"];
     }];
}

//更新登录设备信息
+(void)requestUserSignInInfo:(NSString *)deviceToken
                     success:(successDicBlock)success
                       error:(errorBlock)error
{
    NSDictionary *param = @{@"deviceModel":[[UIDevice currentDevice] model],
                            @"deviceToken":deviceToken == nil ? @"" : deviceToken,
                            @"systemVersion":[[UIDevice currentDevice] systemVersion],
                            @"systerm":@(2),
                            @"uId":@([RequestData getUserInfo].uId)
                            };
    
    [[self class] requestPath:@"user/signin-info" requestMethod:SZRequestMethodPUT parameters:param finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         error(@"");
         DLog(@"%@",err);
         NSLog(@"bbbbbb %@",error);
         NSData *data = err.userInfo[@"com.alamofire.serialization.response.error.data"];
         NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
         NSLog(@"xxxxxx %@",string);
     }];
}

//删除登录设备信息
+(void)requestUserDeleteSignInInfo:(NSString *)deviceToken
                     success:(successDicBlock)success
                       error:(errorBlock)error
{
    NSDictionary *param = @{@"deviceModel":[[UIDevice currentDevice] model],
                            @"deviceToken":deviceToken == nil ? @"" : deviceToken,
                            @"systerm":@(2),
                            @"uId":@([RequestData getUserInfo].uId)
                            };
    
    [[self class] requestPath:[NSString stringWithFormat:@"user/%ld/signin-info",(long)[RequestData getUserInfo].uId] requestMethod:SZRequestMethodDELETE parameters:param finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(nil,nil);
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         error(@"");
         DLog(@"%@",err);
         NSLog(@"bbbbbb %@",error);
         NSData *data = err.userInfo[@"com.alamofire.serialization.response.error.data"];
         NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
         NSLog(@"xxxxxx %@",string);
     }];
}

///重置密码++
+(void)requestResetPsd:(NSString *)phoneNum
              password:(NSString *)password
              vericode:(NSString *)vericode
               success:(successBlock)success
                 error:(errorBlock)error
{
    NSDictionary *params = @{@"phoneNum":phoneNum,@"password":password,@"veriCode":vericode};
    
    [[self class] requestPath:@"public/reset-password" requestMethod:SZRequestMethodPost parameters:params doNotSerializer:true finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"result"]);
         }
         else{
             [self showTip:@"重置失败，请重新尝试"];
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
         [self showTip:@"重置失败，请重新尝试"];
     }];
}
#pragma mark user
///更新用户信息++
//+(void)requestUpdateUserInfo:(NSInteger )age
//                      avatar:(NSString *)avatar
//                  department:(NSString *)department
//                enterSchTime:(NSInteger )enterSchTime
//                     fansNum:(NSInteger )fansNum
//                      feeNum:(NSInteger )feeNum
//                followingNum:(NSInteger )followingNum
//                      gender:(NSInteger )gender
//                   guestsNum:(NSInteger )guestsNum
//                    nickName:(NSString *)nickName
//                      school:(NSString *)school
//                    userTags:(NSString *)userTags
//                 videoSToken:(NSString *)videoSToken
//                    videoUId:(NSString *)videoUId
//                     success:(successBlock)success
//                       error:(errorBlock)error
///更新用户信息++
+(void)requestUpdateUserInfo:(UserInfoModel *)model
                     success:(successBlock)success
                       error:(errorBlock)error
{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    if(model.avatar.length != 0)
        [param setObject:model.avatar forKey:@"avatar"];
    if(model.department.length != 0)
        [param setObject:model.department forKey:@"department"];
    if(model.enterSchTime != 0)
        [param setObject:@(model.enterSchTime) forKey:@"enterSchTime"];//
    if(model.gender != -1)
        [param setObject:@(model.gender) forKey:@"gender"];
    if(model.nickName.length != 0)
        [param setObject:model.nickName forKey:@"nickName"];
    if(model.school.length != 0)
        [param setObject:model.school forKey:@"school"];
    if(model.userTags.length != 0)
        [param setObject:model.userTags forKey:@"userTags"];
    
    
    [[self class] requestPath:[NSString stringWithFormat:@"%@%ld",kuser,(long)[RequestData getUserInfo].uId] requestMethod:SZRequestMethodPATCH parameters:param doNotSerializer:false finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             [[NSNotificationCenter defaultCenter] postNotificationName:@"UPDATE_USER_INFO" object:nil];
             success(responseObject[@"data"]);
         }
         else{
             [self showTip:@"保存失败，请重新尝试"];
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
         [self showTip:@"保存失败，请重新尝试"];
     }];
    
    
//    [[self class] requestPath:[NSString stringWithFormat:@"%@%ld",kuser,(long)[RequestData getUserInfo].uId] requestMethod:SZRequestMethodPATCH parameters:param finish:^(NSURLSessionDataTask *task, id responseObject)
//     {
//         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
//         {
//             [[NSNotificationCenter defaultCenter] postNotificationName:@"UPDATE_USER_INFO" object:nil];
//             success(responseObject[@"data"]);
//         }
//         else{
//             [self showTip:@"保存失败，请重新尝试"];
//         }
//     } failure:^(NSURLSessionDataTask *task, NSError *err) {
//         NSLog(@"%@",err);
//         [self showTip:@"保存失败，请重新尝试"];
//     }];
}

///获取用户信息++
+(void)requestGetUserInfo:(NSString *)uid
                currentId:(NSString *)currentId
                  success:(successDicBlock)success
                    error:(errorBlock)error
{
//    NSString *resultPath = currentId == 0 ? [NSString stringWithFormat:@"%@%@",kuser,uid] :[NSString stringWithFormat:@"%@%@",kuser,uid]
    NSDictionary *param;
    if ([currentId isEqualToString:@"0"] || currentId == nil) {
        param = nil;
    }else
    {
        param = @{@"currentUId":currentId};
    }
    
    [[self class] requestPath:[NSString stringWithFormat:@"%@%@",kuser,uid] requestMethod:SZRequestMethodGet parameters:param finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"data"],nil);
         }
         else{
//             [self showTip:@"获取用户信息失败"];
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
//         [self showTip:@"获取用户信息失败"];
     }];
}

///搜索用户++
+(void)requestSearchUser:(NSString *)target
                pageTime:(NSString *)pageTime
                 pageNum:(NSInteger )pageNum
                pageSize:(NSInteger )pageSize
                     uId:(NSInteger )uId
                 success:(successDicBlock)success
                   error:(errorBlock)error
{
    NSDictionary *params = @{@"target":target,
                             @"pageTime":pageTime,
                             @"pageNum":@(pageNum),
                             @"pageSize":@(pageSize),
                             @"uId":@(uId),
                             };
    
    [[self class] requestPath:kuserSearch requestMethod:SZRequestMethodGet parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
             success(responseObject[@"data"],@"");
         else
         {
             error(@"搜索失败");
             NSLog(@"搜索失败");
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         error(@"搜索失败");
         NSLog(@"%@",err);
         NSLog(@"搜索失败");
     }];
}

///注册/注销个推clientId
+(void)requestregisterClinetId:(NSString *)clientId
                       success:(successDicBlock)success
                         error:(errorBlock)error
{
    NSDictionary *params = @{@"clientId":clientId};
    if(clientId.length == 0)
        params = nil;
    
    [[self class] requestPath:[NSString stringWithFormat:@"user/%ld/getui-clientId",(long)[RequestData getUserInfo].uId] requestMethod:SZRequestMethodPost parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"data"],nil);
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         error(@"");
         DLog(@"%@",err);
     }];
}

///获取用户推送设置
+(void)requestUserGetPushSetting:(successDicBlock)success
                           error:(errorBlock)error
{
    NSDictionary *param = @{@"uId":@([RequestData getUserInfo].uId)};
    
    [[self class] requestPath:[NSString stringWithFormat:@"user/%ld/push-settings",(long)[RequestData getUserInfo].uId] requestMethod:SZRequestMethodGet parameters:param finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             PushModelModel *instance = [[PushModelModel alloc] initWithDictionary:responseObject[@"data"] error:nil];
             [RequestData setPushModelModel:instance];
             success(responseObject[@"data"],nil);
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         error(@"");
         DLog(@"%@",err);
     }];
}

//更新用户推送设置
+(void)requestUserUpdatePushSetting:(NSInteger )isAllPushOn
                    isCommentPushOn:(NSInteger )isCommentPushOn
                    isCollectPushOn:(NSInteger )isCollectPushOn
                            success:(successDicBlock)success
                              error:(errorBlock)error
{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:@([RequestData getUserInfo].uId) forKey:@"uId"];
    if(isAllPushOn != 0)
        [param setObject:@(isAllPushOn) forKey:@"isAllPushOn"];
    if(isCommentPushOn != 0)
        [param setObject:@(isCommentPushOn) forKey:@"isCommentPushOn"];
    if(isCollectPushOn != 0)
        [param setObject:@(isCollectPushOn) forKey:@"isCollectPushOn"];
    
    [[self class] requestPath:[NSString stringWithFormat:@"user/%ld/push-settings",(long)[RequestData getUserInfo].uId] requestMethod:SZRequestMethodPATCH parameters:param finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             PushModelModel *instance = [[PushModelModel alloc] initWithDictionary:responseObject[@"data"] error:nil];
             [RequestData setPushModelModel:instance];
             success(responseObject[@"data"],nil);
             
             success(responseObject[@"data"],nil);
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         error(@"");
         DLog(@"%@",err);
     }];
}

#pragma mark banner
///获取所有Banner列表++
+(void)requestBannerAll:(NSString *)pagetime
                pageNum:(int       )pagenum
               pageSize:(int       )pagesize
                success:(successArrBlock)success
                  error:(errorBlock)error
{
//    NSDictionary *params = @{@"pageTime":pagetime,@"pageNum":@(pagenum),@"pageSize":@(pagesize)};
    
    [[self class] requestPath:kbannerall requestMethod:SZRequestMethodGet parameters:nil finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             NSDictionary *dic =responseObject[@"data"];
             success(dic[@"bangramsList"],@"");
         }
         else
         {
             NSLog(@"获取所有Banner列表失败");
             error(@"获取所有Banner列表失败");
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         error(@"获取所有Banner列表失败");
         NSLog(@"%@",err);
         NSLog(@"获取所有Banner列表失败");
     }];
}

///添加Banner++
+(void)requestBannerAdd:(NSString *)actionUrl
                  banId:(int       )banId
            coverHeight:(int       )coverHeight
             coverWidth:(int       )coverWidth
               coverUrl:(NSString *)coverUrl
                success:(successBlock)success
                  error:(errorBlock)error
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    long long int created = (long long int)time;
    
    NSDictionary *params = @{@"actionUrl":actionUrl,
                             @"banId":@(banId),
                             @"coverHeight":@(coverHeight),
                             @"coverWidth":@(coverWidth),
                             @"coverUrl":coverUrl,
                             @"created":@(created)};
    
    [[self class] requestPath:[NSString stringWithFormat:@"%@%ld",kbanner,[RequestData getUserInfo].uId] requestMethod:SZRequestMethodPost parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(@"");
         }
         else
             NSLog(@"获取所有Banner列表失败");
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
         NSLog(@"获取所有Banner列表失败");
     }];
}

///用户删除Banner++
+(void)requestBannerDelete:(NSInteger )uId
                    banId:(NSInteger )banId
                  success:(successBlock)success
                    error:(errorBlock)error
{
    [[self class] requestPath:[NSString stringWithFormat:@"%@%ld/%ld",kbanner,(long)uId,(long)banId] requestMethod:SZRequestMethodDELETE parameters:nil finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(@"用户删除Banner成功");
         }
         else
             NSLog(@"用户删除Banner失败");
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
         NSLog(@"用户删除Banner失败");
     }];
}

#pragma mark feed:Feed接口
///获取社长推荐Feed列表,按时间排序++
+(void)requestFeedAd:(NSString *)pagetime
             pageNum:(int       )pagenum
            pageSize:(int       )pagesize
             success:(successDicBlock)success
               error:(errorBlock)error
{
    NSDictionary *params = @{@"pageTime":pagetime,@"pageNum":@(pagenum),@"pageSize":@(pagesize)};
    if ([RequestData getUserInfo].uId > 0) {
        params = @{@"pageTime":pagetime,@"pageNum":@(pagenum),@"pageSize":@(pagesize),@"currentUId":@(LoginUserUid)};
    }
    [[self class] requestPath:kfeedad requestMethod:SZRequestMethodGet parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"data"],@"");
         }
         else
             NSLog(@"获取社长推荐Feed列表,按时间排序失败");
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
         NSLog(@"获取社长推荐Feed列表,按时间排序失败");
     }];
}

///获取Feed列表,按时间排序++  "内容类型 0:全部 1:视频 2:音频 3:图片" 	"排序规则 0:上传时间 1:推荐数目 2:评论数目" "时间范围 0:不限 1:24小时内 2:7天内 3:30天内"
+(void)requestFeedAll:(NSString *)pagetime
              pageNum:(int       )pagenum
             pageSize:(int       )pagesize
           filterType:(int       )filterType
            orderType:(int       )orderType
            timeRange:(int       )timeRange
              success:(successDicBlock)success
                error:(errorBlock)error
{
    NSDictionary *params = @{@"pageTime":pagetime,@"pageNum":@(pagenum),@"pageSize":@(pagesize),
                             @"filterType":@(filterType),@"orderType":@(orderType),@"timeRange":@(timeRange)};
    
    [[self class] requestPath:kfeedall requestMethod:SZRequestMethodGet parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"data"],@"");
         }
         else
             error(@"获取列表失败");
             NSLog(@"获取社长推荐Feed列表,按时间排序失败");
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         error(@"获取列表失败");
         NSLog(@"%@",err);
         NSLog(@"获取社长推荐Feed列表,按时间排序失败");
     }];
}

/**
 *  @author xuyong, 16-08-12 09:08:22
 *
 *  @brief "uId, 传递该参数时,查询该用户发布的Feed,不传递该参数时,查询全部"
 *  根据id搜索feelist
 *
 *  @param uid
 *  @param pagetime
 *  @param pagenum
 *  @param pagesize
 *  @param filterType
 *  @param orderType
 *  @param timeRange
 *  @param success
 *  @param error
 */
+(void)requestFeedUid:(NSInteger)uid
           currendUid:(NSInteger)currendUid
             pagetime:(NSString *)pagetime
              pageNum:(int       )pagenum
             pageSize:(int       )pagesize
           filterType:(int       )filterType
            orderType:(int       )orderType
            timeRange:(int       )timeRange
              success:(successDicBlock)success
                error:(errorBlock)error
{
    NSDictionary *params;// = @{@"uId":@(uid),@"pageTime":pagetime,@"pageNum":@(pagenum),@"pageSize":@(pagesize),
                           //  @"filterType":@(filterType),@"orderType":@(orderType),@"timeRange":@(timeRange)};
    if (uid == 0) {
        params =@{@"currentUId":@(currendUid),@"pageTime":pagetime,@"pageNum":@(pagenum),@"pageSize":@(pagesize),
                    @"filterType":@(filterType),@"orderType":@(orderType),@"timeRange":@(timeRange)};

    }else
    {
        params =@{@"uId":@(uid),@"currentUId":@(currendUid),@"pageTime":pagetime,@"pageNum":@(pagenum),@"pageSize":@(pagesize),
                  @"filterType":@(filterType),@"orderType":@(orderType),@"timeRange":@(timeRange)};
    }
    
    [[self class] requestPath:kfeedall requestMethod:SZRequestMethodGet parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"data"],@"");
         }
         else
             error(@"获取列表失败");
         NSLog(@"获取社长推荐Feed列表,按时间排序失败");
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         error(@"获取列表失败");
         NSLog(@"%@",err);
         NSLog(@"获取社长推荐Feed列表,按时间排序失败");
     }];
}

///获取视听详情++
+(void)requestFeedDetail:(NSInteger )uId
                  feedId:(NSInteger )feedId
                 success:(successDicBlock)success
                   error:(errorBlock)error
{
    [[self class] requestPath:[NSString stringWithFormat:@"%@%ld/%ld",kfeeddetail,(long)feedId,(long)[RequestData getUserInfo].uId] requestMethod:SZRequestMethodGet parameters:nil finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
                 success(responseObject[@"data"],@"");
         }
         else
         {
             error(@"获取视听详情失败""");
             NSLog(@"获取视听详情失败");
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         error(@"获取视听详情失败""");
         NSLog(@"%@",err);
         NSLog(@"获取视听详情失败");
     }];
}

/**
 *  @author xuyong, 16-07-26 18:07:54
 *
 *  @brief 一键发布
 *
 *  @param uId
 *  @param feeId
 *  @param success
 *  @param error
 */
+(void)requestFeedLanch:(NSDictionary *)param
                 success:(successBlock)success
                   error:(errorBlock)error
{
    NSLog(@"一键发布param--%@",param);
    [[self class] requestPath:kfeed requestMethod:SZRequestMethodPost parameters:param finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             [RequestServer showTip:@"提交审核成功"];
             NSLog(@"一键发布结果----%@",responseObject);
             success(@"用户发布成功");
         }
         else
         {
             NSLog(@"用户发布失败");
             error(@"用户发布失败");
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         [RequestServer showTip:@"发布失败"];
         NSLog(@"%@",err);
         error(@"用户发布失败");
     }];
}

///用户删除Fee++
+(void)requestFeedDelete:(NSInteger )uId
                   feeId:(NSInteger )feeId
                 success:(successBlock)success
                   error:(errorBlock)error
{
    [[self class] requestPath:[NSString stringWithFormat:@"%@%ld/%ld",kfeed,(long)uId,(long)feeId] requestMethod:SZRequestMethodDELETE parameters:nil finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
        {
            [RequestServer showTip:@"删除成功"];
             success(@"用户删除Fee成功");
         }
         else
         {
             [RequestServer showTip:@"删除失败"];
             NSLog(@"用户删除Fee失败");
             error(@"删除失败");
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
         NSLog(@"用户删除Fee失败");
     }];
}

///获取用户点赞的Feed列表,按时间排序++
+(void)requestFeedLike:(NSString *)pagetime
               pageNum:(int       )pagenum
              pageSize:(int       )pagesize
               success:(successDicBlock)success
                 error:(errorBlock)error
{
    NSDictionary *params = @{@"pageTime":pagetime,@"pageNum":@(pagenum),@"pageSize":@(pagesize)};
    
    [[self class] requestPath:[NSString stringWithFormat:@"%@%ld",kfeedlike,(long)[RequestData getUserInfo].uId] requestMethod:SZRequestMethodGet parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"data"],@"");
         }
         else
             NSLog(@"获取用户点赞的Feed列表,按时间排序失败");
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
         NSLog(@"获取用户点赞的Feed列表,按时间排序失败");
     }];
}

#pragma mark follow:关注接口
///查看是否已经关注
+(void)requestFollowIsFollowed:(NSInteger )followedId
                       success:(successDicBlock)success
                         error:(errorBlock)error
{
    NSDictionary *params = @{@"userId":@([RequestData getUserInfo].uId),@"followedId":@(followedId)};
    
    [[self class] requestPath:@"follow/isfollowed" requestMethod:SZRequestMethodGet parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
             success(responseObject[@"data"],@"");
         else
         {
             error(responseObject[@"msg"]);
             [RequestServer showTip:responseObject[@"msg"]];
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         error(@"获取是否关注失败");
         NSLog(@"%@",err);
     }];
}

///获取关注列表++
+(void)requestFollowFollows:(NSInteger )currentId
                    pageTime:(NSString *)pagetime
                     pageNum:(int       )pagenum
                    pageSize:(int       )pagesize
                     success:(successDicBlock)success
                       error:(errorBlock)error
{
    NSDictionary *params = @{@"currentId":@(currentId),@"pageTime":pagetime,@"pageNum":@(pagenum),@"pageSize":@(pagesize)};
    
    [[self class] requestPath:[NSString stringWithFormat:@"%@%ld",kfollowfollows,(long)currentId] requestMethod:SZRequestMethodGet parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"data"],@"");
         }
         else
             NSLog(@"获取关注列表失败");
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
         NSLog(@"获取关注失败");
     }];
}

///获取粉丝列表++
+(void)requestFollowFans:(NSInteger )currentId
                pageTime:(NSString *)pagetime
                 pageNum:(int       )pagenum
                pageSize:(int       )pagesize
                 success:(successDicBlock)success
                   error:(errorBlock)error
{
    NSDictionary *params = @{@"currentId":@(currentId),@"pageTime":pagetime,@"pageNum":@(pagenum),@"pageSize":@(pagesize)};
    
    [[self class] requestPath:[NSString stringWithFormat:@"%@%ld",kfollowfans,(long)currentId] requestMethod:SZRequestMethodGet parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"data"],@"");
         }
         else
             NSLog(@"获取粉丝列表失败");
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
         NSLog(@"获取粉丝列表失败");
     }];
}

///关注||取消关注++
+(void)requestFollow:(NSInteger )uId
             fUserId:(NSInteger )fUserId
            isfollow:(BOOL)isfollow
             success:(successBlock)success
               error:(errorBlock)error
{

    NSDictionary *params = @{@"uId":@(uId),@"fUserId":@(fUserId)};
    [[self class] requestPath:kfollow requestMethod:isfollow ? SZRequestMethodPost : SZRequestMethodDELETE parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
             success(responseObject[@"data"]);
         else
         {
             [RequestServer showAlert:responseObject[@"msg"]];
             error(@"关注失败");
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
         error(@"关注失败");

//         [RequestServer showAlert:isfollow ? @"关注失败,请重新尝试" : @"取消关注失败,请重新尝试"];
     }];
}

#pragma mark like
///点赞||取消点赞++
+(void)requestlike:(NSString *)uId
             feeId:(NSString *)feeId
            islike:(BOOL)islike
           success:(successBlock)success
             error:(errorBlock)error
{
    [[self class] requestPath:[NSString stringWithFormat:@"%@%@/%@",klike,uId,feeId]
                requestMethod:islike ? SZRequestMethodPost : SZRequestMethodDELETE
                   parameters:nil
                       finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"result"]);
         }
         else
         {
             [RequestServer showAlert:responseObject[@"msg"]];
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
         error(@"点赞失败");
//         [RequestServer showAlert:islike ? @"点赞失败,请重新尝试" : @"取消点赞失败,请重新尝试"];
     }];
}

#pragma mark comment:评论接口
///获Feed下的评论列表++
+(void)requestCommentFeed:(NSInteger )feeId
                pageTime:(NSString *)pagetime
                 pageNum:(int       )pagenum
                pageSize:(int       )pagesize
                 success:(successDicBlock)success
                   error:(errorBlock)error
{
    NSDictionary *params = @{@"pageTime":pagetime,@"pageNum":@(pagenum),@"pageSize":@(pagesize)};
    
    [[self class] requestPath:[NSString stringWithFormat:@"%@%ld",kcommentfeed,(long)feeId] requestMethod:SZRequestMethodGet parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"data"],@"");
         }
         else
         {
             error(@"获取列表失败");
             NSLog(@"获Feed下的评论列表");
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         error(@"获取列表失败");
         NSLog(@"%@",err);
         NSLog(@"获Feed下的评论列表");
     }];
}

///获取官方发布-节目下的评论列表++
+(void)requestCommentProgram:(NSInteger )proId
                    pageTime:(NSString *)pagetime
                     pageNum:(int       )pagenum
                    pageSize:(int       )pagesize
                     success:(successDicBlock)success
                       error:(errorBlock)error
{
    NSDictionary *params = @{@"pageTime":pagetime,@"pageNum":@(pagenum),@"pageSize":@(pagesize)};
    
    [[self class] requestPath:[NSString stringWithFormat:@"%@%ld",kcommentprogram,(long)proId] requestMethod:SZRequestMethodGet parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"data"],@"");
         }
         else
         {
             error(@"获取列表失败");
             NSLog(@"获节目下的评论列表");
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         error(@"获取官方发布-节目下的评论列表失败");
         NSLog(@"%@",err);
         NSLog(@"获取官方发布-节目下的评论列表");
     }];
}

///获官方发布-校哈社动态下的评论列表++
+(void)requestCommentTrend:(NSInteger )trdId
                  pageTime:(NSString *)pagetime
                   pageNum:(int       )pagenum
                  pageSize:(int       )pagesize
                   success:(successDicBlock)success
                     error:(errorBlock)error
{
    NSDictionary *params = @{@"pageTime":pagetime,@"pageNum":@(pagenum),@"pageSize":@(pagesize)};
    
    [[self class] requestPath:[NSString stringWithFormat:@"%@%ld",kcommenttrend,(long)trdId] requestMethod:SZRequestMethodGet parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"data"],@"");
         }
         else
         {
             error(@"获取列表失败");
             NSLog(@"校哈社动态下的评论列表失败");
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         error(@"校哈社动态下的评论列表失败");
         NSLog(@"%@",err);
         NSLog(@"校哈社动态下的评论列表失败");
     }];
}

///获官方发布-项目下的评论列表++
+(void)requestCommentProject:(NSInteger )proId
                    pageTime:(NSString *)pagetime
                     pageNum:(int       )pagenum
                    pageSize:(int       )pagesize
                     success:(successDicBlock)success
                       error:(errorBlock)error
{
    NSDictionary *params = @{@"pageTime":pagetime,@"pageNum":@(pagenum),@"pageSize":@(pagesize)};
    
    [[self class] requestPath:[NSString stringWithFormat:@"%@%ld",kcommentproject,(long)proId] requestMethod:SZRequestMethodGet parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"data"],@"");
         }
         else
         {
             error(@"获取列表失败");
             NSLog(@"项目下的评论列表失败");
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         error(@"项目下的评论列表失败");
         NSLog(@"%@",err);
         NSLog(@"项目下的评论列表失败");
     }];

}

///获取官方发布-论坛下的评论列表++
+(void)requestCommentForum:(NSInteger )forId
                  pageTime:(NSString *)pagetime
                   pageNum:(int       )pagenum
                  pageSize:(int       )pagesize
                   success:(successDicBlock)success
                     error:(errorBlock)error
{
    NSDictionary *params = @{@"pageTime":pagetime,@"pageNum":@(pagenum),@"pageSize":@(pagesize)};
    
    [[self class] requestPath:[NSString stringWithFormat:@"%@%ld",kcommentforum,(long)forId] requestMethod:SZRequestMethodGet parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"data"],@"");
         }
         else
         {
             error(@"获取列表失败");
             NSLog(@"论坛下的评论列表失败");
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         error(@"项目下的评论列表失败");
         NSLog(@"%@",err);
         NSLog(@"论坛下的评论列表失败");
     }];
}

///获取用户评论列表,按时间排序++
+(void)requestCommentLists:(NSInteger )uId
                  pageTime:(NSString *)pagetime
                   pageNum:(int       )pagenum
                  pageSize:(int       )pagesize
                   success:(successDicBlock)success
                     error:(errorBlock)error
{
    NSDictionary *params = @{@"pageTime":pagetime,@"pageNum":@(pagenum),@"pageSize":@(pagesize)};
    
    [[self class] requestPath:[NSString stringWithFormat:@"%@%ld",kcomment,(long)uId] requestMethod:SZRequestMethodGet parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"data"],@"");
         }
         else
         {
             error(@"获取列表失败");
             NSLog(@"用户评论列表失败");
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         error(@"用户评论列表失败");
         NSLog(@"%@",err);
         NSLog(@"用户评论列表失败");
     }];
}

///发布评论
+(void)requestCommitComment:(NSDictionary *)params
                   success:(successArrBlock)success
                     error:(errorBlock)error
{
    
    [[self class] requestPath:kcomment requestMethod:SZRequestMethodPost parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"data"],@"");
         }
         else
         {
             error(@"发布失败");
         }
             NSLog(@"获取用户评论列表,按时间排序");
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         error(@"发布失败");
         NSLog(@"%@",err);
         NSLog(@"获取用户评论列表,按时间排序");
     }];
}


///删除评论++
+(void)requestCommentLists:(NSInteger )uId
                     comId:(NSInteger )comId
                   success:(successBlock)success
                     error:(errorBlock)error
{
    [[self class] requestPath:[NSString stringWithFormat:@"%@%ld/%ld",kcomment,(long)uId,(long)comId] requestMethod:SZRequestMethodDELETE parameters:nil finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(@"删除评论成功");
         }
         else
             NSLog(@"删除评论失败");
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
         NSLog(@"删除评论失败");
     }];
}

#pragma mark program
///获取所有节目列表++
+(void)requestProgramAll:(NSString *)pagetime
                 pageNum:(int       )pagenum
                pageSize:(int       )pagesize
                 success:(successDicBlock)success
                   error:(errorBlock)error
{
    NSDictionary *params = @{@"pageTime":pagetime,@"pageNum":@(pagenum),@"pageSize":@(pagesize)};
    
    [[self class] requestPath:kprogramall requestMethod:SZRequestMethodGet parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"data"],@"");
         }
         else
         {
             [RequestServer showTip:@"获取最新节目列表失败"];
             error(@"");
         }
        NSLog(@"获取所有节目列表");
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         error(@"");
         NSLog(@"%@",err);
         NSLog(@"获取所有节目列表");
     }];
}

///用户删除节目++
+(void)requestProgramDelete:(NSInteger )uId
                      proId:(NSInteger )proId
                    success:(successBlock)success
                      error:(errorBlock)error
{
    [[self class] requestPath:[NSString stringWithFormat:@"%@%ld/%ld",kcomment,(long)uId,(long)proId] requestMethod:SZRequestMethodDELETE parameters:nil finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(@"用户删除节目成功");
         }
         else
             NSLog(@"用户删除节目失败");
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
         NSLog(@"用户删除节目失败");
     }];
}

///获取节目详情
+(void)requestProgarmDetailProId:(NSInteger)proId
                         success:(successDicBlock)success
                           error:(errorBlock)error
{
    [[self class] requestPath:[NSString stringWithFormat:@"program/detail/%ld",(long)proId] requestMethod:SZRequestMethodGet parameters:nil finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"data"],@"");
         }
         else
         {
             error(@"获取所有项目列表失败");
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         error(@"获取所有项目列表失败");
         NSLog(@"%@",err);
         NSLog(@"获取所有项目列表失败");
     }];
}


#pragma mark forum:官方发布-论坛接口
///获取我的哈论坛列表++
+(void)requestForumUid:(NSInteger)uid
               pagetime:(NSString *)pagetime
               forType:(int       )forType
               pageNum:(int       )pagenum
              pageSize:(int       )pagesize
               success:(successDicBlock)success
                 error:(errorBlock)error
{
    //"帖子分类 0:全部 1:意见反馈 2:技术交流 默认值 0
    NSDictionary *params = @{@"uId":@(uid),@"pageTime":pagetime,@"pageNum":@(pagenum),@"pageSize":@(pagesize),@"forType":@(forType)};
    
    [[self class] requestPath:kforumall requestMethod:SZRequestMethodGet parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"data"],@"");
         }
         else
             NSLog(@"获取所有校哈论坛列表失败");
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
         NSLog(@"获取所有校哈论坛列表失败");
     }];
}

///获取所有校哈论坛列表++
+(void)requestForumAll:(NSString *)pagetime
               forType:(int       )forType
               pageNum:(int       )pagenum
              pageSize:(int       )pagesize
               success:(successDicBlock)success
                 error:(errorBlock)error
{
    //"帖子分类 0:全部 1:意见反馈 2:技术交流 默认值 0
    NSDictionary *params = @{@"pageTime":pagetime,@"pageNum":@(pagenum),@"pageSize":@(pagesize),@"forType":@(forType)};
    
    [[self class] requestPath:kforumall requestMethod:SZRequestMethodGet parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"data"],@"");
         }
         else
             NSLog(@"获取所有校哈论坛列表失败");
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
         NSLog(@"获取所有校哈论坛列表失败");
     }];
}

///笑哈社论坛发布
+(void)requestForumLanch:(NSDictionary *)param
                 success:(successArrBlock)success
                   error:(errorBlock)error
{
    
    [[self class] requestPath:kforum requestMethod:SZRequestMethodPost parameters:param finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             [RequestServer showTip:@"发布成功"];
             success(responseObject[@"data"],@"");
         }
         else
         {
             [RequestServer showTip:@"发布失败"];
             NSLog(@"获取所有校哈论坛列表失败");
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
         NSLog(@"获取所有校哈论坛列表失败");
     }];
}



///用户删除论坛++
+(void)requestForumDelete:(NSInteger )uId
                    forId:(NSInteger )forId
                  success:(successBlock)success
                    error:(errorBlock)error
{
    [[self class] requestPath:[NSString stringWithFormat:@"forum/%ld/%ld",(long)uId,(long)forId] requestMethod:SZRequestMethodDELETE parameters:nil finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             [self showTip:@"删除成功"];
             success(@"用户删除节目成功");
         }
         else
         {
             [self showTip:@"删除失败"];
             NSLog(@"用户删除节目失败");
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
         NSLog(@"用户删除节目失败");
     }];
}

///获取节目详情
+(void)requestForumDetailProId:(NSInteger)proId
                         success:(successDicBlock)success
                           error:(errorBlock)error
{
    [[self class] requestPath:[NSString stringWithFormat:@"forum/detail/%ld",(long)proId] requestMethod:SZRequestMethodGet parameters:nil finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"data"],@"");
         }
         else
         {
             error(@"获取所有项目列表失败");
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         error(@"获取所有项目列表失败");
         NSLog(@"%@",err);
         NSLog(@"获取所有项目列表失败");
     }];
}

#pragma mark trend:官方发布-项目接口
///获取我参与的项目列表++
+(void)requestProjectInvolved:(NSInteger )uId
                  pagetime:(NSString *)pagetime
                 pageNum:(int       )pagenum
                pageSize:(int       )pagesize
                 success:(successDicBlock)success
                   error:(errorBlock)error
{
    NSDictionary *params = @{@"pageTime":pagetime,@"pageNum":@(pagenum),@"pageSize":@(pagesize),@"uId":@(uId)};
    
    [[self class] requestPath:@"project/candidate/involved" requestMethod:SZRequestMethodGet parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"data"],@"");
         }
         else
             NSLog(@"获取所有项目列表失败");
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
         NSLog(@"获取所有项目列表失败");
     }];
}

///获取所有项目列表++
+(void)requestProjectAll:(NSString *)pagetime
                 pageNum:(int       )pagenum
                pageSize:(int       )pagesize
                 success:(successDicBlock)success
                   error:(errorBlock)error
{
    NSDictionary *params = @{@"pageTime":pagetime,@"pageNum":@(pagenum),@"pageSize":@(pagesize)};
    
    [[self class] requestPath:kprojectall requestMethod:SZRequestMethodGet parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"data"],@"");
         }
         else
             NSLog(@"获取所有项目列表失败");
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
         NSLog(@"获取所有项目列表失败");
     }];
}

///用户删除项目++
+(void)requestProjectDelete:(NSInteger )uId
                      proId:(NSInteger )proId
                    success:(successBlock)success
                      error:(errorBlock)error
{
    [[self class] requestPath:[NSString stringWithFormat:@"%@%ld/%ld",kproject,(long)uId,(long)proId] requestMethod:SZRequestMethodDELETE parameters:nil finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             [self showTip:@"删除成功"];
             success(@"用户删除项目成功");
         }
         else{
             [self showTip:@"删除失败"];
             NSLog(@"用户删除项目失败");
             error(@"用户删除项目失败");
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
         NSLog(@"用户删除项目失败");
     }];
}

///项目报名++
+(void)requestProjectCandadite:(NSInteger )uId
                         proId:(NSInteger )proId
                       success:(successBlock)success
                         error:(errorBlock)error
{
    [[self class] requestPath:[NSString stringWithFormat:@"project/candidate/%ld/%ld",(long)uId,(long)proId] requestMethod:SZRequestMethodPost parameters:nil finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             [RequestServer showTip:@"报名成功"];
             success(@"项目报名成功");
         }
         else{
             [RequestServer showTip:responseObject[@"message"]];
             NSLog(@"项目报名失败");
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         [RequestServer showTip:@"报名失败"];
         NSLog(@"%@",err);
         NSLog(@"项目报名失败");
     }];
}

///同意报名请求++
+(void)requestProjectCandaditeAgree:(NSInteger )uId
                              proId:(NSInteger )proId
                            success:(successBlock)success
                              error:(errorBlock)error
{
    [[self class] requestPath:[NSString stringWithFormat:@"%@%ld/%ld",kprojectcandidateagree,(long)uId,(long)proId] requestMethod:SZRequestMethodPost parameters:nil finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(@"同意报名请求成功");
         }
         else
         {
             error(@"同意失败");
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
         error(@"同意失败");
         NSLog(@"同意报名请求失败");
     }];
}

///获取报名用户列表++
+(void)requestProjectCandaditeAllProId:(NSInteger)proId
                        pagetime:(NSString *)pagetime
                          pageNum:(int       )pagenum
                         pageSize:(int       )pagesize
                          success:(successDicBlock)success
                            error:(errorBlock)error
{
    NSDictionary *params = @{@"pageTime":pagetime,@"pageNum":@(pagenum),@"pageSize":@(pagesize),@"proId":@(proId)};
    
    [[self class] requestPath:kprojectcandidateall requestMethod:SZRequestMethodGet parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"data"],@"");
         }
         else
         {
             NSLog(@"获取报名用户列表失败");
             error(@"获取报名用户列表失败");
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
         error(@"获取报名用户列表失败""");
     }];
}


///获取项目详情++
+(void)requestProjectDetailProId:(NSInteger)proId
                      currentUId:(NSInteger)currentUId
                         success:(successDicBlock)success
                           error:(errorBlock)error
{
    NSDictionary *params = @{@"currentUId":@(currentUId)};
    
    [[self class] requestPath:[NSString stringWithFormat:@"%@/%ld",kprojectDetail,(long)proId] requestMethod:SZRequestMethodGet parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"data"],@"");
         }
         else
         {
             error(@"获取所有项目列表失败");
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         error(@"获取所有项目列表失败");
         NSLog(@"%@",err);
         NSLog(@"获取所有项目列表失败");
     }];
}

///项目结果发布
+(void)requestResultProId:(NSInteger)proId
                   result:(NSString *)result
                  success:(successBlock)success
                    error:(errorBlock)error
{
    NSDictionary *params = @{@"proId":@(proId),@"result":result};
    
    [[self class] requestPath:kprojectresult requestMethod:SZRequestMethodPost parameters:params doNotSerializer:true finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"data"]);
         }
         else
         {
             error(@"发布结果失败");
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         error(@"发布结果失败");
         NSLog(@"%@",err);
         NSLog(@"获取所有项目列表失败");
     }];
}
#pragma mark trend:官方发布-动态接口
///获取所有校哈动态列表++
+(void)requestTrendAll:(NSString *)pagetime
               pageNum:(int       )pagenum
              pageSize:(int       )pagesize
               success:(successDicBlock)success
                 error:(errorBlock)error
{
    NSDictionary *params = @{@"pageTime":pagetime,@"pageNum":@(pagenum),@"pageSize":@(pagesize)};
    
    [[self class] requestPath:ktrendall requestMethod:SZRequestMethodGet parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"data"],@"");
         }
         else
             NSLog(@"获取所有校哈动态列表失败");
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
         NSLog(@"获取所有校哈动态列表失败");
     }];
}

///用户删除校哈动态++
+(void)requestTrendDelete:(NSInteger )uId
                    treId:(NSInteger )treId
                  success:(successBlock)success
                    error:(errorBlock)error
{
    [[self class] requestPath:[NSString stringWithFormat:@"%@%ld/%ld",ktrend,(long)uId,(long)treId] requestMethod:SZRequestMethodDELETE parameters:nil finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(@"用户删除校哈动态成功");
         }
         else
             NSLog(@"用户删除校哈动态失败");
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
         NSLog(@"用户删除校哈动态失败");
     }];
}


///获取笑哈社详情++
+(void)requestDynamicDetailProId:(NSInteger)proId
                         success:(successDicBlock)success
                           error:(errorBlock)error
{
    
    [[self class] requestPath:[NSString stringWithFormat:@"trend/detail/%ld",(long)proId] requestMethod:SZRequestMethodGet parameters:nil finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"data"],@"");
         }
         else
         {
             error(@"获取所有项目列表失败");
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         error(@"获取所有项目列表失败");
         NSLog(@"%@",err);
         NSLog(@"获取所有项目列表失败");
     }];
}



#pragma mark message
///注册新闻相关完成推送
+(void)requestMsgRegister:(NSString *)uId
                   newsId:(NSString *)newsId
                  success:(successBlock)success
                    error:(errorBlock)error
{
    NSDictionary *params = @{@"uId":uId,@"nId":newsId};
    
    [[self class] requestPath:kmsgRegitser requestMethod:SZRequestMethodGet parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
         if(code==200)
         {
             success(responseObject[@"result"]);
         }
         else{
             //             [RequestServer showAlert:responseObject[@"msg"]];
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
     }];
}

///取消注册新闻相关完成推送
+(void)requestMsgUnregister:(NSString *)uId
                     newsId:(NSString *)newsId
                    success:(successBlock)success
                      error:(errorBlock)error
{
    NSDictionary *params = @{@"uId":uId,@"nId":newsId};
    
    [[self class] requestPath:kmsgUnregitser requestMethod:SZRequestMethodGet parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
         if(code==200)
         {
             success(responseObject[@"result"]);
         }
         else{
             //             [RequestServer showAlert:responseObject[@"msg"]];
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
     }];
}

#pragma mark video : 获取某个新闻下的视频列表
///获取某个新闻下的视频列表
+(void)requestNewsGetNews:(NSInteger )nid
                 pagetime:(NSInteger )pagetime
                  pagenum:(int       )pagenum
                 pagesize:(int       )pagesize
                  success:(successDicBlock)success
                    error:(errorBlock)error
{
    NSDictionary *params = [[NSDictionary alloc] init];
    //    if([RequestData getUserInfo])
    params = @{@"uId":@([RequestData getUserInfo].uId),@"nId":@(nid),@"pageTime":@(pagetime),@"pageNum":@(pagenum),@"pageSize":@(pagesize)};
    //    else
    //        params = @{@"nId":@(nid),@"pageTime":@(pagetime),@"pageNum":@(pagenum),@"pageSize":@(pagesize)};
    
    
    [[self class] requestPath:kmedia requestMethod:SZRequestMethodGet parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             NSDictionary *dataDic = responseObject[@"data"];
             success(dataDic,@"");
         }
         else{
             [self showTip:@"获取失败"];
             error(@"");
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
         error(@"");
     }];
}

///发布音/视频
+(void)requestMediaPublish:(NSInteger )mDuration
                      mUri:(NSString *)mUri
                 mediaType:(int       )mediaType
                       nId:(NSInteger )nId
                   thumUri:(NSString *)thumUri
                      pUid:(NSInteger )pUid
                   success:(successDicBlock)success
                     error:(errorBlock)error
{
    NSDictionary *params = @{@"mDuration":@(mDuration),@"mUri":mUri,@"mediaType":@(mediaType),@"nId":@(nId),@"thumUri":thumUri,@"pUid":@(pUid)};
    
    [[self class] requestPath:kmediaPublish requestMethod:SZRequestMethodPost parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(@{},@"");
             [self showTip:@"发布成功"];
             [[NSNotificationCenter defaultCenter] postNotificationName:@"REFRESH_VIDEO" object:nil];
         }
         else{
             [self showTip:@"发布失败"];
             error(@"");
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
         [self showTip:@"发布失败"];
         error(@"");
     }];
}

#pragma mark message
//获取我的消息列表
+(void)requestMessageList:(NSString *)pagetime
                  pagenum:(int       )pagenum
                 pagesize:(int       )pagesize
                  success:(successDicBlock)success
                    error:(errorBlock)error

{
    NSDictionary *params = @{@"pageTime":pagetime,
                             @"pageNum":@(pagenum),
                             @"pageSize":@(pagesize)};
    
    [[self class] requestPath:[NSString stringWithFormat:@"message/%ld",(long)[RequestData getUserInfo].uId] requestMethod:SZRequestMethodGet parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSLog(@"%@",responseObject);
         if([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"data"],nil);
         }else
         {
             error(@"获取消息列表失败");
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
         error(@"获取消息列表失败");
     }];
}

//清空我的消息列表
+(void)requestClearMessageList:(successDicBlock)success
                         error:(errorBlock)error

{
    [[self class] requestPath:[NSString stringWithFormat:@"message/%ld",(long)[RequestData getUserInfo].uId] requestMethod:SZRequestMethodDELETE parameters:nil finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSLog(@"%@",responseObject);
         if([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
             success(responseObject[@"data"],nil);
         else
             [self showTip:@"清空操作失败，请重新尝试"];
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
         [self showTip:@"清空操作失败，请重新尝试"];
     }];
}

//清空我的某一条消息
+(void)requestClearOneMessage:(NSInteger )mId
                      success:(successDicBlock)success
                        error:(errorBlock)error

{
    [[self class] requestPath:[NSString stringWithFormat:@"message/%ld/%ld",(long)[RequestData getUserInfo].uId,(long)mId] requestMethod:SZRequestMethodDELETE parameters:nil finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSLog(@"%@",responseObject);
         if([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"data"],nil);
         }
         else
             [self showTip:@"删除失败，请重新尝试"];
         
     } failure:^(NSURLSessionDataTask *task, NSError *err){
         NSLog(@"%@",err);
         [self showTip:@"删除失败，请重新尝试"];
     }];
}


#pragma mark collect
///收藏新闻
+(void)requestCollectNews:(NSInteger )created
                relatedId:(NSInteger )relatedId
                     type:(int       )type
                      uId:(NSInteger )uId
                  updated:(NSInteger )updated
                  success:(successBlock)success
                    error:(errorBlock)error
{
    NSDictionary *params = @{@"relatedId":@(relatedId),
                             @"uId":@(uId)
                             };
    
    [[self class] requestPath:kcollectnews requestMethod:SZRequestMethodPost parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(@"收藏成功");
             [self showTip:@"收藏成功"];
         }
         else
             [self showTip:@"收藏失败，请重新尝试"];
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
         [self showTip:@"收藏失败，请重新尝试"];
     }];
}

///获取收藏的新闻列表
+(void)requestCollectNewList:(NSInteger )uid
                    pagetime:(NSString *)pagetime
                     pagenum:(int       )pagenum
                    pagesize:(int       )pagesize
                     success:(successDicBlock)success
                       error:(errorBlock)error
{
    NSDictionary *params = @{@"uId":@(uid),
                             @"pageTime":pagetime,
                             @"pageNum":@(pagenum),
                             @"pageSize":@(pagesize)};
    
    [[self class] requestPath:kcollectnewsList requestMethod:SZRequestMethodGet parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"data"],@"收藏成功");
             //             [self showTip:@"收藏成功"];
         }
         else
             [self showTip:@"获取数据失败，请重新尝试"];
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         error(@"");
         DLog(@"%@",err);
         [self showTip:@"获取数据失败，请重新尝试"];
     }];
}

///删除收藏
+(void)requestCollectDelete:(NSInteger )uid
                  relatedId:(NSInteger )relatedId
                    success:(successBlock)success
                      error:(errorBlock)error
{
    NSDictionary *params = @{@"uId":@(uid),
                             @"relatedId":@(relatedId),
                             };
    [[self class] requestPath:[NSString stringWithFormat:@"collect/%ld/%ld",uid,relatedId] requestMethod:SZRequestMethodDELETE parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         if([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(@"删除收藏成功");
             [self showTip:@"删除收藏成功"];
         }
         else{
             [self showTip:@"删除收藏失败"];
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
         [self showTip:@"删除失败，请重新尝试"];
     }];
}


///获取收藏状态
+(void)requestcollectState:(NSInteger )relatedId
                       uId:(NSInteger )uId
                   success:(successDicBlock)success
                     error:(errorBlock)error
{
    NSDictionary *params = @{@"relatedId":@(relatedId),@"uId":@(uId)};
    
    [[self class] requestPath:kcollectState requestMethod:SZRequestMethodGet parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSLog(@"%@",responseObject);
         if([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject,@"");
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
     }];
}

#pragma mark - 意见反馈
///意见反馈
+(void)requestFeedBack:(NSString *)content
         senderContact:(NSString *)senderContact
               success:(successObjBlock)success
                 error:(errorBlock)error
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];//= @{@"content":content,@"senderContact":senderContact};
    [params setObject:content forKey:@"content"];
    if(senderContact.length != 0)
        [params setObject:senderContact forKey:@"senderContact"];
    if([RequestData getUserInfo] != nil)
        [params setObject:@([RequestData getUserInfo].uId) forKey:@"senderUid"];
    
    [[self class] requestPath:@"feedback/" requestMethod:SZRequestMethodPost parameters:params finish:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSLog(@"%@",responseObject);
         if([RequestServer checkInterfaceDataCode:responseObject[@"header"]])
         {
             success(responseObject[@"data"],nil);
         }
     } failure:^(NSURLSessionDataTask *task, NSError *err) {
         NSLog(@"%@",err);
     }];
}


#pragma mark 上传文件 fileType=file|image|audio|video
+ (void)requestUploadFile:(NSString *)fileType
                 filedata:(NSData   *)filedata
                  success:(successDicBlock)success
                    error:(errorBlock)errorB
{
    
    AFHTTPResponseSerializer *instance = [AFHTTPResponseSerializer serializer];
    instance.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", nil];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:FILE_URL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSString *fileName = [fileType isEqualToString:@"image"] ? @"a.png" : ([fileType isEqualToString:@"video"] ? @"a.mp4" : @"a.mp3");
        [formData appendPartWithFileData:filedata name:@"a" fileName:fileName mimeType:fileType];
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = instance;
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      
                      dispatch_async(dispatch_get_main_queue(), ^{
                          //Update the progress view
                          //                          [progressView setProgress:uploadProgress.fractionCompleted];
                          NSLog(@"%f",uploadProgress.fractionCompleted);
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          NSLog(@"Error: %@", error);
                          errorB(nil);
                      } else {
                          NSLog(@"%@ %@", response, responseObject);
                          NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
                          NSLog(@"%@",json);
                          success(json[@"data"][0],@"");
                      }
                  }];
    
    [uploadTask resume];
}

//弹出提示框
+ (void)showTip:(NSString *)tip
{
    CGSize size = [LabelTextSize getSuitSizeWithString:tip fontSize:14 bold:false sizeOfX:SCREEN_WIDTH - 40];
    if(size.height < 30)
        size.height = 30;
    else
        size.height+= 10;
    if(size.height < SCREEN_WIDTH - 60)
        size.height+= 20;
    
    UILabel *mainTipLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - size.width - 20)/2, (SCREEN_HEIGHT - size.height)/2, size.width + 20, size.height)];
    mainTipLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    mainTipLabel.text = tip;
    mainTipLabel.numberOfLines = 0;
    mainTipLabel.alpha = 0;
    mainTipLabel.layer.cornerRadius = 5;
    mainTipLabel.layer.masksToBounds = true;
    mainTipLabel.textAlignment = NSTextAlignmentCenter;
    mainTipLabel.backgroundColor = [UIColor blackColor];
    mainTipLabel.textColor = [UIColor whiteColor];
    [[UIApplication sharedApplication].keyWindow addSubview:mainTipLabel];
    
    
    [UIView animateWithDuration:1 animations:^{
        
        mainTipLabel.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1 animations:^{
            
            mainTipLabel.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            [mainTipLabel removeFromSuperview];
            
        }];
        
    }];
}

+ (void)showAlert:(NSString *)msg
{
    UIAlertView *staticAlert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                          message:msg
                                                         delegate:nil
                                                cancelButtonTitle:@"我知道了"
                                                otherButtonTitles:nil, nil];
    staticAlert.delegate = [self class];
    [staticAlert show];
}


@end
