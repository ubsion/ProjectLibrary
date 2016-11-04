//
//  NSObject+Until.m
//  SchoolSociety
//
//  Created by xuyong on 16/8/4.
//  Copyright © 2016年 xuyong. All rights reserved.
//

#import "NSObject+Until.h"
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVAssetImageGenerator.h>

@implementation NSObject (Until)
- (UIImage*)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 2) actualTime:NULL error:&thumbnailImageGenerationError];
    
    if (!thumbnailImageRef)
        DLog(@"thumbnailImageGenerationError %@", thumbnailImageGenerationError);
    
    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc] initWithCGImage:thumbnailImageRef] : nil;
    
    return thumbnailImage;
}

@end
