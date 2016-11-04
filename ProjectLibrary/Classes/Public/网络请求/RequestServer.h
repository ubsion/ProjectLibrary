//
//  RequestServer.h
//  WatchAPP
//
//  Created by xuyong on 15/9/23.
//  Copyright (c) 2015年 xuyong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewHttpRequest.h"
#import "RequestData.h"


typedef void (^successBlock)(NSString *tipinfo);
typedef void (^errorBlock)(NSString *errorInfo);

typedef void (^successDicBlock)(NSDictionary *dic, NSString *tipInfo);
typedef void (^successArrBlock)(NSMutableArray *array, NSString *tipInfo);
typedef void (^successObjBlock)(NSObject *obj, NSString *tipInfo);

@interface RequestServer : NewHttpRequest<UIAlertViewDelegate>


#pragma mark public
///获取验证码
+(void)requestVerifyCode:(NSString *)phoneNum
                 success:(successBlock)success
                   error:(errorBlock)error;
///注册
+(void)requestsignup:(NSString *)phoneNum
            password:(NSString *)password
            vericode:(NSString *)vericode
             success:(successBlock)success
               error:(errorBlock)errorr;
///第三方登陆
+(void)requestThirdSignin:(NSString *)thirdAuthId
                   avatar:(NSString *)avatar
                 nickName:(NSString *)nickName
                   gender:(NSInteger )gender
           thirdAuthToken:(NSString *)thirdAuthToken
            thirdAuthType:(NSInteger )thirdAuthType //1微信
                  success:(successBlock)success
                    error:(errorBlock)error;

///登陆
+(void)requestsignin:(NSString *)phoneNum
            password:(NSString *)password
             success:(successBlock)success
               error:(errorBlock)error;
///重置密码
+(void)requestResetPsd:(NSString *)phoneNum
              password:(NSString *)password
              vericode:(NSString *)vericode
               success:(successBlock)success
                 error:(errorBlock)error;

//更新登录设备信息
+(void)requestUserSignInInfo:(NSString *)deviceToken
                     success:(successDicBlock)success
                       error:(errorBlock)error;
//删除登录设备信息
+(void)requestUserDeleteSignInInfo:(NSString *)deviceToken
                           success:(successDicBlock)success
                             error:(errorBlock)error;
#pragma mark user
/////更新用户信息++
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
//                       error:(errorBlock)error;
///更新用户信息++
+(void)requestUpdateUserInfo:(UserInfoModel *)model
                     success:(successBlock)success
                       error:(errorBlock)error;

///获取用户信息
+(void)requestGetUserInfo:(NSString *)uid
                currentId:(NSString *)currentId
                  success:(successDicBlock)success
                    error:(errorBlock)error;

///搜索用户++
+(void)requestSearchUser:(NSString *)target
                pageTime:(NSString *)pageTime
                 pageNum:(NSInteger )pageNum
                pageSize:(NSInteger )pageSize
                     uId:(NSInteger )uId
                 success:(successDicBlock)success
                   error:(errorBlock)error;

///注册个推clientId
+(void)requestregisterClinetId:(NSString *)clientId
                       success:(successDicBlock)success
                         error:(errorBlock)error;

///获取用户推送设置
+(void)requestUserGetPushSetting:(successDicBlock)success
                           error:(errorBlock)error;

//更新用户推送设置
+(void)requestUserUpdatePushSetting:(NSInteger )isAllPushOn
                    isCommentPushOn:(NSInteger )isCommentPushOn
                    isCollectPushOn:(NSInteger )isCollectPushOn
                            success:(successDicBlock)success
                              error:(errorBlock)error;


#pragma mark banner
///获取所有Banner列表++
+(void)requestBannerAll:(NSString *)pagetime
                pageNum:(int       )pagenum
               pageSize:(int       )pagesize
                success:(successArrBlock)success
                  error:(errorBlock)error;

///添加Banner++
+(void)requestBannerAdd:(NSString *)actionUrl
                  banId:(int       )banId
            coverHeight:(int       )coverHeight
             coverWidth:(int       )coverWidth
               coverUrl:(NSString *)coverUrl
                success:(successBlock)success
                  error:(errorBlock)error;

///用户删除Banner++
+(void)requestBannerDelete:(NSInteger )uId
                     banId:(NSInteger )banId
                   success:(successBlock)success
                     error:(errorBlock)error;

