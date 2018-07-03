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
@property (strong, nonatomic) NSMutableArray *bannerArr;
@property (assign, nonatomic) NSInteger selectedIndex;
@property (assign, nonatomic) BOOL isBannerAction;
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
    self.headerView.tapBannerHandler = ^(NSInteger index) {
        if ([UserInfoManager shareInstance].isLogin) {
            weakSelf.selectedIndex = index;
            weakSelf.isBannerAction = YES;
            [weakSelf performSegueWithIdentifier:@"showCommonWebViewController" sender:weakSelf];
        } else {
            [weakSelf performSegueWithIdentifier:@"presentLoginViewController" sender:weakSelf];
        }
    };
    
    self.tapNetErrorBtnHandler = ^{
        [weakSelf requestNetwork];
        [weakSelf requestBannerNetwork];
    };
    
    self.refreshCtrlHandler = ^{
        weakSelf.pageIndex = 1;
        [weakSelf requestNetwork];
        [weakSelf requestBannerNetwork];
    };
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageIndex ++;
        [weakSelf requestNetwork];
    }];
    
    self.dataArr = [NSMutableArray new];
    [self requestNetwork];
    
    self.bannerArr = [NSMutableArray new];
    [self requestBannerNetwork];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.headerView startScrollBanner];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.headerView stopScrollBanner];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - network
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

- (void)requestBannerNetwork {
    [self.bannerArr removeAllObjects];
    
    NSString *path = [NSString stringWithFormat:@"%@%@", BannerUrl, @"4"];
    [[AFHTTPSessionManager manager] GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *code = [dic objectForKey:@"code"];
        if (1 == code.integerValue) {
            NSArray *data = [dic objectForKey:@"data"];
            if (1 <= data.count) {
                NSArray *items = [data.firstObject objectForKey:@"items"];
                for (NSDictionary *infoDic in items) {
                    BannerModel *model = [BannerModel createBannerModelByDic:infoDic];
                    [self.bannerArr addObject:model];
                }
                
                [self.headerView layoutCommonSubviewsByBannerModelArr:self.bannerArr];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showCommonWebViewController"]) {
        CommonWebViewController *vc = segue.destinationViewController;
        if (self.isBannerAction) {
            BannerModel *model = [self.bannerArr objectAtIndex:self.selectedIndex];
            vc.title = model.title;
            vc.urlStr = model.url;
        } else {
            CommonModel *model = [self.dataArr objectAtIndex:self.selectedIndex];
            vc.title = model.post_title;
            vc.urlStr = model.post_source;
        }
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
