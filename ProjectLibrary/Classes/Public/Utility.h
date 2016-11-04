//
//  Utility.h
//  ManagementApp
//
//  Created by 邱成西 on 15/10/12.
//  Copyright © 2015年 suda_505. All rights reserved.
//

#import <Foundation/Foundation.h>

///公共类方法

@interface Utility : NSObject

#pragma mark - 判断字符串是否为空
+(BOOL)checkString:(NSString *)string;

#pragma mark - 获取本地图片
+(UIImage *)getImgWithImageName:(NSString *)imgName;

#pragma mark - 隐藏UITableView多余的分割线
+ (void)setExtraCellLineHidden: (UITableView *)tableView;

#pragma mark -  对图片data大小比例压缩
+(UIImage *)dealImageData:(UIImage *)image;

#pragma mark -  正则判断
+(BOOL)predicateText:(NSString *)text regex:(NSString *)regex;

#pragma mark - 显示大图
+(void)showImage:(UIImageView *)avatarImageView;

#pragma mark -  缩短数量描述，例如 51234 -> 5万
+ (NSString *)shortedNumberDesc:(NSUInteger)number;


+ (void)pushVC:(UIViewController *)vc targetVC:(UIViewController *)targetVC;
+ (void)popVC:(UIViewController *)vc;


+(NSString *)userDocumentPath;


+(NSString *)returnBackground:(NSString *)string;
+(NSString *)returnArrowBackground:(NSString *)string;
+(NSString *)returnProTitle:(NSInteger)tag;
+(NSInteger)returnProType:(NSString *)string;


+ (UIImage*)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;

+ (void)showTip:(NSString *)tip;
@end
