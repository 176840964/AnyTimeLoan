//
//  MineInfoViewController.m
//  AnyTimeLoan
//
//  Created by 张晓龙 on 2018/5/21.
//  Copyright © 2018年 张晓龙. All rights reserved.
//

#import "MineInfoViewController.h"
#import "MineDetailCell.h"

@interface MineInfoViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray *dataArr;
@end

@implementation MineInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人资料";
    self.dataArr = @[@"昵称", @"手机号"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MineDetailCell" bundle:nil] forCellReuseIdentifier:@"MineDetailCell"];
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
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineDetailCell"];
    
    NSString *titleStr = [self.dataArr objectAtIndex:indexPath.row];
    cell.mainLab.text = titleStr;
    
    NSString *userMoblieStr = [UserInfoManager shareInstance].userMobile;
    cell.subLab.text = userMoblieStr;
    
    return cell;
}

#pragma mark - UITableViewDelegate

@end
