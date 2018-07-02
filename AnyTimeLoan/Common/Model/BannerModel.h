//
//  BannerModel.h
//  AnyTimeLoan
//
//  Created by 张晓龙 on 2018/7/2.
//  Copyright © 2018年 张晓龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerModel : NSObject

@property (strong, nonatomic) NSNumber *bid;
@property (strong, nonatomic) NSNumber *slide_id;
@property (strong, nonatomic) NSNumber *status;
@property (strong, nonatomic) NSNumber *list_order;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *image;
@property (copy, nonatomic) NSString *url;

+ (instancetype)createBannerModelByDic:(NSDictionary *)dic;

@end
