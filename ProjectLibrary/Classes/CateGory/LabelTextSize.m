//
//  HWLabelTextSize.m
//  PersonnelRegister
//
//  Created by 江苏宏创 on 14-4-15.
//  Copyright (c) 2014年 江苏宏创. All rights reserved.
//

#import "LabelTextSize.h"

@implementation LabelTextSize
//计算并绘制字符串文本大小
+(CGSize)getSuitSizeWithString:(NSString *)text fontSize:(float)fontSize bold:(BOOL)bold sizeOfX:(float)x
{
//    NSLog(@"%@",text);
    UIFont *font ;
    if (bold) {
        font = [UIFont boldSystemFontOfSize:fontSize];
    }else{
        font = [UIFont systemFontOfSize:fontSize];
    }
    
    CGSize constraint = CGSizeMake(x, MAXFLOAT);
    NSDictionary * attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    NSAttributedString *attributedText =[[NSAttributedString alloc]initWithString:text attributes:attributes];
    // 返回文本绘制所占据的矩形空间。
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize contentSize = rect.size;
    return contentSize;
}

@end
