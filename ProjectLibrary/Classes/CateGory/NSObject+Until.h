//
//  NSObject+Until.h
//  SchoolSociety
//
//  Created by xuyong on 16/8/4.
//  Copyright © 2016年 xuyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Until)
//获取视频第一针
- (UIImage*)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;
@end
