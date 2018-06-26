//
//  NetErrorViewController.h
//  AnyTimeLoan
//
//  Created by 张晓龙 on 2018/6/26.
//  Copyright © 2018年 张晓龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NetErrorViewController : UIViewController

@property (strong, nonatomic) UIButton *netErrorBtn;
@property (copy, nonatomic) dispatch_block_t tapNetErrorBtnHandler;

@end
