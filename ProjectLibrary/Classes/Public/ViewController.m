//
//  ViewController.m
//  SchoolSociety
//
//  Created by xuyong on 16/6/15.
//  Copyright © 2016年 xuyong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NavBarViewDelegate>

@end

@implementation ViewController

-(UIImageView *)defaultView {
    if (!_defaultView) {
        _defaultView = [[UIImageView alloc]initWithFrame:(CGRect){(SCREEN_WIDTH-250)/2.0,0,250,250}];
        _defaultView.image = [UIImage imageNamed:@"loading"];
    }
    return _defaultView;
}

-(UILabel *)infoLab {
    if (!_infoLab) {
        _infoLab = [[UILabel alloc]initWithFrame:(CGRect){0,0,SCREEN_WIDTH,20}];
        _infoLab.textColor = [UIColor colorWithHexString:@"276CFE"];
        _infoLab.textAlignment = NSTextAlignmentCenter;
        _infoLab.font = [UIFont systemFontOfSize:16];
    }
    return _infoLab;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"DFE3F3"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter/setter

-(SS_NavBarView *)navBarView {
    if (!_navBarView) {
        _navBarView = [[SS_NavBarView alloc]initWithFrame:(CGRect){0,0,SCREEN_WIDTH, 64}];
        _navBarView.navDelegate = self;
        [self.view addSubview:_navBarView];
    }
    return _navBarView;
}

#pragma mark - 导航栏代理

-(void)leftBtnClickByNavBarView:(SS_NavBarView *)navView {
    [self.navigationController popViewControllerAnimated:true];
}

-(void)rightBtnClickByNavBarView:(SS_NavBarView *)navView {
    
}


-(void)showDefultView:(CGFloat)top text:(NSString *)info view:(UIView *)view{
    
    CGRect frame = self.defaultView.frame;
    frame.origin.y = top;
    self.defaultView.frame = frame;
    
    CGRect frame2 = self.infoLab.frame;
    frame2.origin.y = self.defaultView.szBottom +10;
    self.infoLab.frame = frame2;
    self.infoLab.text = info;
    
    [view addSubview:self.defaultView];
    [view addSubview:self.infoLab];
}

-(void)hiddenDefultView {
    [self.defaultView removeFromSuperview];
    self.defaultView = nil;
    
    [self.infoLab removeFromSuperview];
    self.infoLab = nil;

}
@end
