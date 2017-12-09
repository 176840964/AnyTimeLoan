//
//  AllLoanCollectionViewCell.m
//  AnyTimeLoan
//
//  Created by 张晓龙 on 2017/12/9.
//  Copyright © 2017年 张晓龙. All rights reserved.
//

#import "AllLoanCollectionViewCell.h"

@implementation AllLoanCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLab.clipsToBounds = YES;
    self.titleLab.layer.cornerRadius = 4.0;
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    if (isSelected) {
        self.titleLab.textColor = [UIColor colorWithRed:243 / 255.0 green:129 / 255.0 blue:50 / 255.0 alpha:1.0];
        self.titleLab.layer.borderWidth = 1.0;
    } else {
        self.titleLab.textColor = [UIColor lightGrayColor];
        self.titleLab.layer.borderWidth = 0;
    }
    self.titleLab.layer.borderColor = self.titleLab.textColor.CGColor;
}

@end
