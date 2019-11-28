//
//  homeModel.h
//  AspectsDemo
//
//  Created by 张乐工作 on 2019/11/21.
//  Copyright © 2019 张乐. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface homeModel : NSObject
+ (instancetype)initUrl:(NSString *)url withIndex:(NSString *)index;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *index;
@end

NS_ASSUME_NONNULL_END