#pragma mark feed:Feed接口
///获取社长推荐Feed列表,按时间排序++
+(void)requestFeedAd:(NSString *)pagetime
             pageNum:(int       )pagenum
            pageSize:(int       )pagesize
             success:(successDicBlock)success
               error:(errorBlock)error;

///获取Feed列表,按时间排序++  "内容类型 0:全部 1:视频 2:音频 3:图片" 	"排序规则 0:上传时间 1:推荐数目 2:评论数目" "时间范围 0:不限 1:24小时内 2:7天内 3:30天内"
+(void)requestFeedAll:(NSString *)pagetime
              pageNum:(int       )pagenum
             pageSize:(int       )pagesize
           filterType:(int       )filterType
            orderType:(int       )orderType
            timeRange:(int       )timeRange
              success:(successDicBlock)success
                error:(errorBlock)error;

+(void)requestFeedUid:(NSInteger)uid
           currendUid:(NSInteger)currendUid
             pagetime:(NSString *)pagetime
              pageNum:(int       )pagenum
             pageSize:(int       )pagesize
           filterType:(int       )filterType
            orderType:(int       )orderType
            timeRange:(int       )timeRange
              success:(successDicBlock)success
                error:(errorBlock)error;

///获取视听详情++
+(void)requestFeedDetail:(NSInteger )uId
                  feedId:(NSInteger )feedId
                 success:(successDicBlock)success
                   error:(errorBlock)error;


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
                  error:(errorBlock)error;

///用户删除Fee++
+(void)requestFeedDelete:(NSInteger )uId
                   feeId:(NSInteger )feeId
                 success:(successBlock)success
                   error:(errorBlock)error;

///获取用户点赞的Feed列表,按时间排序++
+(void)requestFeedLike:(NSString *)pagetime
               pageNum:(int       )pagenum
              pageSize:(int       )pagesize
               success:(successDicBlock)success
                 error:(errorBlock)error;


#pragma mark follow:关注接口
///查看是否已经关注
+(void)requestFollowIsFollowed:(NSInteger )followedId
                       success:(successDicBlock)success
                         error:(errorBlock)error;
///获取关注列表++
+(void)requestFollowFollows:(NSInteger )currentId
                   pageTime:(NSString *)pagetime
                    pageNum:(int       )pagenum
                   pageSize:(int       )pagesize
                    success:(successDicBlock)success
                      error:(errorBlock)error;

///获取粉丝列表++
+(void)requestFollowFans:(NSInteger )currentId
                pageTime:(NSString *)pagetime
                 pageNum:(int       )pagenum
                pageSize:(int       )pagesize
                 success:(successDicBlock)success
                   error:(errorBlock)error;

///关注||取消关注
+(void)requestFollow:(NSInteger )uId
             fUserId:(NSInteger )fUserId
            isfollow:(BOOL)isfollow
             success:(successBlock)success
               error:(errorBlock)error;

#pragma mark like
///点赞||取消点赞++
+(void)requestlike:(NSString *)uId
             feeId:(NSString *)feeId
            islike:(BOOL)islike
           success:(successBlock)success
             error:(errorBlock)error;

#pragma mark comment:评论接口
///获Feed下的评论列表++
+(void)requestCommentFeed:(NSInteger )feeId
                 pageTime:(NSString *)pagetime
                  pageNum:(int       )pagenum
                 pageSize:(int       )pagesize
                  success:(successDicBlock)success
                    error:(errorBlock)error;

///获取官方发布-节目下的评论列表++
+(void)requestCommentProgram:(NSInteger )proId
                    pageTime:(NSString *)pagetime
                     pageNum:(int       )pagenum
                    pageSize:(int       )pagesize
                     success:(successDicBlock)success
                       error:(errorBlock)error;

///获官方发布-校哈社动态下的评论列表++
+(void)requestCommentTrend:(NSInteger )trdId
                  pageTime:(NSString *)pagetime
                   pageNum:(int       )pagenum
                  pageSize:(int       )pagesize
                   success:(successDicBlock)success
                     error:(errorBlock)error;

///获官方发布-项目下的评论列表++
+(void)requestCommentProject:(NSInteger )proId
                    pageTime:(NSString *)pagetime
                     pageNum:(int       )pagenum
                    pageSize:(int       )pagesize
                     success:(successDicBlock)success
                       error:(errorBlock)error;

