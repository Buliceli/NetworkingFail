//
//  MyLoadingView.m
//  NewYMOCProject
//
//  Created by test on 15/11/10.
//  Copyright © 2015年 yimi. All rights reserved.
//

#import "MyLoadingView.h"
#import "MONActivityIndicatorView.h"
#import "UIView+XMGExtension.h"

#define RGBCOLOR(r, g, b)              \
[UIColor colorWithRed:(r) / 255.0f \
green:(g) / 255.0f \
blue:(b) / 255.0f \
alpha:1]
#define RGBACOLOR(r, g, b, a)          \
[UIColor colorWithRed:(r) / 255.0f \
green:(g) / 255.0f \
blue:(b) / 255.0f \
alpha:(a)]
#define NavigationBarColor \
[UIColor colorWithRed:32 / 255.0 green:203 / 255.0 blue:128 / 255.0 alpha:1]
#define DefaultBackGroundColor \
[UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1]
#define DefaultGrayTextColor \
[UIColor colorWithRed:133 / 255.0 green:133 / 255.0 blue:133 / 255.0 alpha:1]
#define DefaultLightGrayTextColor \
[UIColor colorWithRed:200 / 255.0 green:200 / 255.0 blue:200 / 255.0 alpha:1]
#define DefaultBlueTextColor \
[UIColor colorWithRed:0 / 255.0 green:186 / 255.0 blue:255 / 255.0 alpha:1]
#define DefaultUnTouchButtonColor \
[UIColor colorWithRed:152 / 255.0 green:227 / 255.0 blue:194 / 255.0 alpha:1]
#define FONT(size) [UIFont systemFontOfSize:size]
#define BOLDFONT(size) [UIFont boldSystemFontOfSize:size]

#pragma mark 字符
//提示
#define HintWithNetError @"您的网络不太好，加载失败了！"
#define HintWithTimeOut @"您的网络不太好，请求超时了！"
#define HintWithNoData @"访问的此页面无数据哦！"

static CGFloat MyLoadingViewHeight = 200.0;
static CGFloat MyLoadingViewWidth = 200.0;

@interface MyLoadingView () <MONActivityIndicatorViewDelegate>
{
    MyLoadViewReloadAction _reloadAction;
}
@property (nonatomic,strong) MONActivityIndicatorView *indicatorView;

@property (nonatomic,assign) NSLayoutConstraint *loadedImageCenterYConstraint;
@end

@implementation MyLoadingView

