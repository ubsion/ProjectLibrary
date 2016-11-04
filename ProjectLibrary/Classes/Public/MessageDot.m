//
//  MessageDot.m
//  SchoolSociety
//
//  Created by xuyong on 16/8/11.
//  Copyright © 2016年 xuyong. All rights reserved.
//

#import "MessageDot.h"

@implementation MessageDot

+(UILabel *)showMessageDot:(CGRect)frame num:(NSInteger)num
{
    UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 20, 20)];
    subLabel.text = [NSString stringWithFormat:@"%ld",(long)num];
    subLabel.layer.cornerRadius = subLabel.szWidth/2;
    subLabel.layer.masksToBounds = true;
    subLabel.textAlignment = NSTextAlignmentCenter;
    subLabel.font = SYSTEM_FONT(12.0f);
    subLabel.textColor = [UIColor whiteColor];
    subLabel.backgroundColor = RGB_COLOR(227, 64, 175, 1.0f);
    return subLabel;
}

+(UIImageView *)showRedDotWithoutNum:(CGRect)frame
{
    UIImageView *newRedDot = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 8, 8)];
    newRedDot.image = [UIImage imageNamed:@"new_receive_message"];
    return newRedDot;
}

+(void)clearAllDots
{
    //通知数据
    NSInteger notatcount = [[NSUserDefaults standardUserDefaults] integerForKey:@"NOTATION_MESSAGE_COUNT"];
    //总消息数
    NSInteger count = [[NSUserDefaults standardUserDefaults] integerForKey:@"MESSAGE_COUNT"];
    //剩余消息数
    NSInteger leftCount =count - notatcount ;
    [[NSUserDefaults standardUserDefaults] setInteger:leftCount forKey:@"MESSAGE_COUNT"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RECEIVE_MSG" object:nil];
    
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"NOTATION_MESSAGE_COUNT"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

@end
