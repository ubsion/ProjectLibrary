
#import "UIImage+TIXACategory.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (TIXACategory)

/*图片拉伸、平铺接口，兼容iOS5+*/
- (UIImage *)resizableImageWithCompatibleCapInsets:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode
{
    CGFloat version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 6.0) {
        return [self resizableImageWithCapInsets:capInsets resizingMode:resizingMode];
    } else if (version >= 5.0) {
        if (resizingMode == UIImageResizingModeStretch) {
            return [self stretchableImageWithLeftCapWidth:capInsets.left topCapHeight:capInsets.top];
        } else {//UIImageResizingModeTile
            return [self resizableImageWithCapInsets:capInsets];
        }
    } else {
        return [self stretchableImageWithLeftCapWidth:capInsets.left topCapHeight:capInsets.top];
    }
}

/*图片以ScaleToFit方式拉伸后的CGSize*/
- (CGSize)sizeOfScaleToFit:(CGSize)scaledSize
{
    CGFloat scaleFactor = scaledSize.width / scaledSize.height;
    CGFloat imageFactor = self.size.width / self.size.height;
    if (scaleFactor <= imageFactor) {//图片横向填充
        return CGSizeMake(scaledSize.width, scaledSize.width / imageFactor);
    } else {//纵向填充
        return CGSizeMake(scaledSize.height * imageFactor, scaledSize.height);
    }
}

/*将图片转向调整为向上*/
- (UIImage *)fixOrientation
{
    if (self.imageOrientation == UIImageOrientationUp) {
        return self;
    }
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [self drawInRect:CGRectMake(0.0, 0.0, self.size.width, self.size.height)];
    
    UIImage *fixedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return fixedImage;
    
//    // No-op if the orientation is already correct
//    if (self.imageOrientation == UIImageOrientationUp) return self;
//    
//    // We need to calculate the proper transformation to make the image upright.
//    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
//    CGAffineTransform transform = CGAffineTransformIdentity;
//    
//    NSInteger imageOrientation = self.imageOrientation;
//    switch (imageOrientation) {
//        case UIImageOrientationDown:
//        case UIImageOrientationDownMirrored:
//            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
//            transform = CGAffineTransformRotate(transform, M_PI);
//            break;
//            
//        case UIImageOrientationLeft:
//        case UIImageOrientationLeftMirrored:
//            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
//            transform = CGAffineTransformRotate(transform, M_PI_2);
//            break;
//            
//        case UIImageOrientationRight:
//        case UIImageOrientationRightMirrored:
//            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
//            transform = CGAffineTransformRotate(transform, -M_PI_2);
//            break;
//    }
//    
//    switch (imageOrientation) {
//        case UIImageOrientationUpMirrored:
//        case UIImageOrientationDownMirrored:
//            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
//            transform = CGAffineTransformScale(transform, -1, 1);
//            break;
//            
//        case UIImageOrientationLeftMirrored:
//        case UIImageOrientationRightMirrored:
//            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
//            transform = CGAffineTransformScale(transform, -1, 1);
//            break;
//    }
//    
//    // Now we draw the underlying CGImage into a new context, applying the transform
//    // calculated above.
//    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
//                                             CGImageGetBitsPerComponent(self.CGImage), 0,
//                                             CGImageGetColorSpace(self.CGImage),
//                                             CGImageGetBitmapInfo(self.CGImage));
//    CGContextConcatCTM(ctx, transform);
//    switch (self.imageOrientation) {
//        case UIImageOrientationLeft:
//        case UIImageOrientationLeftMirrored:
//        case UIImageOrientationRight:
//        case UIImageOrientationRightMirrored:
//            // Grr...
//            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
//            break;
//            
//        default:
//            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
//            break;
//    }
//    
//    // And now we just create a new UIImage from the drawing context
//    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
//    UIImage *img = [UIImage imageWithCGImage:cgimg];
//    CGContextRelease(ctx);
//    CGImageRelease(cgimg);
//    return img;
}

/*以ScaleToFit方式压缩图片*/
- (UIImage *)compressedImageWithSize:(CGSize)compressedSize
{
    if (CGSizeEqualToSize(self.size, CGSizeZero) || (self.size.width <= compressedSize.width && self.size.height <= compressedSize.height)) {//不用压缩
        return self;
    }
    
    CGSize scaledSize = [self sizeOfScaleToFit:compressedSize];
    
    //压缩大小，调整转向
    UIGraphicsBeginImageContext(scaledSize);
    [self drawInRect:CGRectMake(0.0, 0.0, scaledSize.width, scaledSize.height)];
    UIImage *compressedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return compressedImage;
}