#pragma mark loadLabel
-(UILabel *)loadedLabel {
    if (!_loadedLabel) {
        _loadedLabel = [[UILabel alloc]init];
        _loadedLabel.textColor = DefaultGrayTextColor;
        _loadedLabel.textAlignment = NSTextAlignmentCenter;
        _loadedLabel.font = FONT(13);
        _loadedLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _loadedLabel;
}

#pragma mark loadedImageView
-(UIImageView *)loadedImageView {
    if (!_loadedImageView) {
        _loadedImageView = [[UIImageView alloc]init];
        _loadedImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _loadedImageView;
}

#pragma mark reloadBtn
-(UIButton *)reloadBtn {
    if (!_reloadBtn) {
       _reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _reloadBtn.titleLabel.font = FONT(13);
        [_reloadBtn setTitle:@"点击重新加载" forState:UIControlStateNormal];
        [_reloadBtn setTitleColor:DefaultGrayTextColor
                        forState:UIControlStateNormal];
        [_reloadBtn addTarget:self
                      action:@selector(reloadBtnAction)
            forControlEvents:UIControlEventTouchUpInside];
        _reloadBtn.translatesAutoresizingMaskIntoConstraints = NO;
    
    }
    return _reloadBtn;
}

#pragma mark indicatorView
-(MONActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[MONActivityIndicatorView alloc] init];
        _indicatorView.delegate = self;
        _indicatorView.numberOfCircles = 4;
        _indicatorView.radius = 5;
        _indicatorView.duration = 0.8;
        _indicatorView.internalSpacing = 5;
        _indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _indicatorView;
}

-(void)setTopInsert:(CGFloat)topInsert {
    self.top = self.top+topInsert;
}
#pragma mark 初始化方法
-(instancetype)initWithLoadingStatus:(LoadingStatus)loadingStatus View:(UIView *)superView {
    //self = [super initWithFrame:CGRectMake((superView.width-MyLoadingViewWidth)/2.0, (superView.height-MyLoadingViewWidth)/2.0, MyLoadingViewWidth, MyLoadingViewHeight)];
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    if (self) {
        if (loadingStatus==LoadingStatusOnLoading) {
            [self addSubview:self.indicatorView];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:self.indicatorView
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1.0f
                                                              constant:0.0f]];
            
            [self addConstraint:[NSLayoutConstraint constraintWithItem:self.indicatorView
                                                             attribute:NSLayoutAttributeCenterY
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self
                                                             attribute:NSLayoutAttributeCenterY
                                                            multiplier:1.0f
                                                              constant:0.0f]];
        }
        else {
            
            [self addSubview:self.loadedImageView];
            [self addSubview:self.loadedLabel];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:self.loadedImageView
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1.0f
                                                              constant:0.0f]];
            self.loadedImageCenterYConstraint = [NSLayoutConstraint constraintWithItem:self.loadedImageView
                                                                             attribute:NSLayoutAttributeCenterY
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self
                                                                             attribute:NSLayoutAttributeCenterY
                                                                            multiplier:1.0f
                                                                              constant:-20.0];
            [self addConstraint:self.loadedImageCenterYConstraint];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[loadedImageView]-10-[loadedLabel(20)]" options:0 metrics:nil views:@{@"loadedImageView":self.loadedImageView,@"loadedLabel":self.loadedLabel}]];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[loadedLabel]-|" options:0 metrics:nil views:@{@"loadedLabel":self.loadedLabel}]];

            if (loadingStatus==LoadingStatusNoData) {
                
                 self.loadedImageView.image = [UIImage imageNamed:@"load_nodata"];
                self.loadedLabel.text = HintWithNoData;
            }
            else {
                self.loadedImageView.image = [UIImage imageNamed:@"load_fail"];
                self.loadedLabel.text = HintWithNetError;
                [self addSubview:self.reloadBtn];
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[loadedLabel]-10-[reloadBtn(20)]" options:0 metrics:nil views:@{@"loadedLabel":self.loadedLabel,@"reloadBtn":self.reloadBtn}]];
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[reloadBtn]-|" options:0 metrics:nil views:@{@"reloadBtn":self.reloadBtn}]];
                self.loadedImageCenterYConstraint.constant = self.loadedImageCenterYConstraint.constant-20.0;
            }
        }
        
    }
    return self;
}

+(instancetype)showFromView:(UIView *)view WithLoadingStatus:(LoadingStatus)loadingStatus {
    MyLoadingView *loadView = [[self alloc] initWithLoadingStatus:loadingStatus View:view];
    //loadView.backgroundColor = [UIColor orangeColor];
    loadView.userInteractionEnabled = NO;
    if (loadView->_indicatorView) {
        [loadView->_indicatorView startAnimating];
    }
    [UIView animateWithDuration:0.3 animations:^{
        [view addSubview:loadView];
    }];
    return loadView;
}

#pragma mark 带重载按钮的显示方法
+(instancetype)showFromView:(UIView *)view HandleReloadAction:(MyLoadViewReloadAction)reloadAction {
    
    
    MyLoadingView *loadView = [[self alloc] initWithLoadingStatus:LoadingStatusNetError View:view];
    loadView -> _reloadAction = reloadAction;
    if (loadView->_indicatorView) {
        [loadView->_indicatorView startAnimating];
    }
    [UIView animateWithDuration:0.3 animations:^{
        [view addSubview:loadView];
    }];
    return loadView;
}

#pragma mark 隐藏方法
+(void)hiddenForView:(UIView *)view {
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:[MyLoadingView class]]) {
            [UIView animateWithDuration:0.3 animations:^{
                subview.alpha = 0.0;
            } completion:^(BOOL finished) {
                [subview removeFromSuperview];
            }];
        }
    }
}

#pragma mark 重载按钮方法
-(void)reloadBtnAction {
    if (_reloadAction) {
        _reloadAction ();
    }
}

#pragma mark MONActivityIndicatorViewDelegate
-(UIColor *)activityIndicatorView:(MONActivityIndicatorView *)activityIndicatorView circleBackgroundColorAtIndex:(NSUInteger)index  {
    if (index==0) {
        return RGBCOLOR(250, 120, 0);
    }
    else if (index==1) {
        return RGBCOLOR(0, 174, 255);
    }
    else if (index==2) {
        return RGBCOLOR(255, 0, 120);
    }
    else if (index==3) {
        return RGBCOLOR(60, 255, 0);
    }
    return RGBCOLOR(0, 0, 0);
}

@end
