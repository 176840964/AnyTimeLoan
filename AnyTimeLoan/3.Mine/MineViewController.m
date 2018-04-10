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
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArr = @[@[@"贷款记录"], @[@"个人资料", @"消息", @"帮助中心", @"设置"], @[@"在线客服"]];
    
    MineHeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:@"MineHeaderView" owner:self options:nil].firstObject;
    headerView.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 188);
    self.tableView.tableHeaderView = headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showMineDetail"]) {
        NSString *titleStr = [[self.dataArr objectAtIndex:self.selectedIndexPath.section] objectAtIndex:self.selectedIndexPath.row];
        UIViewController *vc = segue.destinationViewController;
        vc.title = titleStr;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = [self.dataArr objectAtIndex:section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCell"];
    NSString *titleStr = [[self.dataArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = titleStr;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedIndexPath = indexPath;
    [self performSegueWithIdentifier:@"showMineDetail" sender:self];
}

@end
