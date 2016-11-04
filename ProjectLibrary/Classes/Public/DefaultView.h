//
//  DefaultView.h
//  NewsApp
//
//  Created by 邱成西 on 15/12/29.
//  Copyright © 2015年 xuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DefaultView : UIView

+ (DefaultView *)defaultViewWithTips:(NSString *)tips bottom:(CGFloat)bottom;

-(void)setTips:(NSString *)tips;
@end
