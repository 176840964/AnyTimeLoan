//
//  MineViewController.m
//  AnyTimeLoan
//
//  Created by 张晓龙 on 2017/12/4.
//  Copyright © 2017年 张晓龙. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeaderView.h"

@interface MineViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray *dataArr;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArr = @[@"个人资料", @"关于我们"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCell"];
    
    NSString *titleStr = [self.dataArr objectAtIndex:indexPath.row];
    cell.textLabel.text = titleStr;
    cell.textLabel.textColor = [UIColor colorWithRed:125 / 255.0 green:128 / 255.0 blue:129 / 255.0 alpha:1.0];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (0 == indexPath.row) {
        [self performSegueWithIdentifier:@"showMineInfoViewController" sender:self];
    } else {
        [self performSegueWithIdentifier:@"showContactUsViewController" sender:self];
    }
}

@end
