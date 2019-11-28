//
//  AFNetWorkUtility.h
//  AspectsDemo
//
//  Created by 张乐工作 on 2019/11/22.
//  Copyright © 2019 张乐. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


NS_ASSUME_NONNULL_BEGIN

@interface AFNetWorkUtility : NSObject

+ (instancetype)shared;

+ (AFHTTPSessionManager *)sharedHTTPOperationManager;

+ (RACSignal *)racGETWthURL:(NSString *)path params:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
