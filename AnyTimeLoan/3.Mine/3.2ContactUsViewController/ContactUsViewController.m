//
//  ContactUsViewController.m
//  AnyTimeLoan
//
//  Created by 张晓龙 on 2018/5/21.
//  Copyright © 2018年 张晓龙. All rights reserved.
//

#import "ContactUsViewController.h"
#import "MineDetailCell.h"

@interface ContactUsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSArray *dataArr;
@end

@implementation ContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"关于我们";
    self.dataArr = @[@[@"业务合作微信", @"zhangrx5566"], @[@"邮箱", @"133****2324"]];
    
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
    NSArray *arr = [self.dataArr objectAtIndex:indexPath.row];
    cell.mainLab.text = [arr objectAtIndex:0];
    cell.subLab.text = [arr objectAtIndex:1];
    return cell;
}

#pragma mark - UITableViewDelegate

@end
