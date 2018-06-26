//
//  BaseViewController.m
//  AnyTimeLoan
//
//  Created by 张晓龙 on 2017/12/4.
//  Copyright © 2017年 张晓龙. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.pageIndex = 1;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIRefreshControl *)refreshControl {
    if (nil == _refreshControl) {
        _refreshControl = [[UIRefreshControl alloc] init];
        _refreshControl.tintColor = [UIColor lightGrayColor];
        [_refreshControl addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
        [self.tableView addSubview:_refreshControl];
    }
    
    return _refreshControl;
}

#pragma mark -
- (void)refreshStateChange:(UIRefreshControl*)refreshCtrl {
    if (self.refreshCtrlHandler) {
        self.refreshCtrlHandler();
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
