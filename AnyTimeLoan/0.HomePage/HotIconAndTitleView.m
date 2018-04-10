//
//  HotIconAndTitleView.m
//  AnyTimeLoan
//
//  Created by zxl on 2017/12/5.
//  Copyright © 2017年 张晓龙. All rights reserved.
//

#import "HotIconAndTitleView.h"

@implementation HotIconAndTitleView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"HotIconAndTitleView" owner:self options:nil];
        [self addSubview:self.view];
        self.view.frame = self.bounds;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
