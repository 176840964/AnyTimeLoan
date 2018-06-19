//
//  CommonModel.h
//  AnyTimeLoan
//
//  Created by 张晓龙 on 2018/6/19.
//  Copyright © 2018年 张晓龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonModel : NSObject

@property (strong, nonatomic) NSNumber *xid;
@property (strong, nonatomic) NSNumber *post_type;
@property (strong, nonatomic) NSNumber *user_id;
@property (strong, nonatomic) NSNumber *comment_status;
@property (strong, nonatomic) NSNumber *is_top;
@property (strong, nonatomic) NSNumber *recommended;
@property (strong, nonatomic) NSNumber *post_hits;
@property (strong, nonatomic) NSNumber *post_like;
@property (strong, nonatomic) NSNumber *create_time;
@property (strong, nonatomic) NSNumber *update_time;
@property (strong, nonatomic) NSNumber *published_time;
@property (copy, nonatomic) NSString *post_title;
@property (copy, nonatomic) NSString *post_keywords;
@property (copy, nonatomic) NSString *post_excerpt;
@property (copy, nonatomic) NSString *post_source;
@property (copy, nonatomic) NSString *post_content;
@property (copy, nonatomic) NSString *thumbnail;
@property (copy, nonatomic) NSString *tmp;
@property (copy, nonatomic) NSString *add_apply_age;

+ (instancetype)createCommonModelByDic:(NSDictionary *)dic;

@end
