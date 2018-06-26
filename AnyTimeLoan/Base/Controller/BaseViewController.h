//
//  BaseViewController.h
//  AnyTimeLoan
//
//  Created by 张晓龙 on 2017/12/4.
//  Copyright © 2017年 张晓龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : NetErrorViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (copy, nonatomic) dispatch_block_t refreshCtrlHandler;
@property (assign, nonatomic) NSInteger pageIndex;

@end
