//
//  AFNetWorkUtility.m
//  AspectsDemo
//
//  Created by 张乐工作 on 2019/11/22.
//  Copyright © 2019 张乐. All rights reserved.
//

#import "AFNetWorkUtility.h"

@implementation AFNetWorkUtility

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    static AFNetWorkUtility *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[AFNetWorkUtility alloc] init];
    });
    return manager;
}

/**
 * 创建网络请求管理类单例对象
 */
static dispatch_once_t pred;
static AFHTTPSessionManager *manager = nil;
+ (AFHTTPSessionManager *)sharedHTTPOperationManager {
    dispatch_once(&pred, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.HTTPMaximumConnectionsPerHost = 10;
        config.timeoutIntervalForRequest = 30.0f;
        manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:config];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        //无条件的信任服务器上的证书
        AFSecurityPolicy *securityPolicy =  [AFSecurityPolicy defaultPolicy];
        //客户端是否信任非法证书
        securityPolicy.allowInvalidCertificates = YES;
        //是否在证书域字段中验证域名
        securityPolicy.validatesDomainName = NO;
        manager.securityPolicy = securityPolicy;
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"ios.%@",[UIDevice version]] forHTTPHeaderField:@"HC-ACCESS-VERSION"];
        //获取设备uuid
        //[manager.requestSerializer setValue:[FCUUID uuidForDevice] forHTTPHeaderField:@"HC-ACCESS-UUID"];
    });
//    if (kUserToken != nil && ![manager.requestSerializer.HTTPRequestHeaders objectForKey:@"HC-ACCESS-TOKEN"]) {
        [manager.requestSerializer setValue:@"czo2MDoiNDNhMm0vcGhjWElaS052cDduZldCZXhZWXZpZnB3ZEpQa3dBdUFVOWFLd0FOUWo2UXMwZUZxQ3cxQTJMIjs=" forHTTPHeaderField:@"HC-ACCESS-TOKEN"];
//    }
    return manager;
}

+ (RACSignal *)racGETWthURL:(NSString *)path params:(NSDictionary *)params {
    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        AFHTTPSessionManager *manager = [self sharedHTTPOperationManager];
        NSURLSessionDataTask *task = [manager GET:[self getUrlPath:path] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self handleResultWithSubscriber:subscriber operation:task responseObject:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}
+ ( NSString *)getUrlPath:(NSString *)path {
    return [NSString stringWithFormat:@"%@%@",BaseUrl,path];
}

/**
 统一解析数据
 */
+ (void)handleResultWithSubscriber:(id <RACSubscriber>)subscriber operation:(NSURLSessionDataTask *)operation responseObject:(id)responseObject {
   // NSLog(@"打印接口请求数据 %@",responseObject);
    [subscriber sendNext:responseObject];
    [subscriber sendCompleted];
//    NSInteger status = [[responseObject objectForKey:@"code"] integerValue];
//    if (status == 200) {
//        if ([HTRealReachability shareManager].status == RealStatusUnknown || [HTRealReachability shareManager].status == RealStatusNotReachable) {
//            //网络请求成功后，默认WIFI状态
//            [HTRealReachability shareManager].status = RealStatusViaWiFi;
//        }
//        [subscriber sendNext:responseObject];
//        [subscriber sendCompleted];
//        HTLog(@"请求api成功->%@",operation.currentRequest.URL.absoluteString);
//    }else if (status == 401) {
//        NSLog(@"账号异常,请重新登录 %@",responseObject);
//        [self cancelAllOperations];
//        ShowMessage(@"账号异常,请重新登录");
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            if (![kWindow.rootViewController isKindOfClass: [NSClassFromString(@"HTLoginViewController") class]]) {
//                [[AppManager shareManager] loginOutAction];
//                [[AppManager shareManager] openLoginVc];
//            }
//        });
//    }else {
//        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
//        NSString *errorInfo = [responseObject objectForKey:@"message"];
//        userInfo[errorInfoKey] = errorInfo;
//        NSError * error = [NSErrorHelper createErrorWithUserInfo:userInfo domain:nil code:status];
//        [subscriber sendError:error];
//        HTLog(@"请求api报错->%@  %@",operation.currentRequest.URL.absoluteString,error);
//    }
}

@end
