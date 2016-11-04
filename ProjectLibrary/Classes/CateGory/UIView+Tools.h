//
//  UIView+Tools.h
//  SuiShouXianGou
//
//  Created by netting on 14-1-9.
//  Copyright (c) 2014年 netting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Tools)

- (CGFloat)szLeft;
- (void)setSzLeft:(CGFloat)x;
- (CGFloat)szTop;
- (void)setSzTop:(CGFloat)y;
- (CGFloat)szRight;
- (void)setSzRight:(CGFloat)right;
- (CGFloat)szBottom;
- (void)setSzBottom:(CGFloat)bottom;
- (CGFloat)szCenterX;
- (void)setSzCenterX:(CGFloat)centerX;
- (CGFloat)szCenterY;
- (void)setSzCenterY:(CGFloat)centerY;
- (CGFloat)szWidth;
- (void)setSzWidth:(CGFloat)width;
- (CGFloat)szHeight;
- (void)setSzHeight:(CGFloat)height;
- (CGPoint)szOrigin;
- (void)setSzOrigin:(CGPoint)origin;
- (CGSize)szSize;
- (void)setSzSize:(CGSize)size;


- (void) shake;
@end
