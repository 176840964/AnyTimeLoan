//
//  HotHeaderView.h
//  AnyTimeLoan
//
//  Created by zxl on 2017/12/5.
//  Copyright © 2017年 张晓龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotIconAndTitleView.h"

@interface HotHeaderView : UIView

@property (weak, nonatomic) IBOutlet HotIconAndTitleView *iconView1;
@property (weak, nonatomic) IBOutlet HotIconAndTitleView *iconView2;
@property (weak, nonatomic) IBOutlet HotIconAndTitleView *iconView3;
@property (weak, nonatomic) IBOutlet HotIconAndTitleView *iconView4;

@property (weak, nonatomic) IBOutlet HotIconAndTitleView *insideView1;
@property (weak, nonatomic) IBOutlet HotIconAndTitleView *insideView2;
@property (weak, nonatomic) IBOutlet HotIconAndTitleView *insideView3;

- (void)layoutHotHeaderViewByDic:(NSDictionary *)dic;

@end
