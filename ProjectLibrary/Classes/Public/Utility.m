//
//  Utility.m
//  ManagementApp
//
//  Created by 邱成西 on 15/10/12.
//  Copyright © 2015年 suda_505. All rights reserved.
//

#import "Utility.h"

#import "LabelTextSize.h"

static UIImageView *orginImageView;

@implementation Utility

#pragma mark - 判断字符串是否为空

+(BOOL)checkString:(NSString *)string {
    if (string.length==0) {
        return NO;
    }
    if (string == nil || string == NULL) {
        return NO;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return NO;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return NO;
    }
    return YES;
}

#pragma mark - 获取本地图片

+(UIImage *)getImgWithImageName:(NSString *)imgName{
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imgName ofType:@".png"]];
}

#pragma mark - 隐藏UITableView多余的分割线

+ (void)setExtraCellLineHidden: (UITableView *)tableView {
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

#pragma mark -  对图片data大小比例压缩

+(UIImage *)dealImageData:(UIImage *)image {
    
    CGFloat compression = 1.0f;
    CGFloat maxCompression = 0.1f;
    int maxFileSize = 200*1024;
    
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    
    while ([imageData length] > maxFileSize && compression > maxCompression)
    {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    
    return [UIImage imageWithData:imageData];
}

#pragma mark -  正则判断

+(BOOL)predicateText:(NSString *)text regex:(NSString *)regex {
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![test evaluateWithObject:text]){
        return NO;
    }else {
        return YES;
    }
}

#pragma mark - 显示大图

+(void)showImage:(UIImageView *)avatarImageView{
    UIImage *image=avatarImageView.image;
    orginImageView = avatarImageView;
    orginImageView.alpha = 0;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    CGRect oldframe=[avatarImageView convertRect:avatarImageView.bounds toView:window];
    backgroundView.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.7];
    backgroundView.alpha=1;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    imageView.image=image;
    imageView.tag=1;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}

+(void)hideImage:(UITapGestureRecognizer*)tap{
    UIView *backgroundView=tap.view;
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=[orginImageView convertRect:orginImageView.bounds toView:[UIApplication sharedApplication].keyWindow];
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
        orginImageView.alpha = 1;
        backgroundView.alpha=0;
    }];
}

#pragma mark -  缩短数量描述，例如 51234 -> 5万

+ (NSString *)shortedNumberDesc:(NSUInteger)number {
    if (number <= 9999) return [NSString stringWithFormat:@"%d", (int)number];
    if (number <= 9999999) return [NSString stringWithFormat:@"%d万", (int)(number / 10000)];
    
    return [NSString stringWithFormat:@"%d千万", (int)(number / 10000000)];
}


+ (void)pushVC:(UIViewController *)vc targetVC:(UIViewController *)targetVC{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.25;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    transition.delegate = vc;
    [vc.navigationController.view.layer addAnimation:transition forKey:nil];
    [vc.navigationController pushViewController:targetVC animated:NO];
}
+ (void)popVC:(UIViewController *)vc {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.25;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromBottom;
    transition.delegate = vc;
    [vc.navigationController.view.layer addAnimation:transition forKey:nil];
    [vc.navigationController popViewControllerAnimated:NO];
}

+(NSString *)userDocumentPath
{
    NSString* path= [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingFormat:@"/%ld/Media/",[RequestData getUserInfo].uId];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    NSError *error;
    if(![fileManager fileExistsAtPath:path])
    {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    }
    return path;
}


+(NSString *)returnBackground:(NSString *)string {
    if ([string isEqualToString:@"摄影师"]) {
        return @"tag_3";
    }else if ([string isEqualToString:@"记者"]) {
        return @"tag_4";
    }else if ([string isEqualToString:@"编辑"]) {
        return @"tag_2";
    }else if ([string isEqualToString:@"演员"]) {
        return @"tag_0";
    }
    return @"tag_1";
}

+(NSString *)returnArrowBackground:(NSString *)string {
    if ([string isEqualToString:@"校园爆料"]) {
        return @"label_2";
    }else if ([string isEqualToString:@"校园采访"]) {
        return @"label_0";
    }else if ([string isEqualToString:@"学生自拍"]) {
        return @"label_3";
    }
    return @"label_1";
}


+(NSString *)returnProTitle:(NSInteger)tag {
    switch (tag) {
        case 0:
            return @"校园爆料";
            break;
            
        case 1:
            return @"校园采访";
            break;
            
        case 2:
            return @"学生自拍";
            break;
            
        case 3:
            return @"其他";
            break;
            
        default:
            return @"其他";
            break;
    }
}

+(NSInteger)returnProType:(NSString *)string {
    if ([string isEqualToString:@"校园爆料"]) {
        return 0;
    }else if ([string isEqualToString:@"校园采访"]) {
        return 1;
    }else if ([string isEqualToString:@"学生自拍"]) {
        return 2;
    }
    return 3;
}

//弹出提示框
+ (void)showTip:(NSString *)tip
{
    CGSize size = [LabelTextSize getSuitSizeWithString:tip fontSize:14 bold:false sizeOfX:SCREEN_WIDTH - 40];
    if(size.height < 30)
        size.height = 30;
    else
        size.height+= 10;
    if(size.height < SCREEN_WIDTH - 60)
        size.height+= 20;
    
    UILabel *mainTipLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - size.width - 20)/2, (SCREEN_HEIGHT - size.height)/2, size.width + 20, size.height)];
    mainTipLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    mainTipLabel.text = tip;
    mainTipLabel.numberOfLines = 0;
    mainTipLabel.alpha = 0;
    mainTipLabel.layer.cornerRadius = 5;
    mainTipLabel.layer.masksToBounds = true;
    mainTipLabel.textAlignment = NSTextAlignmentCenter;
    mainTipLabel.backgroundColor = [UIColor blackColor];
    mainTipLabel.textColor = [UIColor whiteColor];
    [[UIApplication sharedApplication].keyWindow addSubview:mainTipLabel];
    
    
    [UIView animateWithDuration:1 animations:^{
        
        mainTipLabel.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1 animations:^{
            
            mainTipLabel.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            [mainTipLabel removeFromSuperview];
            
        }];
        
    }];
}


@end
