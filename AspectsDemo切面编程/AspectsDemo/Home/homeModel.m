//
//  homeModel.m
//  AspectsDemo
//
//  Created by 张乐工作 on 2019/11/21.
//  Copyright © 2019 张乐. All rights reserved.
//

#import "homeModel.h"

@implementation homeModel
+ (instancetype)initUrl:(NSString *)url withIndex:(NSString *)index {
    return [[self alloc]initWithUrl:url withIndex:index ];
}
- (instancetype)initWithUrl:(NSString *)url withIndex:(NSString *)index {
    if (self = [super init]) {
        self.url = url;
        self.index = index;
    }
    return self;
}
@end
