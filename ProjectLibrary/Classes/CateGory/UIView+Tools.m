//
//  UIView+Tools.m
//  SuiShouXianGou
//
//  Created by netting on 14-1-9.
//  Copyright (c) 2014年 netting. All rights reserved.
//

#import "UIView+Tools.h"

@implementation UIView (Tools)

- (CGFloat)szLeft {
    return self.frame.origin.x;
}

- (void)setSzLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = ceilf(x);
    self.frame = frame;
}

- (CGFloat)szTop {
    return self.frame.origin.y;
}

- (void)setSzTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = ceilf(y);
    self.frame = frame;
}

- (CGFloat)szRight {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setSzRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = ceilf(right - frame.size.width);
    self.frame = frame;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)szBottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setSzBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = ceilf(bottom - frame.size.height);
    self.frame = frame;
}

- (CGFloat)szCenterX {
    return self.center.x;
}

- (void)setSzCenterX:(CGFloat)centerX {
    self.center = CGPointMake(ceilf(centerX), self.center.y);
}

- (CGFloat)szCenterY {
    return self.center.y;
}

- (void)setSzCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, ceilf(centerY));
}

- (CGFloat)szWidth {
    return self.frame.size.width;
}

- (void)setSzWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = ceilf(width);
    self.frame = frame;
}

- (CGFloat)szHeight {
    return self.frame.size.height;
}

- (void)setSzHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = ceilf(height);
    self.frame = frame;
}

- (CGPoint)szOrigin {
    return self.frame.origin;
}

- (void)setSzOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)szSize {
    return self.frame.size;
}

- (void)setSzSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void) shake {
    CAKeyframeAnimation *keyAn = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [keyAn setDuration:0.5f];
    NSArray *array = [[NSArray alloc] initWithObjects:
                       [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                       [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
                       [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
                       [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                       [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
                       [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
                       [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                       [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
                       [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
                       [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                       nil];
    [keyAn setValues:array];
    NSArray *times = [[NSArray alloc] initWithObjects:
                       [NSNumber numberWithFloat:0.1f],
                       [NSNumber numberWithFloat:0.2f],
                       [NSNumber numberWithFloat:0.3f],
                       [NSNumber numberWithFloat:0.4f],
                       [NSNumber numberWithFloat:0.5f],
                       [NSNumber numberWithFloat:0.6f],
                       [NSNumber numberWithFloat:0.7f],
                       [NSNumber numberWithFloat:0.8f],
                       [NSNumber numberWithFloat:0.9f],
                       [NSNumber numberWithFloat:1.0f],
                       nil];
    [keyAn setKeyTimes:times];
    [self.layer addAnimation:keyAn forKey:@"TextAnim"];
}

@end
