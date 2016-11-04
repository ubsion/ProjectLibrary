//
//  MessageDot.h
//  SchoolSociety
//
//  Created by xuyong on 16/8/11.
//  Copyright © 2016年 xuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageDot : UILabel

+(UILabel *)showMessageDot:(CGRect)frame num:(NSInteger)num;

+(UIImageView *)showRedDotWithoutNum:(CGRect)frame;

+(void)clearAllDots;

@end
