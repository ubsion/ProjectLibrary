//
//  DefaultView.m
//  NewsApp
//
//  Created by 邱成西 on 15/12/29.
//  Copyright © 2015年 xuyong. All rights reserved.
//

#import "DefaultView.h"

@interface DefaultView ()

@property (nonatomic, strong) UIImageView *img;

@property (nonatomic, strong) UILabel *lab;

@end


@implementation DefaultView

-(instancetype)initWithFrame:(CGRect)frame bottom:(CGFloat)bottom{
    self = [super initWithFrame:frame];
    if (self) {
        self.img = [[UIImageView alloc]initWithFrame:(CGRect){(SCREEN_WIDTH-200)/2,bottom>0?20:100,200,200}];
        self.img.image = [Utility getImgWithImageName:@"unload_image@2x"];
        [self addSubview:self.img];
        
        self.lab = [[UILabel alloc]initWithFrame:(CGRect){0,self.img.szBottom,SCREEN_WIDTH,20}];
        self.lab.font = [UIFont systemFontOfSize:15];
        self.lab.textAlignment = NSTextAlignmentCenter;
        self.lab.textColor = [UIColor colorWithHexString:@"b5b5b5"];//UIColorHex(b5b5b5);
        [self addSubview:self.lab];
        
        self.backgroundColor = [UIColor colorWithHexString:@"E8EFF3"];
    }
    return self;
}

+ (DefaultView *)defaultViewWithTips:(NSString *)tips bottom:(CGFloat)bottom {
    DefaultView *defaultView = [[DefaultView alloc]initWithFrame:(CGRect){0,bottom,SCREEN_WIDTH,SCREEN_HEIGHT-bottom} bottom:bottom];
    if (tips) {
        defaultView.lab.text = tips;
    }
    
    return defaultView;
}

-(void)setTips:(NSString *)tips {
    self.lab.text = tips;
}
@end
