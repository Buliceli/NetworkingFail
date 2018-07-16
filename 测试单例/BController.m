//
//  BController.m
//  测试单例
//
//  Created by 李洞洞 on 10/7/18.
//  Copyright © 2018年 Minte. All rights reserved.
//

#import "BController.h"
#import "Persion.h"
@interface BController ()<PersionProtocol>

@end

@implementation BController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor purpleColor];
    
#if 0
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        Persion * p = [[Persion alloc]init];
        [p run];
    });
#endif
    
    Persion * p = [Persion sharePersion];
    p.delegate = self;
    
}
- (void)quityRun
{
    NSLog(@"单例的方法是否执行在此!");
}
- (void)dealloc
{
    NSLog(@"%s",__func__);
}



@end
