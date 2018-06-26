//
//  LoginViewController.m
//  AnyTimeLoan
//
//  Created by 张晓龙 on 2018/6/26.
//  Copyright © 2018年 张晓龙. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_返回"] style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
- (void)back:(UIBarButtonItem *)item {
    UITabBarController *vc = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    if (3 == vc.selectedIndex) {
        vc.selectedIndex = 0;
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        if (self.tapCanclHandler) {
            self.tapCanclHandler();
        }
    }];
}

- (IBAction)onTapCodeBtn:(id)sender {
    
}

- (IBAction)onTapLoginBtn:(id)sender {
    [UserInfoManager shareInstance].isLogin = YES;
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        if (self.tapLoginBtnHandler) {
            self.tapLoginBtnHandler();
        }
    }];
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
