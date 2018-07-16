//
//  ViewController.m
//  测试单例
//
//  Created by 李洞洞 on 10/7/18.
//  Copyright © 2018年 Minte. All rights reserved.
//

#import "ViewController.h"
#import "BController.h"
#import "Persion.h"
#import "BaseClient.h"
#import "MyLoadingView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * btn = ({
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
        btn.backgroundColor = [UIColor cyanColor];
        [btn addTarget:self action:@selector(netWorking) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn;
    });
    
}
- (void)netWorking
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    [params setValue:@"1458873145000" forKey:@"a_t"];
    [params setValue:@"56f3b5f6ac4a6" forKey:@"token"];
    [params setValue:@"3e5ba2f1c1a62f627c59b59483a5da7cb5ea1429" forKey:@"sign"];
    NSString * url = @"http://000www.roadqu.com/api/mobile/qunawan/tour/seasonalfunplacelist";
    
    [MyLoadingView showFromView:[UIApplication sharedApplication].keyWindow WithLoadingStatus:LoadingStatusOnLoading];

    [BaseClient httpType:GET andURL:url andParam:params andSuccessBlock:^(NSURL *URL, id data) {
        
        NSLog(@"%@",data);
        [MyLoadingView hiddenForView:[UIApplication sharedApplication].keyWindow];
        
    } andFailBlock:^(NSURL *URL, NSError *error) {
        NSLog(@"%@",error);
        
        [MyLoadingView hiddenForView:[UIApplication sharedApplication].keyWindow];
        
        __weak typeof(self)blockVc = self;
        [MyLoadingView showFromView:[UIApplication sharedApplication].keyWindow HandleReloadAction:^{
            [blockVc netWorking];
        }];
    }];
    
}

#if 0
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__func__);
}
#endif
#if 0

CyanView * containerView = [[CyanView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
containerView.backgroundColor = [UIColor cyanColor];
[self.view addSubview:containerView];

OrigalView * view = [[OrigalView alloc]initWithFrame:CGRectMake(50, 50, 100, 100)];
view.backgroundColor = [UIColor orangeColor];
[containerView addSubview:view];

containerView.view = view;
[self.view addSubview:containerView];

#endif




















//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        Persion * p = [Persion sharePersion];
//        if (p.delegate && [p.delegate respondsToSelector:@selector(quityRun)]) {
//            [p.delegate quityRun];
//        }
//        
//    });
//    BController * bBc = [[BController alloc]init];
//    [self.navigationController pushViewController:bBc animated:YES];
//

//}

@end
