//
//  Utility.m
//  AspectsDemo
//
//  Created by 张乐工作 on 2019/11/21.
//  Copyright © 2019 张乐. All rights reserved.
//

#import "Utility.h"
#import <objc/message.h>
#import "HomeViewCell.h"
#import "LoginViewController.h"
#import "AFNetWorkUtility.h"

@implementation Utility
//埋点事件
+(void)trackAspectHooks{
    [Utility hookviewWillApperDisappear:[Utility getviewWillApperDisappearclassNameDict]];
    [Utility hookViewEvent];
    //[Utility hookPushViewController];
    [Utility hookAFNetWorkUtility];
   // [Utility hookviewWillApper];
    
//    AspectPositionAfter   = 0,            /// Called after the original implementation (default) 默认是AspectPositionAfter在原方法执行完之后调用
//    AspectPositionInstead = 1,            /// Will replace the original implementation. 是替换原方法
//    AspectPositionBefore  = 2,            /// Called before the original implementation. 是在原方法之前调用
//
//    AspectOptionAutomaticRemoval = 1 << 3 /// Will remove the hook after the first execution. 是在hook执行完自动移除。
    
//    // 1、被HOOK的元类、类或者实例
//    @property (nonatomic, unsafe_unretained, readonly) id instance;
//    // 2、方法参数列表
//    @property (nonatomic, strong, readonly) NSArray *arguments;
//    // 3、原来的方法
//    @property (nonatomic, strong, readonly) NSInvocation *originalInvocation;
    
}
+ (NSDictionary *)getviewWillApperDisappearclassNameDict {
   NSString *path = [[NSBundle mainBundle] pathForResource:@"ViewPlist" ofType:@"plist"];
   NSDictionary *classNameDict = [[NSDictionary alloc] initWithContentsOfFile:path];
   return classNameDict;
}
#pragma mark -- 监控统计用户进入此界面的时长，页面加载时长 频率等信息
+ (void)hookviewWillApperDisappear:(NSDictionary *)classNameDict {
    //实际上add方法 aspect_add
    [UIViewController aspect_hookSelector:@selector(viewWillAppear:)
       withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> info){
        //用户统计代码写在此处
        NSString * className = NSStringFromClass([info.instance class]);
       // NSLog(@" className >> %@", className);
        if ([[classNameDict allKeys] containsObject:className]) {
            NSDictionary *keyDict = [classNameDict objectForKey:className];
            NSString *key = [NSString stringWithFormat:@"%@%@",className,@"viewWillAppear"];
             NSLog(@"actionDict >>>>%@",[keyDict objectForKey:key]);
        }
       } error:NULL];
    //viewWillDisappear
    [UIViewController aspect_hookSelector:@selector(viewWillDisappear:)
       withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> info){
        //用户统计代码写在此处
         NSString * className = NSStringFromClass([info.instance class]);
        // NSLog(@" className >> %@", className);
         if ([[classNameDict allKeys] containsObject:className]) {
             NSDictionary *keyDict = [classNameDict objectForKey:className];
             NSString *key = [NSString stringWithFormat:@"%@%@",className,@"viewWillDisappear"];
              NSLog(@"actionDict >>>>%@",[keyDict objectForKey:key]);
         }
    }error:NULL];
}

#pragma mark -- 打印请求url 参数 数据
+ (void)hookAFNetWorkUtility{
    [AFNetWorkUtility aspect_hookSelector:@selector(racGETWthURL:params:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> info,NSString *path , NSDictionary * params) {
        NSLog(@">>>>> %@",path);
        NSLog(@">>>>> %@",params);
        
    } error:nil];
}

#pragma mark --拦截push方法
+ (void)hookPushViewController{
    
    [UINavigationController aspect_hookSelector:@selector(pushViewController:animated:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> info,UIViewController *vC){
        NSString * className = NSStringFromClass([info.instance class]);
        NSLog(@" className >> %@", className);
        NSString * vCclassName = NSStringFromClass([vC class]);
        NSLog(@" vCclassName >> %@", vCclassName);
        //那些页面必须登录后才能打开 
        NSArray *classNameArray = @[@"NextViewController"];
        if ([classNameArray containsObject:vCclassName]) {
            if (![Manage share].isLogin) {
                //并且未登录
                LoginViewController *login = [[LoginViewController alloc] init];
                UINavigationController * navLogin = [[UINavigationController alloc] initWithRootViewController:login];
                UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
                window.rootViewController = navLogin;
            }
        }
    } error:nil];
}


#pragma mark -- 监控button tap tableView 点击事件
+ (void)hookViewEvent {
    __weak typeof(self) weakSelf = self;
    //设置统计事件 异步线程
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //读取配置文件，获取需要统计的事件列表
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EventPlist" ofType:@"plist"];
        NSDictionary *eventStatisticsDict = [[NSDictionary alloc] initWithContentsOfFile:path];
        //循环遍历字典key
        for (NSString *classNameString in eventStatisticsDict.allKeys) {
            NSLog(@"遍历key类名>> %@",classNameString);
            //使用运行时创建类对象 runtime
            const char * className = [classNameString UTF8String];
            Class newclass = objc_getClass(className);
            NSArray *viewEventArray = [eventStatisticsDict objectForKey:classNameString];
            //遍历事件Id 事件方法
            for (NSDictionary *eventDict in viewEventArray) {
                //事件方法名称
                NSString *eventMethodName = eventDict[@"EventSelName"];
                SEL seletor = NSSelectorFromString(eventMethodName);
                NSString *eventId = eventDict[@"EventId"];
                [weakSelf hookParameterButtonTapEventClass:newclass selector:seletor eventID:eventId];
            }
        }
    });

}


#pragma mark -- button Tap 点击事件 带参数
+ (void) hookParameterButtonTapEventClass:(Class)class selector:(SEL)selector eventID:(NSString*)eventID {
    //aspect_add 点击事件 原方法执行完
    [class aspect_hookSelector:selector withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info, UIButton *button) {
        NSLog(@"button---->%@",button);
        NSString *className = NSStringFromClass([info.instance class]);
        NSLog(@"className--->%@",className);
        NSLog(@"event----->%@",eventID);
        //不需要判断直接执行 统计 action 就是 eventID 比如 clik_open

    } error:nil];
}




@end
