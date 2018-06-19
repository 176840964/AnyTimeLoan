//
//  CommonWebViewController.m
//  AnyTimeLoan
//
//  Created by 张晓龙 on 2018/6/19.
//  Copyright © 2018年 张晓龙. All rights reserved.
//

#import "CommonWebViewController.h"

@interface CommonWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation CommonWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.urlStr.length == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