///获取官方发布-论坛下的评论列表++
+(void)requestCommentForum:(NSInteger )forId
                  pageTime:(NSString *)pagetime
                   pageNum:(int       )pagenum
                  pageSize:(int       )pagesize
                   success:(successDicBlock)success
                     error:(errorBlock)error;

///获取用户评论列表,按时间排序++
+(void)requestCommentLists:(NSInteger )uId
                  pageTime:(NSString *)pagetime
                   pageNum:(int       )pagenum
                  pageSize:(int       )pagesize
                   success:(successDicBlock)success
                     error:(errorBlock)error;

///发布评论
+(void)requestCommitComment:(NSDictionary *)params
                    success:(successArrBlock)success
                      error:(errorBlock)error;

///删除评论++
+(void)requestCommentLists:(NSInteger )uId
                     comId:(NSInteger )comId
                   success:(successBlock)success
                     error:(errorBlock)error;

#pragma mark program
///获取所有节目列表++
+(void)requestProgramAll:(NSString *)pagetime
                 pageNum:(int       )pagenum
                pageSize:(int       )pagesize
                 success:(successDicBlock)success
                   error:(errorBlock)error;

///用户删除节目++
+(void)requestProgramDelete:(NSInteger )uId
                      proId:(NSInteger )proId
                    success:(successBlock)success
                      error:(errorBlock)error;

///获取节目详情
+(void)requestProgarmDetailProId:(NSInteger)proId
                         success:(successDicBlock)success
                           error:(errorBlock)error;

#pragma mark forum:官方发布-论坛接口
+(void)requestForumUid:(NSInteger)uid
              pagetime:(NSString *)pagetime
               forType:(int       )forType
               pageNum:(int       )pagenum
              pageSize:(int       )pagesize
               success:(successDicBlock)success
                 error:(errorBlock)error;
///获取所有校哈论坛列表++
+(void)requestForumAll:(NSString *)pagetime
               forType:(int       )forType
               pageNum:(int       )pagenum
              pageSize:(int       )pagesize
               success:(successDicBlock)success
                 error:(errorBlock)error;

///笑哈社论坛发布
+(void)requestForumLanch:(NSDictionary *)param
                 success:(successArrBlock)success
                   error:(errorBlock)error;



///用户删除论坛++
+(void)requestForumDelete:(NSInteger )uId
                    forId:(NSInteger )forId
                  success:(successBlock)success
                    error:(errorBlock)error;

///获取节目详情
+(void)requestForumDetailProId:(NSInteger)proId
                       success:(successDicBlock)success
                         error:(errorBlock)error;

#pragma mark trend:官方发布-项目接口
///获取我参与的项目列表++
+(void)requestProjectInvolved:(NSInteger )uId
                     pagetime:(NSString *)pagetime
                      pageNum:(int       )pagenum
                     pageSize:(int       )pagesize
                      success:(successDicBlock)success
                        error:(errorBlock)error;
///获取所有项目列表++
+(void)requestProjectAll:(NSString *)pagetime
                 pageNum:(int       )pagenum
                pageSize:(int       )pagesize
                 success:(successDicBlock)success
                   error:(errorBlock)error;

///用户删除项目++
+(void)requestProjectDelete:(NSInteger )uId
                      proId:(NSInteger )proId
                    success:(successBlock)success
                      error:(errorBlock)error;

///项目报名++
+(void)requestProjectCandadite:(NSInteger )uId
                         proId:(NSInteger )proId
                       success:(successBlock)success
                         error:(errorBlock)error;

///同意报名请求++
+(void)requestProjectCandaditeAgree:(NSInteger )uId
                              proId:(NSInteger )proId
                            success:(successBlock)success
                              error:(errorBlock)error;

///获取报名用户列表++
+(void)requestProjectCandaditeAllProId:(NSInteger)proId
                              pagetime:(NSString *)pagetime
                               pageNum:(int       )pagenum
                              pageSize:(int       )pagesize
                               success:(successDicBlock)success
                                 error:(errorBlock)error;


///获取所有项目列表++
+(void)requestProjectDetailProId:(NSInteger)proId
                      currentUId:(NSInteger)currentUId
                         success:(successDicBlock)success
                            error:(errorBlock)error;

