//
//  UIViewController+NetError.h
//  AnyTimeLoan
//
//  Created by 张晓龙 on 2018/6/26.
//  Copyright © 2018年 张晓龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NetError)
@property (strong, nonatomic) UIButton *netErrorBtn;
- (void)showNetErrorBtn;
- (void)hiddenNetErrorBtn;

@end
