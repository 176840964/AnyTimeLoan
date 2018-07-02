//
//  BannerModel.m
//  AnyTimeLoan
//
//  Created by 张晓龙 on 2018/7/2.
//  Copyright © 2018年 张晓龙. All rights reserved.
//

#import "BannerModel.h"

@implementation BannerModel

+ (instancetype)createBannerModelByDic:(NSDictionary *)dic {
    id obj = [[self alloc] init];
    [obj setValuesForKeysWithDictionary:dic];
    return obj;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
}

-(void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.bid = value;
    }
}
@end
