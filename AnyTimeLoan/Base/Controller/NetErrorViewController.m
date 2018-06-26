//
//  NetErrorViewController.m
//  AnyTimeLoan
//
//  Created by 张晓龙 on 2018/6/26.
//  Copyright © 2018年 张晓龙. All rights reserved.
//

#import "NetErrorViewController.h"

@interface NetErrorViewController ()

@end

@implementation NetErrorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)netErrorBtn {
    if (nil == _netErrorBtn) {
        _netErrorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _netErrorBtn.frame = CGRectMake(0, 0, 100, 30);
        _netErrorBtn.centerX = self.view.center.x;
        _netErrorBtn.centerY = self.view.center.y;
        _netErrorBtn.layer.cornerRadius = 4.0;
        _netErrorBtn.layer.borderWidth = 1.0;
        _netErrorBtn.layer.borderColor = [UIColor blackColor].CGColor;
        _netErrorBtn.hidden = YES;
        [_netErrorBtn setTitle:@"重新加载" forState:UIControlStateNormal];
        [_netErrorBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_netErrorBtn addTarget:self action:@selector(onTapNetErrorBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.netErrorBtn];
    }
    
    return _netErrorBtn;
}

#pragma mark - 
- (void)onTapNetErrorBtn:(UIButton *)btn {
    if (self.tapNetErrorBtnHandler) {
        self.tapNetErrorBtnHandler();
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
