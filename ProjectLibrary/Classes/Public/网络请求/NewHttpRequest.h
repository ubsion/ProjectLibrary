//
//  WatchHttpRequest.h
//  WatchAPP
//
//  Created by 王志 on 15/9/24.
//  Copyright (c) 2015年 xuyong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    SZRequestMethodGet     = 0,    // GET
    SZRequestMethodPost    = 1,    // POST
    SZRequestMethodPUT     = 2,    // PUT
    SZRequestMethodPATCH   = 3,    // PATCH
    SZRequestMethodDELETE  = 4,    // DELETE
    SZRequestMethodHEAD    = 5,    // HEAD
    SZRequestMethodOther   = 6
} SZRequestMethod;

typedef void (^AFFinishBlock)(NSURLSessionDataTask *task, id responseObject);

typedef void (^AFFailureBlock)(NSURLSessionDataTask *task, NSError *error);

@interface NewHttpRequest : NSObject

+ (void)cancelOperation;
/**
 *  @author 王志, 15-05-26 13:05:26
 *
 *  @brief  网络基本请求
 *
 *  @param domainPath    完整的请求url
 *  @param requestMethod 请求方式
 *  @param parameters    参数
 *  @param finish        完成block
 *  @param failure       失败block
 */
+ (void)requestPath:(NSString *)domainPath
      requestMethod:(SZRequestMethod)requestMethod
         parameters:(NSDictionary *)parameters
             finish:(AFFinishBlock)finish
            failure:(AFFailureBlock)failure;


/**
 *  @author xuyong, 16-07-25 14:07:07
 *
 *  @brief 带有判断序列化的请求
 *
 *  @param domainPath
 *  @param requestMethod
 *  @param parameters
 *  @param isSerializer
 *  @param finish
 *  @param failure
 */
+ (void)requestPath:(NSString *)domainPath
      requestMethod:(SZRequestMethod)requestMethod
         parameters:(NSDictionary *)parameters
       doNotSerializer:(BOOL)doNotSerializer
             finish:(AFFinishBlock)finish
            failure:(AFFailureBlock)failure;

@end