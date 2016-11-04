//
//  SS_NavBarView.m
//  SchoolSociety
//
//  Created by 邱成西 on 16/6/20.
//  Copyright © 2016年 xuyong. All rights reserved.
//

#import "SS_NavBarView.h"

#import "UIButton+WebCache.h"

@interface SS_NavBarView ()

@property (nonatomic, strong) UIView *redPointView;

@property (nonatomic,strong) UIImageView *backImageView;

@end

@implementation SS_NavBarView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self){
        
        self.clipsToBounds = YES;
        self.rightEnable = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.backImageView];
        
    }
    return self;
}

#pragma mark - 红点

-(UIView *)redPointView {
    if (!_redPointView) {
        _redPointView = [[UIView alloc]initWithFrame:(CGRect){self.szWidth-15,25,8,8}];
        _redPointView.backgroundColor = [UIColor redColor];
        _redPointView.layer.cornerRadius = 4;
        _redPointView.layer.masksToBounds = true;
        
        [self addSubview:_redPointView];
    }
    return _redPointView;
}

- (void)addRedPoint {
    [self redPointView];
}
- (void)removeRedPoint {
    [self.redPointView removeFromSuperview];
    self.redPointView = nil;
}

#pragma mark - getter/setter

-(void)setBackColor:(UIColor *)backgroundColor {
    self.backgroundColor = backgroundColor;
}

-(void)removeViewWithTag:(NSUInteger)tag {
    UIView *view = [self viewWithTag:tag];
    view.hidden = true;
    [view removeFromSuperview];
    view = nil;
}

