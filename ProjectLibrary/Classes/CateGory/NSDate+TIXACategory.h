//
//  NSDate+TIXACategory.m
//  Lianxi
//
//  Created by Liusx on 12-7-16.
//  Copyright (c) 2012年 TIXA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (TIXACategory)

//- (NSString *)timeIntervalDescription;//距离当前的时间间隔描述
//- (NSString *)minuteDescription;/*精确到分钟的日期描述*/
//- (NSString *)minuteDescriptionNew;/*精确到分钟的日期描述*/
//- (NSString *)minuteDescriptionNewBrief;/*简短 日期描述*/
- (NSString *)formattedDateDescription;//格式化日期描述
- (NSString *)calDateYesterdayOrBefore;
+(NSDate *)serverDate:(NSString *)serverString;//会话收到消息，时间转换为服务器的时间
-(NSString *)toServerString; //发送消息，时间转换为服务器的时间

- (NSString *)formattedWaterDateDescription;

- (NSString *)formattedShortDateDescription;//简短时间  HH:mm:ss
- (NSString *)formattedDateMonthDayDescription; //  MM/dd
//- (NSString *)formattedForNowDescription;//now日期描述
//- (NSString *)formattedServerStringToStandardDate;

/**
 *  @author xuyong, 16-07-25 18:07:00
 *
 *  @brief 年月日描述
 *
 *  @return
 */
- (NSString *)formatDateYYYYMMDD;

/**
 *  @author xuyong, 16-07-25 19:07:04
 *
 *  @brief 转时间戳
 *
 *  @return
 */
- (double)formatDateStamp;

/**
 *  @author xuyong, 16-07-25 19:07:10
 *
 *  @brief 时间戳转日期
 *
 *  @param stamp
 *
 *  @return 
 */
+(NSDate *)formatStampToDate:(double)stamp;


/**
 *  @author xuyong, 16-08-22 12:08:53
 *
 *  @brief 滴啊有年月日日期格式输出
 *
 *  @return
 */
- (NSString *)formatDateYMD;


@end
