//
//  UserInfoManager.h
//  AnyTimeLoan
//
//  Created by 张晓龙 on 2018/6/26.
//  Copyright © 2018年 张晓龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoManager : NSObject
@property (assign, nonatomic) BOOL isLogin;
@property (copy, nonatomic) NSString *userToken;
@property (copy, nonatomic) NSString *userMobile;

+ (instancetype)shareInstance;

@end
