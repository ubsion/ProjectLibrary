//
//  SZFileManager.m
//  Lianxi
//
//  Created by wangzhi on 15/3/27.
//  Copyright (c) 2015年 TIXA. All rights reserved.
//

#import "SZFileManager.h"
#import "RequestData.h"


#include <sys/param.h>
#include <sys/mount.h>

#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAssetRepresentation.h>

@implementation SZFileManager

+(void)saveFileToLoginUserPath:(NSDictionary*)dictionary fileName:(NSString*)fileName
{
    NSString *filePath =[[self userDocumentPath] stringByAppendingFormat:@"%@.plist",fileName];
    if ([dictionary writeToFile:filePath atomically:YES]) {
        NSLog(@"数组保存为属性列表文件成功!");
    }
    else{
        NSLog(@"数组保存为属性列表文件不成功");
    }
}

+(NSDictionary*)readFileToLoginUserPath:(NSString*)fileName
{
   NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:[[self userDocumentPath] stringByAppendingFormat:@"%@.plist",fileName]];
    if(dic == nil){
        dic = [NSDictionary dictionary];
    }
    return dic;
}

///以数组形式存数数据
+(void)saveArrayFileToLoginUserPath:(NSArray*)array fileName:(NSString*)fileName
{
    NSString *fileFullName = [NSString stringWithFormat:@"News_%ld_%@",[RequestData getUserInfo].uId,fileName];
    NSString *filePath =[[self userDocumentPath] stringByAppendingFormat:@"%@.plist",fileFullName];
    
    DLog(@"filePath = %@",filePath);
    //存文件前 如果存在 先清空数据
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSError *error;
    if([fileManager fileExistsAtPath:filePath])
    {
        [fileManager removeItemAtPath:filePath error:&error];
        if(error)
        {
            NSLog(@"%@",[error description]);
        }
    }
    
    [NSKeyedArchiver archiveRootObject:array toFile:filePath];
}

+(NSArray*)readArrayFileToLoginUserPath:(NSString*)fileName
{
    NSString *fileFullName = [NSString stringWithFormat:@"News_%ld_%@",[RequestData getUserInfo].uId,fileName];
    
    NSString *filePath =[[self userDocumentPath] stringByAppendingFormat:@"%@.plist",fileFullName];
    
    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    if(arr == nil){
        arr = @[];
    }
//    NSFileManager *fileManager=[NSFileManager defaultManager];
//    [fileManager removeItemAtPath:filePath error:nil];
    
    return arr;
}

///删除数组中的某一条数据
+(void)deleteDicToLoginUserPath:(NSInteger )indexR fileName:(NSString*)fileName
{
    NSString *fileFullName = [NSString stringWithFormat:@"News_%ld_%@",(long)[RequestData getUserInfo].uId,fileName];
    NSString *filePath =[[self userDocumentPath] stringByAppendingFormat:@"%@.plist",fileFullName];

    NSMutableArray *tmp = [NSMutableArray arrayWithArray:[self readArrayFileToLoginUserPath:fileName]];
    [tmp removeObjectAtIndex:indexR];
    [tmp writeToFile:filePath atomically:true];
}
///end by liyun

+(NSString *)userDocumentPath
{
    NSString* path= [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingFormat:@"/%ld/SZ/",(long)[RequestData getUserInfo].uId];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    NSError *error;
    if(![fileManager fileExistsAtPath:path])
    {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if(error)
        {
            NSLog(@"%@",[error description]);
        }
    }
    return path;
}

///计算文件缓存
+(float)fileSizeAtPath:(NSString *)path
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}

+(float)folderSizeAtPath{
    NSString *path = [self userDocumentPath];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize = 0;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            NSLog(@"absolutePathsize -- %f",[self fileSizeAtPath:absolutePath]);
            folderSize +=[self fileSizeAtPath:absolutePath];
        }
        //SDWebImage框架自身计算缓存的实现
        NSLog(@"[self fileSizeAtPath:absolutePath] -- %f",[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0);
        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        NSLog(@"folderSize --- %f",folderSize);
        return folderSize;
    }
    return 0;
}

///清理缓存
+(void)clearCache
{
    NSString *path = [self userDocumentPath];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];

}


#pragma mark - 保存到相册
+(void)saveVideoToAlbum:(NSString *)filePath
                success:(void (^)(NSString *tip))success
                failure:(void (^)(NSString *error))failure
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library writeVideoAtPathToSavedPhotosAlbum:[NSURL fileURLWithPath:filePath]
                                completionBlock:^(NSURL *assetURL, NSError *error) {
                                    if (error) {
                                        NSLog(@"Save video fail:%@",error);
                                        failure(@"保存失败");
                                    } else {
                                        NSLog(@"Save video succeed.");
                                        success(@"保存成功");
                                        //删除当前的资源
                                        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
                                    }
                                }];
}


/**
 *  @author xuyong, 16-08-30 15:08:13
 *
 *  @brief 获取磁盘剩余空间大小,单位MB
 *
 *  @return
 */
+ (double) freeDiskSpaceInBytes{
    struct statfs buf;
    long long freespace = -1;
    if(statfs("/var", &buf) >= 0){
        freespace = (long long)(buf.f_bsize * buf.f_bfree);
    }
    return freespace/1024/1024;
    
//    return [NSString stringWithFormat:@"手机剩余存储空间为：%qi MB" ,freespace/1024/1024];
}

@end
