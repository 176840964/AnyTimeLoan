//
//  UserInfoManager.m
//  AnyTimeLoan
//
//  Created by 张晓龙 on 2018/6/26.
//  Copyright © 2018年 张晓龙. All rights reserved.
//

#import "UserInfoManager.h"

@implementation UserInfoManager

+ (instancetype)shareInstance {
    static UserInfoManager *s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[self alloc] init];
    });
    
    return s_instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isLogin = NO;
    }
    return self;
}

@end
