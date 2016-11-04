//
//  SZFileManager.h
//  Lianxi
//
//  Created by wangzhi on 15/3/27.
//  Copyright (c) 2015年 TIXA. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SZFileManager : NSObject

//保存文件到当前用户目录下
+(void)saveFileToLoginUserPath:(NSDictionary*)dictionary fileName:(NSString*)fileName;

+(NSDictionary*)readFileToLoginUserPath:(NSString*)fileName;

+(void)saveArrayFileToLoginUserPath:(NSArray*)array fileName:(NSString*)fileName;

+(NSArray*)readArrayFileToLoginUserPath:(NSString*)fileName;

+(void)deleteDicToLoginUserPath:(NSInteger )indexR fileName:(NSString*)fileName;

+(NSString *)userDocumentPath;


+(float)folderSizeAtPath;
///清理缓存
+(void)clearCache;

//保存到相册
+(void)saveVideoToAlbum:(NSString *)filePath
                success:(void (^)(NSString *tip))success
                failure:(void (^)(NSString *error))failure;


+ (double) freeDiskSpaceInBytes;

@end
