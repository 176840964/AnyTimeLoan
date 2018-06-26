//
//  AdultViewController.m
//  AnyTimeLoan
//
//  Created by 张晓龙 on 2018/4/10.
//  Copyright © 2018年 张晓龙. All rights reserved.
//

#import "AdultViewController.h"

@interface AdultViewController ()
@property (strong, nonatomic) CommonHeaderView *headerView;
@property (strong, nonatomic) NSMutableArray *dataArr;
@property (assign, nonatomic) NSInteger selectedIndex;
@end

@implementation AdultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 168)];
    self.headerView = [[NSBundle mainBundle] loadNibNamed:@"CommonHeaderView" owner:self options:nil].firstObject;
    self.headerView.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 168);
    [view addSubview:self.headerView];
    self.tableView.tableHeaderView = view;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CommonTableViewCell" bundle:nil] forCellReuseIdentifier:@"CommonTableViewCell"];
    self.tableView.rowHeight = 150;
    
    __weak typeof(self) weakSelf = self;
    self.tapNetErrorBtnHandler = ^{
        [weakSelf requestNetwork];
    };
    
    self.refreshCtrlHandler = ^{
        weakSelf.pageIndex = 1;
        [weakSelf requestNetwork];
    };
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageIndex ++;
        [weakSelf requestNetwork];
    }];
    
    self.dataArr = [NSMutableArray new];
    [self requestNetwork];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestNetwork {
    [[AFHTTPSessionManager manager] POST:CommonUrl parameters:@{@"category_id":@"3", @"page":@(self.pageIndex)} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.refreshControl endRefreshing];
        
        NSDictionary *dataDic = responseObject;
        NSNumber *code = [dataDic objectForKey:@"code"];
        NSString *msg = [dataDic objectForKey:@"msg"];
        if (code.integerValue == 1) {
            self.tableView.hidden = NO;
            self.netErrorBtn.hidden = YES;
            
            if (1 == self.pageIndex) {
                [self.dataArr removeAllObjects];
                [self.tableView.mj_footer endRefreshing];
            }
            
            NSArray *list = [[dataDic objectForKey:@"data"] objectForKey:@"list"];
            if (0 == list.count) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            } else {
                for (NSDictionary *dic in list) {
                    CommonModel * model = [CommonModel createCommonModelByDic:dic];
                    [self.dataArr addObject:model];
                }
                [self.tableView reloadData];
                [self.tableView.mj_footer endRefreshing];
            }
        } else {
            NSLog(@"%@", msg);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.tableView.hidden = YES;
        self.netErrorBtn.hidden = NO;
    }];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showCommonWebViewController"]) {
        CommonModel *model = [self.dataArr objectAtIndex:self.selectedIndex];
        CommonWebViewController *vc = segue.destinationViewController;
        vc.title = model.post_title;
        vc.urlStr = model.post_source;
    } else if ([segue.identifier isEqualToString:@"presentLoginViewController"]) {
        BaseNavigationController *naviVC = segue.destinationViewController;
        LoginViewController *loginVC = naviVC.viewControllers.firstObject;
        loginVC.tapLoginBtnHandler = ^{
            [self performSegueWithIdentifier:@"showCommonWebViewController" sender:self];
        };
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonModel *model = [self.dataArr objectAtIndex:indexPath.row];
    CommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonTableViewCell"];
    [cell.iconView setImageWithURL:[NSURL URLWithString:model.thumbnail]];
    cell.titleLab.text = model.post_title;
    cell.subTitleLab.text = model.post_keywords;
    
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:model.add_apply_age];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:21] range:NSMakeRange(0, model.add_apply_age.length - 2)];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:NSMakeRange(model.add_apply_age.length - 2, 2)];
    cell.ageRangeLab.attributedText = attrStr;
    
    cell.activityLab.text = model.post_excerpt;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedIndex = indexPath.row;
    if ([UserInfoManager shareInstance].isLogin) {
        [self performSegueWithIdentifier:@"showCommonWebViewController" sender:self];
    } else {
        [self performSegueWithIdentifier:@"presentLoginViewController" sender:self];
    }
}

@end
