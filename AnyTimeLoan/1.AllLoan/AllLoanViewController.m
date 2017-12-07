//
//  AllLoanViewController.m
//  AnyTimeLoan
//
//  Created by 张晓龙 on 2017/12/4.
//  Copyright © 2017年 张晓龙. All rights reserved.
//

#import "AllLoanViewController.h"
#import "AllLoanHeaderView.h"

@interface AllLoanViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation AllLoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AllLoanHeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:@"AllLoanHeaderView" owner:self options:nil].firstObject;
    headerView.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 40);
    self.tableView.tableHeaderView = headerView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
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

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"allLoanCell"];
    return cell;
}

@end
