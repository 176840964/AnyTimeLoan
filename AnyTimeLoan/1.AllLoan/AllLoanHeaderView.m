//
//  AllLoanHeaderView.m
//  AnyTimeLoan
//
//  Created by zxl on 2017/12/6.
//  Copyright © 2017年 张晓龙. All rights reserved.
//

#import "AllLoanHeaderView.h"
#import "AllLoanCollectionViewCell.h"

#define CollectionViewHeight 27.0

@interface AllLoanHeaderView() <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIImageView *imgView1;
@property (weak, nonatomic) IBOutlet UIImageView *imgView2;
@property (weak, nonatomic) IBOutlet UIImageView *imgView3;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSArray *infoArr;
@property (strong, nonatomic) NSArray *curArr;
@property (assign, nonatomic) NSInteger curSelctedBtnTag;
@end

@implementation AllLoanHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.btn1.tag = 1;
    self.btn2.tag = 2;
    self.btn3.tag = 3;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"AllLoanCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"AllLoanCollectionViewCell"];
    
    self.curArr = [NSArray new];
#warning test data
    NSArray *arr1 = @[@"金额不限", @"1000以下", @"1000-2000", @"2000-5000", @"5000-10000", @"10000以上"];
    NSArray *arr2 = @[@"期限不限", @"14天内", @"14-30天", @"1-3个月", @"3-6个月", @"6-9个月", @"9-12个月", @"12个月以上"];
    NSArray *arr3 = @[@"成功率最高", @"放款速度最快", @"利率最低"];
    self.infoArr = @[arr1, arr2, arr3];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake((self.collectionView.frame.size.width - 5 - 5) / 3.0, CollectionViewHeight);
}

#pragma mark - IBAction
- (IBAction)onTapBtn:(id)sender {
    UIButton *btn = sender;
    self.curSelctedBtnTag = btn.tag;
    self.curArr = [self.infoArr objectAtIndex:btn.tag - 1];
    [self.collectionView reloadData];
    if (self.changeHeaderViewHeightHandler) {
        NSInteger row = self.curArr.count / 3;
        if (0 != self.curArr.count % 3) {
            row ++;
        }
        self.changeHeaderViewHeightHandler(40 + 1 + 15 + row * (CollectionViewHeight + 5) + 10);
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.curArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AllLoanCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AllLoanCollectionViewCell" forIndexPath:indexPath];
    NSString *titleStr = [self.curArr objectAtIndex:indexPath.row];
    cell.titleLab.text = titleStr;
    UIButton *btn = [self viewWithTag:self.curSelctedBtnTag];
    cell.isSelected = [btn.titleLabel.text isEqualToString:titleStr];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = [self.curArr objectAtIndex:indexPath.row];
    UIButton *btn = [self viewWithTag:self.curSelctedBtnTag];
    [btn setTitle:title forState:UIControlStateNormal];
    if (self.changeHeaderViewHeightHandler) {
        self.changeHeaderViewHeightHandler(40 + 1 + 10);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