///设置左侧按钮 0=图片  1=文字  2=网络图片
-(void)setLeftWithTitle:(NSString *)title type:(NSInteger)type {
    [self removeViewWithTag:10000];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 10000;
    
    if (type==0) {
        btn.frame = (CGRect){5,20+(44-40)/2,50,40};
        
        [btn setImage:[Utility getImgWithImageName:[NSString stringWithFormat:@"%@@2x",title]] forState:UIControlStateNormal];
        [btn setImage:[Utility getImgWithImageName:[NSString stringWithFormat:@"%@_highlighted@2x",title]] forState:UIControlStateHighlighted];
        
    }else if (type==1) {
        btn.frame = (CGRect){5,20+(44-40)/2,60,40};
        
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [btn setTitle:title forState:UIControlStateNormal];
        
    }else if (type==2) {
        btn.frame = (CGRect){5,20+(44-40)/2,40,40};
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = true;
        
        NSString *urlString = [title documentFullPath];
        [btn sd_setImageWithURL:[NSURL URLWithString:urlString] forState:UIControlStateNormal];
        [btn sd_setImageWithURL:[NSURL URLWithString:urlString] forState:UIControlStateHighlighted];
    }
    btn.exclusiveTouch = true;
    [btn addTarget:self action:@selector(tapLeft:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    btn = nil;
}

///设置右侧按钮 0=图片  1=文字  2=网络图片
-(void)setRightWithTitle:(NSString *)title type:(NSInteger)type{
    [self removeViewWithTag:20000];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 20000;
    
    if (type==0) {
        btn.frame = (CGRect){SCREEN_WIDTH-55,20+(44-40)/2,50,40};
        
        [btn setImage:[Utility getImgWithImageName:[NSString stringWithFormat:@"%@@2x",title]] forState:UIControlStateNormal];
        [btn setImage:[Utility getImgWithImageName:[NSString stringWithFormat:@"%@_highlighted@2x",title]] forState:UIControlStateHighlighted];
    }else if (type==1) {
        
        if (title.length>5) {
            btn.frame = (CGRect){SCREEN_WIDTH-95,20+(44-40)/2,90,40};
        }else {
            btn.frame = (CGRect){SCREEN_WIDTH-65,20+(44-40)/2,60,40};
        }
        
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [btn setTitle:title forState:UIControlStateNormal];
    }else if (type==2) {
        btn.frame = (CGRect){SCREEN_WIDTH-40-10,20+(44-40)/2,40,40};
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = true;
        
        NSString *urlString = [title documentFullPath];
        [btn sd_setImageWithURL:[NSURL URLWithString:urlString] forState:UIControlStateNormal];
        [btn sd_setImageWithURL:[NSURL URLWithString:urlString] forState:UIControlStateHighlighted];
    }
    btn.exclusiveTouch = true;
    [btn addTarget:self action:@selector(tapRight:) forControlEvents:UIControlEventTouchUpInside];
    btn.enabled = self.rightEnable;
    [self addSubview:btn];
    
    btn = nil;
}

///设置标题 0=图片  1=文字  2=网络图片 3=logo
-(void)setMiddleWithWithTitle:(NSString *)title type:(NSInteger)type {
    [self removeViewWithTag:30000];
    [self removeViewWithTag:30001];
    
    if (type==0) {
        UIImage *image = [Utility getImgWithImageName:[NSString stringWithFormat:@"%@@2x",title]];

        UIImageView *img = [[UIImageView alloc]initWithFrame:(CGRect){(SCREEN_WIDTH-image.size.width)/2,20+(44-image.size.height)/2,image.size.width,image.size.height}];
        img.image = image;
        img.tag = 30000;
        [self addSubview:img];
        img = nil;
    }else if (type==1) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectZero];
        lab.text = title;
        lab.textColor = [UIColor whiteColor];
        lab.tag = 20001;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:18];
        [lab sizeToFit];
        lab.frame = (CGRect){(SCREEN_WIDTH-lab.szWidth)/2,20+(44-lab.szHeight)/2,lab.szWidth,lab.szHeight};
        
        [self addSubview:lab];
        lab = nil;
    }else if (type==3) {
        UIImage *logoImg = [Utility getImgWithImageName:@"logoprojection@2x"];
        UIImageView *logoImgView = [[UIImageView alloc]initWithFrame:(CGRect){(SCREEN_WIDTH-logoImg.size.width)/2,64-logoImg.size.height,logoImg.size.width,logoImg.size.height}];
        logoImgView.image = logoImg;
        logoImgView.tag = 30001;
        [self addSubview:logoImgView];
        logoImgView = nil;
        
        UIImage *image = [Utility getImgWithImageName:[NSString stringWithFormat:@"%@@2x",title]];
        
        UIImageView *img = [[UIImageView alloc]initWithFrame:(CGRect){(SCREEN_WIDTH-image.size.width)/2,20+(44-image.size.height)/2,image.size.width,image.size.height}];
        img.image = image;
        img.tag = 30000;
        [self addSubview:img];
        img = nil;
    }
}


-(void)setIsReding:(BOOL)isReding {
    _isReding = isReding;
    
    if (isReding) {
        [self addRedPoint];
    }else {
        [self removeRedPoint];
    }
}

-(void)setRightEnable:(BOOL)rightEnable {
    _rightEnable = rightEnable;
    
    UIButton *btn = (UIButton *)[self viewWithTag:20000];
    btn.enabled = rightEnable;
}

#pragma mark - action

-(void)tapLeft:(id)sender {
    if (self.navDelegate && [self.navDelegate respondsToSelector:@selector(leftBtnClickByNavBarView:)]) {
        [self.navDelegate leftBtnClickByNavBarView:self];
    }
}

-(void)tapRight:(id)sender {
    if (self.navDelegate && [self.navDelegate respondsToSelector:@selector(rightBtnClickByNavBarView:)]) {
        [self.navDelegate rightBtnClickByNavBarView:self];
    }
}

-(UIImageView *)backImageView
{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] initWithFrame:self.frame];
        
        UIImage *backImage = [UIImage imageNamed:@"navBar"];
        backImage = [backImage resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1) resizingMode:UIImageResizingModeStretch];
        //        self.backgroundColor = [UIColor colorWithPatternImage:backImage];
        _backImageView.contentMode = UIViewContentModeScaleAspectFill;
        _backImageView.image = backImage;
    }
    return _backImageView;
}

-(void)isShowBackImageView:(BOOL)isShow
{
    _backImageView.hidden = !isShow;
}

@end
