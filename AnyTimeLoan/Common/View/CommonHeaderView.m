//
//  CommonHeaderView.m
//  AnyTimeLoan
//
//  Created by 张晓龙 on 2018/4/10.
//  Copyright © 2018年 张晓龙. All rights reserved.
//

#import "CommonHeaderView.h"

@interface CommonHeaderView ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageCtrl;
@end

@implementation CommonHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutCommonSubviewsByBannerModelArr:(NSArray *)arr {
    self.pageCtrl.numberOfPages = arr.count;
    
    for (NSInteger index = 0; index < arr.count; index++) {
        BannerModel *model = [arr objectAtIndex:index];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = index;
        btn.frame = CGRectMake(index * self.width, 0, self.width, self.height);
        [btn setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"bannerDefult"]];
        [btn addTarget:self action:@selector(onTapBanner:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btn];
    }
    
    [self.scrollView setContentSize:CGSizeMake(self.width *arr.count, self.height)];
}

- (void)removeAllBannerViews {
    
}

#pragma mark -
- (void)onTapBanner:(UIButton *)btn {
    if (self.tapBannerHandler) {
        self.tapBannerHandler(btn.tag);
    }
}

@end