///项目结果发布
+(void)requestResultProId:(NSInteger)proId
                   result:(NSString *)result
                   success:(successBlock)success
                     error:(errorBlock)error;


#pragma mark trend:官方发布-动态接口
///获取所有校哈动态列表++
+(void)requestTrendAll:(NSString *)pagetime
               pageNum:(int       )pagenum
              pageSize:(int       )pagesize
               success:(successDicBlock)success
                 error:(errorBlock)error;

///用户删除校哈动态++
+(void)requestTrendDelete:(NSInteger )uId
                    treId:(NSInteger )treId
                  success:(successBlock)success
                    error:(errorBlock)error;

///获取笑哈社详情++
+(void)requestDynamicDetailProId:(NSInteger)proId
                         success:(successDicBlock)success
                           error:(errorBlock)error;


#pragma mark message
///注册新闻相关完成推送
+(void)requestMsgRegister:(NSString *)uId
                   newsId:(NSString *)newsId
                  success:(successBlock)success
                    error:(errorBlock)error;
///取消注册新闻相关完成推送
+(void)requestMsgUnregister:(NSString *)uId
                     newsId:(NSString *)newsId
                    success:(successBlock)success
                      error:(errorBlock)error;


#pragma mark video : 获取某个新闻下的视频列表
///获取某个新闻下的视频列表
+(void)requestNewsGetNews:(NSInteger )nid
                 pagetime:(NSInteger )pagetime
                  pagenum:(int       )pagenum
                 pagesize:(int       )pagesize
                  success:(successDicBlock)success
                    error:(errorBlock)error;

///发布音/视频
+(void)requestMediaPublish:(NSInteger )mDuration
                      mUri:(NSString *)mUri
                 mediaType:(int       )mediaType
                       nId:(NSInteger )nId
                   thumUri:(NSString *)thumUri
                      pUid:(NSInteger )pUid
                   success:(successDicBlock)success
                     error:(errorBlock)error;

#pragma mark message
//获取我的消息列表
+(void)requestMessageList:(NSString *)pagetime
                  pagenum:(int       )pagenum
                 pagesize:(int       )pagesize
                  success:(successDicBlock)success
                    error:(errorBlock)error;

//清空我的消息列表
+(void)requestClearMessageList:(successDicBlock)success
                         error:(errorBlock)error;

//清空我的某一条消息
+(void)requestClearOneMessage:(NSInteger )mId
                      success:(successDicBlock)success
                        error:(errorBlock)error;

#pragma mark collect
///收藏新闻
+(void)requestCollectNews:(NSInteger )created
                relatedId:(NSInteger )relatedId
                     type:(int       )type
                      uId:(NSInteger )uId
                  updated:(NSInteger )updated
                  success:(successBlock)success
                    error:(errorBlock)error;
///获取收藏的新闻列表
+(void)requestCollectNewList:(NSInteger )uid
                    pagetime:(NSString *)pagetime
                     pagenum:(int       )pagenum
                    pagesize:(int       )pagesize
                     success:(successDicBlock)success
                       error:(errorBlock)error;
///删除收藏
+(void)requestCollectDelete:(NSInteger )uid
                  relatedId:(NSInteger )relatedId
                    success:(successBlock)success
                      error:(errorBlock)error;

///获取收藏状态
+(void)requestcollectState:(NSInteger )relatedId
                       uId:(NSInteger )uId
                   success:(successDicBlock)success
                     error:(errorBlock)error;

#pragma mark - 意见反馈
///意见反馈
+(void)requestFeedBack:(NSString *)content
         senderContact:(NSString *)senderContact
               success:(successObjBlock)success
                 error:(errorBlock)error;

#pragma mark 上传文件 fileType=file|image|audio|video
+ (void)requestUploadFile:(NSString *)fileType
                 filedata:(NSData   *)filedata
                  success:(successDicBlock)success
                    error:(errorBlock)error;

+ (void)showTip:(NSString *)tip;

+ (void)showAlert:(NSString *)msg;

/**
 *  @author 邱成西, 16-12-30 13:12:42
 *
 *  判断header里面的code
 *
 *  @param dic heade的字典
 */
+ (BOOL)checkInterfaceDataCode:(NSDictionary *)dic;
@end
