//
//  CommonModel.m
//  AnyTimeLoan
//
//  Created by 张晓龙 on 2018/6/19.
//  Copyright © 2018年 张晓龙. All rights reserved.
//

#import "CommonModel.h"

@implementation CommonModel

+ (instancetype)createCommonModelByDic:(NSDictionary *)dic {
    id obj = [[self alloc] init];
    [obj setValuesForKeysWithDictionary:dic];
    return obj;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
}

-(void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.xid = value;
    } else if ([key isEqualToString:@"new_add_apply_age"]) {
        self.add_apply_age = value;
    } else if ([key isEqualToString:@"more"]) {
        self.thumbnail = [value objectForKey:@"thumbnail"];
        self.tmp = [value objectForKey:@"template"];
    }
}

@end
