
#import <UIKit/UIKit.h>

@interface UIImage (TIXACategory)

///图片拉伸、平铺接口，兼容iOS5+
- (UIImage *)resizableImageWithCompatibleCapInsets:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode;

///图片以ScaleToFit方式拉伸后的CGSize
- (CGSize)sizeOfScaleToFit:(CGSize)scaledSize;

///将图片转向调整为向上
- (UIImage *)fixOrientation;

///以ScaleToFit方式压缩图片
- (UIImage *)compressedImageWithSize:(CGSize)compressedSize;



- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;
///设置图片透明图
- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha;

///颜色生成纯色图片
+ (UIImage *)imageWithColor:(UIColor *)color;

///给图片添加模糊效果
- (UIImage *)pr_boxBlurredImageWithRadius:(CGFloat)radius;
///给图片添加模糊效果(自用)
- (UIImage *)pr_blurredImageWithRadius:(CGFloat)radius;
///给图片添加水印
- (UIImage *)addWaterMark:(UIImage *)waterMark;




@end