- (UIImage *)applyLightEffect
{
    UIColor *tintColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    return [self applyBlurWithRadius:30 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}


- (UIImage *)applyExtraLightEffect
{
    UIColor *tintColor = [UIColor colorWithWhite:0.97 alpha:0.82];
    return [self applyBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}


- (UIImage *)applyDarkEffect
{
    UIColor *tintColor = [UIColor colorWithWhite:0.11 alpha:0.73];
    return [self applyBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}


- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor
{
    const CGFloat EffectColorAlpha = 0.6;
    UIColor *effectColor = tintColor;
    size_t componentCount = CGColorGetNumberOfComponents(tintColor.CGColor);
    if (componentCount == 2) {
        CGFloat b;
        if ([tintColor getWhite:&b alpha:NULL]) {
            effectColor = [UIColor colorWithWhite:b alpha:EffectColorAlpha];
        }
    }
    else {
        CGFloat r, g, b;
        if ([tintColor getRed:&r green:&g blue:&b alpha:NULL]) {
            effectColor = [UIColor colorWithRed:r green:g blue:b alpha:EffectColorAlpha];
        }
    }
    return [self applyBlurWithRadius:10 tintColor:effectColor saturationDeltaFactor:-1.0 maskImage:nil];
}


- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage
{
    // Check pre-conditions.
    if (self.size.width < 1 || self.size.height < 1) {
        NSLog (@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", self.size.width, self.size.height, self);
        return nil;
    }
    if (!self.CGImage) {
        NSLog (@"*** error: image must be backed by a CGImage: %@", self);
        return nil;
    }
    if (maskImage && !maskImage.CGImage) {
        NSLog (@"*** error: maskImage must be backed by a CGImage: %@", maskImage);
        return nil;
    }
    
    CGRect imageRect = { CGPointZero, self.size };
    UIImage *effectImage = self;
    
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
    if (hasBlur || hasSaturationChange) {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -self.size.height);
        CGContextDrawImage(effectInContext, imageRect, self.CGImage);
        
        vImage_Buffer effectInBuffer;
        effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
        
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
        
        if (hasBlur) {
            // A description of how to compute the box kernel width from the Gaussian
            // radius (aka standard deviation) appears in the SVG spec:
            // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
            //
            // For larger values of 's' (s >= 2.0), an approximation can be used: Three
            // successive box-blurs build a piece-wise quadratic convolution kernel, which
            // approximates the Gaussian kernel to within roughly 3%.
            //
            // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
            //
            // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
            //
            CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
            NSUInteger radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
            if (radius % 2 != 1) {
                radius += 1; // force radius to be odd so that the three box-blur methodology works.
            }
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, (uint32_t)radius, (uint32_t)radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, (uint32_t)radius, (uint32_t)radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, (uint32_t)radius, (uint32_t)radius, 0, kvImageEdgeExtend);
        }
        BOOL effectImageBuffersAreSwapped = NO;
        if (hasSaturationChange) {
            CGFloat s = saturationDeltaFactor;
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,  1,
            };
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            for (NSUInteger i = 0; i < matrixSize; ++i) {
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            if (hasBlur) {
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                effectImageBuffersAreSwapped = YES;
            }
            else {
                vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            }
        }
        if (!effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if (effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    // Set up output context.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.size.height);
    
    // Draw base image.
    CGContextDrawImage(outputContext, imageRect, self.CGImage);
    
    // Draw effect image.
    if (hasBlur) {
        CGContextSaveGState(outputContext);
        if (maskImage) {
            CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
        }
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }
    
    // Add in color tint.
    if (tintColor) {
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
        CGContextFillRect(outputContext, imageRect);
        CGContextRestoreGState(outputContext);
    }
    
    // Output image is ready.
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}
- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, self.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

///颜色生成纯色图片
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//给图片添加模糊效果
- (UIImage *)pr_boxBlurredImageWithRadius:(CGFloat)radius
{
    radius *= [UIScreen mainScreen].scale;
    radius = (NSUInteger)floor(radius * 3.f * sqrt(2.f * M_PI) / 4.f + .5f);
    radius *= .5f;
    if (!((NSUInteger)radius % 2)) {
        radius++;
    }
    
    CGImageRef inImageRef = self.CGImage;
    
    size_t width = CGImageGetWidth(inImageRef) * .5f;
    size_t height = CGImageGetHeight(inImageRef) * .5f;
    size_t rowBytes = CGImageGetBytesPerRow(inImageRef) * .5f;
    
    uint32_t *bitmapData = malloc(rowBytes * height);
    CGContextRef inContext = CGBitmapContextCreate(bitmapData,
                                                   width,
                                                   height,
                                                   8,
                                                   rowBytes,
                                                   CGImageGetColorSpace(inImageRef),
                                                   (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(inContext, CGRectMake(0, 0, width, height), inImageRef);
    
    vImage_Buffer inBuffer;
    inBuffer.width = CGBitmapContextGetWidth(inContext);
    inBuffer.height = CGBitmapContextGetHeight(inContext);
    inBuffer.rowBytes = CGBitmapContextGetBytesPerRow(inContext);
    inBuffer.data = CGBitmapContextGetData(inContext);
    
    void *pixelBuffer = malloc(rowBytes * height);
    vImage_Buffer outBuffer;
    outBuffer.width = width;
    outBuffer.height = height;
    outBuffer.rowBytes = rowBytes;
    outBuffer.data = pixelBuffer;
    
    vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, radius, radius, NULL, kvImageEdgeExtend);
    vImageBoxConvolve_ARGB8888(&outBuffer, &inBuffer, NULL, 0, 0, radius, radius, NULL, kvImageEdgeExtend);
    vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, radius, radius, NULL, kvImageEdgeExtend);
    
    CGContextRef outContext = CGBitmapContextCreate(outBuffer.data,
                                                    outBuffer.width,
                                                    outBuffer.height,
                                                    8,
                                                    outBuffer.rowBytes,
                                                    CGImageGetColorSpace(inImageRef),
                                                    (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    CGImageRef outImageRef = CGBitmapContextCreateImage(outContext);
    UIImage *outImage = [UIImage imageWithCGImage:outImageRef];
    
    CFRelease(outImageRef);
    CGContextRelease(outContext);
    free(pixelBuffer);
    free(bitmapData);
    CGContextRelease(inContext);
    
    return outImage;
}

//给图片添加模糊效果
- (UIImage *)pr_blurredImageWithRadius:(CGFloat)radius
{
    radius *= [UIScreen mainScreen].scale;
    radius = (NSUInteger)floor(radius * 3.f * sqrt(2.f * M_PI) / 4.f + .5f);
    radius *= .5f;
    if (!((NSUInteger)radius % 2)) {
        radius++;
    }
    
    CGImageRef inImageRef = self.CGImage;
    
    size_t width = CGImageGetWidth(inImageRef);
    size_t height = CGImageGetHeight(inImageRef);
    size_t rowBytes = CGImageGetBytesPerRow(inImageRef);
    
    uint32_t *bitmapData = malloc(rowBytes * height);
    CGContextRef inContext = CGBitmapContextCreate(bitmapData,
                                                   width,
                                                   height,
                                                   8,
                                                   rowBytes,
                                                   CGImageGetColorSpace(inImageRef),
                                                   (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(inContext, CGRectMake(0, 0, width, height), inImageRef);
    
    vImage_Buffer inBuffer;
    inBuffer.width = CGBitmapContextGetWidth(inContext);
    inBuffer.height = CGBitmapContextGetHeight(inContext);
    inBuffer.rowBytes = CGBitmapContextGetBytesPerRow(inContext);
    inBuffer.data = CGBitmapContextGetData(inContext);
    
    void *pixelBuffer = malloc(rowBytes * height);
    vImage_Buffer outBuffer;
    outBuffer.width = width;
    outBuffer.height = height;
    outBuffer.rowBytes = rowBytes;
    outBuffer.data = pixelBuffer;
    
    vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, radius, radius, NULL, kvImageEdgeExtend);
    vImageBoxConvolve_ARGB8888(&outBuffer, &inBuffer, NULL, 0, 0, radius, radius, NULL, kvImageEdgeExtend);
    vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, radius, radius, NULL, kvImageEdgeExtend);
    
    CGContextRef outContext = CGBitmapContextCreate(outBuffer.data,
                                                    outBuffer.width,
                                                    outBuffer.height,
                                                    8,
                                                    outBuffer.rowBytes,
                                                    CGImageGetColorSpace(inImageRef),
                                                    (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    CGImageRef outImageRef = CGBitmapContextCreateImage(outContext);
    UIImage *outImage = [UIImage imageWithCGImage:outImageRef];
    
    CFRelease(outImageRef);
    CGContextRelease(outContext);
    free(pixelBuffer);
    free(bitmapData);
    CGContextRelease(inContext);
    
    return outImage;
}


///添加水印
- (UIImage *)addWaterMark:(UIImage *)waterMark {
    UIGraphicsBeginImageContext(self.size);
    
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    if (self.size.width-(waterMark.size.width*4)<0) {
        CGFloat size_width = self.size.width/4;
        CGFloat size_height = size_width * waterMark.size.height/waterMark.size.width;
        
        UIImage *waterMark2 = [waterMark compressedImageWithSize:CGSizeMake(size_width, size_height)];
        
        [waterMark2 drawInRect:CGRectMake(10, 20, size_width, size_height)];
    }else {
        [waterMark drawInRect:CGRectMake(10, 20, waterMark.size.width, waterMark.size.height)];
    }
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}


@end
