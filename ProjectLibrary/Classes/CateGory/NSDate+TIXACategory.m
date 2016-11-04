
#import "NSDate+TIXACategory.h"
//#import "NSDateFormatter+TIXACategory.h"

@implementation NSDate (TIXACategory)

/*格式化日期描述*/
- (NSString *)formattedDateDescription
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];
	NSString *theDay = [dateFormatter stringFromDate:self];//日期的年月日
	NSString *currentDay = [dateFormatter stringFromDate:[NSDate date]];//当前年月日
    NSInteger timeInterval = -[self timeIntervalSinceNow];
    if (timeInterval < 60) {
        return @"1分钟内";
	} else if (timeInterval < 3600) {//1小时内
        return [NSString stringWithFormat:@"%ld分钟前", (long)timeInterval / 60];
	} else if (timeInterval < 21600) {//6小时内
        return [NSString stringWithFormat:@"%ld小时前", (long)timeInterval / 3600];
	} else if ([theDay isEqualToString:currentDay]) {//当天
		[dateFormatter setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:@"今天 %@", [dateFormatter stringFromDate:self]];
	} else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] == 86400) {//昨天
        [dateFormatter setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:@"昨天 %@", [dateFormatter stringFromDate:self]];
    } else {//以前
		[dateFormatter setDateFormat:@"MM-dd HH:mm"];
        return [dateFormatter stringFromDate:self];
	}
}
- (NSString *)calDateYesterdayOrBefore
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *theDay = [dateFormatter stringFromDate:self];//日期的年月日
    NSString *currentDay = [dateFormatter stringFromDate:[NSDate date]];//当前年月日
    //NSInteger timeInterval = -[self timeIntervalSinceNow];
    if ([theDay isEqualToString:currentDay])
    {//当天
        [dateFormatter setDateFormat:@"HH:mm"];
        //return @"今天";
        return [NSString stringWithFormat:@"今天 %@", [dateFormatter stringFromDate:self]];
    }
    else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] == 86400)
    {//昨天
        [dateFormatter setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:@"昨天 %@", [dateFormatter stringFromDate:self]];
    }
    else
    {//以前
        [dateFormatter setDateFormat:@"MM/dd HH:mm"];
        return [dateFormatter stringFromDate:self];
    }
}

+ (NSDate *)serverDate:(NSString *)serverString {
    NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:28800];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * date = [dateFormatter dateFromString:serverString];
    return date;
}

- (NSString *)toServerString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:28800];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * dateStr = [dateFormatter stringFromDate:self];
    return dateStr;
}

/*格式化日期描述*/
- (NSString *)formattedWaterDateDescription
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *theDay = [dateFormatter stringFromDate:self];//日期的年月日
    NSString *currentDay = [dateFormatter stringFromDate:[NSDate date]];//当前年月日
    NSInteger timeInterval = -[self timeIntervalSinceNow];
    if (timeInterval < 60) {
        return @"1分钟内";
    } else if (timeInterval < 3600) {//1小时内
        return [NSString stringWithFormat:@"%ld分钟前", (long)timeInterval / 60];
    } else if (timeInterval < 21600) {//6小时内
        return [NSString stringWithFormat:@"%ld小时前", (long)timeInterval / 3600];
    } else if ([theDay isEqualToString:currentDay]) {//当天
        [dateFormatter setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:@"今天 %@", [dateFormatter stringFromDate:self]];
    } else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] == 86400) {//昨天
        [dateFormatter setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:@"昨天 %@", [dateFormatter stringFromDate:self]];
    } else {//以前
        [dateFormatter setDateFormat:@"MM-dd"];
        return [dateFormatter stringFromDate:self];
    }
}
//简短时间  HH:mm:ss
- (NSString *)formattedShortDateDescription
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"HH:mm:ss"];
    return [formatter stringFromDate:self];
}
- (NSString *)formattedDateMonthDayDescription
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM/dd"];
    return [formatter stringFromDate:self];
}


- (NSString *)formatDateYYYYMMDD{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:28800];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"MM/dd/yy"];
    NSString * dateStr = [dateFormatter stringFromDate:self];
    return dateStr;
}

- (NSString *)formatDateYMD{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:28800];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSString * dateStr = [dateFormatter stringFromDate:self];
    return dateStr;
}




- (double)formatDateStamp{
    return [self timeIntervalSince1970];
}

+(NSDate *)formatStampToDate:(double)stamp
{
    return [NSDate dateWithTimeIntervalSince1970:stamp];
}

@end
