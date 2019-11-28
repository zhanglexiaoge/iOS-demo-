//
//  Manage.m
//  AspectsDemo
//
//  Created by 张乐工作 on 2019/11/22.
//  Copyright © 2019 张乐. All rights reserved.
//

#import "Manage.h"

@implementation Manage

+ (instancetype)share {
    static Manage *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[Manage alloc] init];
    });
    return manager;
}
@end
