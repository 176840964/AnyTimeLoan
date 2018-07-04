//
//  LoginViewController.m
//  AnyTimeLoan
//
//  Created by 张晓龙 on 2018/6/26.
//  Copyright © 2018年 张晓龙. All rights reserved.
//

#import "LoginViewController.h"

#define CodeUrl @"http://api.app.xuebatuijian.com/api/user/verification_code/send"
#define LoginUrl @"http://api.app.xuebatuijian.com/api/user/public/singupLogin"

@interface LoginViewController ()
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) NSInteger seconde;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_返回"] style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = item;
    
    self.codeBtn.layer.cornerRadius = 4.0;
    self.loginBtn.layer.cornerRadius = 4.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)showAlertWithTitle:(NSString *)title {
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:^{}];
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
    self.codeBtn.enabled = NO;
    if (11 != self.phoneTextField.text.length) {
        [self showAlertWithTitle:@"请检查手机号"];
        self.codeBtn.enabled = YES;
        return;
    }
    
    [[AFHTTPSessionManager manager] GET:CodeUrl parameters:@{@"username": self.phoneTextField.text} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSNumber *code = [responseObject objectForKey:@"code"];
        if (1 == code.integerValue) {
            self.seconde = 60;
            [self.codeBtn setTitle:[NSString stringWithFormat:@"%ld", self.seconde] forState:UIControlStateNormal];
            
            if (nil == self.timer) {
                self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(countdownSeconds) userInfo:nil repeats:YES];
                [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
            } else {
                [self startCountdownSeconds];
            }
        } else {
            self.codeBtn.enabled = YES;
            NSString *msg = [responseObject objectForKey:@"msg"];
            [self showAlertWithTitle:msg];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.codeBtn.enabled = YES;
        [self showAlertWithTitle:@"网络错误"];
    }];
    
}

- (IBAction)onTapLoginBtn:(id)sender {
    self.loginBtn.enabled = NO;
    if (11 != self.phoneTextField.text.length) {
        [self showAlertWithTitle:@"请检查手机号"];
        self.loginBtn.enabled = YES;
        return;
    } else if (0 == self.codeTextField.text.length) {
        [self showAlertWithTitle:@"请输入正确的验证码"];
        self.loginBtn.enabled = YES;
        return;
    }
    
    [[AFHTTPSessionManager manager] GET:LoginUrl parameters:@{@"username": self.phoneTextField.text, @"verification_code": self.codeTextField.text} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSNumber *code = [responseObject objectForKey:@"code"];
        if (1 == code.integerValue) {
            NSString *token = [[responseObject objectForKey:@"data"] objectForKey:@"token"];
            [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"UserToken"];
            [[NSUserDefaults standardUserDefaults] setObject:self.phoneTextField.text forKey:@"Mobile"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [UserInfoManager shareInstance].isLogin = YES;
            [self stopCountdownSeconds];
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                if (self.tapLoginBtnHandler) {
                    self.tapLoginBtnHandler();
                }
            }];
        } else {
            self.loginBtn.enabled = YES;
            NSString *msg = [responseObject objectForKey:@"msg"];
            [self showAlertWithTitle:msg];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.loginBtn.enabled = YES;
        [self showAlertWithTitle:@"网络错误"];
    }];
    
}

#pragma mark - NSTimer
- (void)countdownSeconds {
    self.seconde --;
    if (0 == self.seconde) {
        self.codeBtn.enabled = YES;
        [self.codeBtn setTitle:@"验证码" forState:UIControlStateNormal];
        [self stopCountdownSeconds];
    } else {
        [self.codeBtn setTitle:[NSString stringWithFormat:@"%ld", self.seconde] forState:UIControlStateNormal];
    }
}

- (void)startCountdownSeconds {
    if (self.timer.valid) {
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    }
}

- (void)stopCountdownSeconds {
    if (self.timer.valid) {
        [self.timer setFireDate:[NSDate distantFuture]];
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
