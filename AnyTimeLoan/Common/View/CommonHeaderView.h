//
//  CommonHeaderView.h
//  AnyTimeLoan
//
//  Created by 张晓龙 on 2018/4/10.
//  Copyright © 2018年 张晓龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonHeaderView : UIView

@property (copy, nonatomic) void (^tapBannerHandler)(NSInteger);
- (void)layoutCommonSubviewsByBannerModelArr:(NSArray *)arr;

@end
