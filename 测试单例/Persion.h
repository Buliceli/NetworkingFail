//
//  Persion.h
//  测试单例
//
//  Created by 李洞洞 on 10/7/18.
//  Copyright © 2018年 Minte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Single.h"

@protocol PersionProtocol <NSObject>
- (void)quityRun;
@end

@interface Persion : NSObject
SingleH(Persion)
- (void)run;
@property(nonatomic,assign)id<PersionProtocol>  delegate;
@end
