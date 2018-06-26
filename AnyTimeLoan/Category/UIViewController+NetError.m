//
//  UIViewController+NetError.m
//  AnyTimeLoan
//
//  Created by 张晓龙 on 2018/6/26.
//  Copyright © 2018年 张晓龙. All rights reserved.
//

#import "UIViewController+NetError.h"

@implementation UIViewController (NetError)

- (void)showNetErrorBtn {
    if (nil == self.netErrorBtn) {
        self.netErrorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.netErrorBtn setTitle:@"重新加载" forState:UIControlStateNormal];
        [self.netErrorBtn addTarget:self action:@selector(onTapNetErrorBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.netErrorBtn];
    }
    self.netErrorBtn.hidden = NO;
}

- (void)hiddenNetErrorBtn {
    self.netErrorBtn.hidden = YES;
}

- (void)onTapNetErrorBtn:(UIButton *)btn {
    
}
@end
