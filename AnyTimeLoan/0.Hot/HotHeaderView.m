//
//  HotHeaderView.m
//  AnyTimeLoan
//
//  Created by zxl on 2017/12/5.
//  Copyright © 2017年 张晓龙. All rights reserved.
//

#import "HotHeaderView.h"

@implementation HotHeaderView

- (void)layoutHotHeaderViewByDic:(NSDictionary *)dic {
    self.iconView1.titleLab.text = @"小额极贷";
    self.iconView2.titleLab.text = @"大额低息";
    self.iconView3.titleLab.text = @"不上征信";
    self.iconView4.titleLab.text = @"不查芝麻分";
    
    self.insideView1.titleLab.text = @"纯信用借贷";
    self.insideView2.titleLab.text = @"低门槛 申请简单";
    self.insideView3.titleLab.text = @"高额利息 快速";
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
