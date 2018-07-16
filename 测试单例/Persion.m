//
//  Persion.m
//  测试单例
//
//  Created by 李洞洞 on 10/7/18.
//  Copyright © 2018年 Minte. All rights reserved.
//

#import "Persion.h"

@implementation Persion
SingleM(Persion)
- (void)run
{
    NSLog(@"单例方法在执行");
}
@end
