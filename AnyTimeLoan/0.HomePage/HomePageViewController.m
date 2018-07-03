//
//  HomePageViewController.m
//  AnyTimeLoan
//
//  Created by 张晓龙 on 2018/4/10.
//  Copyright © 2018年 张晓龙. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomeCollectionViewCell.h"
#import "HomeCollectionReusableView.h"

@interface HomePageViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) CommonHeaderView *headerView;
@property (strong, nonatomic) NSMutableArray *dataArr;
@property (strong, nonatomic) NSMutableArray *bannerArr;
@property (assign, nonatomic) NSInteger selectedIndex;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (assign, nonatomic) NSInteger pageIndex;
@property (assign, nonatomic) BOOL isBannerAction;
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    __weak typeof(self) weakSelf = self;
    self.pageIndex = 1;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeCollectionReusableView"];
    
    self.headerView = [[NSBundle mainBundle] loadNibNamed:@"CommonHeaderView" owner:self options:nil].firstObject;
    self.headerView.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 168);
    self.headerView.tapBannerHandler = ^(NSInteger index) {
        if ([UserInfoManager shareInstance].isLogin) {
            weakSelf.selectedIndex = index;
            weakSelf.isBannerAction = YES;
            [weakSelf performSegueWithIdentifier:@"showCommonWebViewController" sender:weakSelf];
        } else {
            [weakSelf performSegueWithIdentifier:@"presentLoginViewController" sender:weakSelf];
        }
    };
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = [UIColor lightGrayColor];
    [self.refreshControl addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:self.refreshControl];
    
    self.tapNetErrorBtnHandler = ^{
        [weakSelf requestNetwork];
        [weakSelf requestBannerNetwork];
    };
    
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

#pragma mark - action
- (void)refreshStateChange:(UIRefreshControl*)refreshCtrl {
    self.pageIndex = 1;
    [self requestNetwork];
    [self requestBannerNetwork];
}

#pragma mark - network
- (void)requestNetwork {
    [[AFHTTPSessionManager manager] POST:CommonUrl parameters:@{@"category_id":@"1", @"page":@(self.pageIndex)} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dataDic = responseObject;
        NSNumber *code = [dataDic objectForKey:@"code"];
        NSString *msg = [dataDic objectForKey:@"msg"];
        if (code.integerValue == 1) {
            self.netErrorBtn.hidden = YES;
            self.collectionView.hidden = NO;
            
            if (1 == self.pageIndex) {
                [self.dataArr removeAllObjects];
            }
            
            NSArray *list = [[dataDic objectForKey:@"data"] objectForKey:@"list"];
            for (NSDictionary *dic in list) {
                CommonModel * model = [CommonModel createCommonModelByDic:dic];
                [self.dataArr addObject:model];
            }
            [self.collectionView reloadData];
        } else {
            NSLog(@"%@", msg);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.collectionView.hidden = YES;
        self.netErrorBtn.hidden = NO;
    }];
}

- (void)requestBannerNetwork {
    [self.bannerArr removeAllObjects];
    
    NSString *path = [NSString stringWithFormat:@"%@%@", BannerUrl, @"2"];
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

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CommonModel *model = [self.dataArr objectAtIndex:indexPath.row];
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionViewCell" forIndexPath:indexPath];
    cell.lable.text = model.post_title;
    [cell.imgView setImageWithURL:[NSURL URLWithString:model.thumbnail]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    HomeCollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HomeCollectionReusableView" forIndexPath:indexPath];
    [reusableView addSubview:self.headerView];
    return reusableView;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndex = indexPath.row;
    if ([UserInfoManager shareInstance].isLogin) {
        self.isBannerAction = NO;
        [self performSegueWithIdentifier:@"showCommonWebViewController" sender:self];
    } else {
        [self performSegueWithIdentifier:@"presentLoginViewController" sender:self];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((CGRectGetWidth([UIScreen mainScreen].bounds) - 3) / 4.0, 110);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 168);
}

@end
