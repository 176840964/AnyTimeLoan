//
//  CommonHeaderView.m
//  AnyTimeLoan
//
//  Created by 张晓龙 on 2018/4/10.
//  Copyright © 2018年 张晓龙. All rights reserved.
//

#import "CommonHeaderView.h"

@interface CommonHeaderView () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageCtrl;
@property (strong, nonatomic) NSTimer *timer;
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
    [self removeAllBannerViews];
    
    self.pageCtrl.numberOfPages = arr.count;
    
    for (NSInteger index = 0; index < arr.count; index++) {
        BannerModel *model = [arr objectAtIndex:index];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = index;
        btn.frame = CGRectMake(index * self.width, 0, self.width, self.height);
        [btn setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"bannerDefult"]];
        [btn addTarget:self action:@selector(onTapBanner:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btn];
    }
    
    [self.scrollView setContentSize:CGSizeMake(self.width *arr.count, self.height)];
    
    if (1 < arr.count) {
        if (nil == self.timer) {
            self.timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(scrollBanner) userInfo:nil repeats:YES];
            [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        } else {
            [self startScrollBanner];
        }
    }
}

- (void)startScrollBanner {
    if (self.timer.valid) {
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    }
}

- (void)stopScrollBanner {
    if (self.timer.valid) {
        [self.timer setFireDate:[NSDate distantFuture]];
    }
}

#pragma mark -
- (void)removeAllBannerViews {
    for (UIView *view in self.scrollView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
}

#pragma mark - action
- (void)onTapBanner:(UIButton *)btn {
    if (self.tapBannerHandler) {
        self.tapBannerHandler(btn.tag);
    }
}

- (void)scrollBanner {
    NSInteger count = self.pageCtrl.numberOfPages;
    NSInteger index = self.pageCtrl.currentPage;
    if (index + 1 >= count) {
        self.pageCtrl.currentPage = 0;
        [self.scrollView setContentOffset:CGPointZero animated:YES];
    } else {
        self.pageCtrl.currentPage = index + 1;
        [self.scrollView setContentOffset:CGPointMake(self.width * self.pageCtrl.currentPage, 0) animated:YES];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    self.pageCtrl.currentPage = offset.x / self.width;
}

@end
