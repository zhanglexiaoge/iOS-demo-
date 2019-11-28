//
//  UIButton+FixButton.m
//  AspectsDemo
//
//  Created by 张乐工作 on 2019/11/21.
//  Copyright © 2019 张乐. All rights reserved.
//

#import "UIButton+FixButton.h"
#import <objc/message.h>
@interface UIButton ()
@property (nonatomic, assign) NSTimeInterval clickTime;
@end
@implementation UIButton (FixButton)
//设置关联对象
//objc_setAssociatedObject(<#id object#>, <#const void *key#>, <#id value#>, <#objc_AssociationPolicy policy#>)
//1.第一个参数:  id object : 需要传入的是 : 对象的主分支
//2.第二个参数:  const void *key : 是一个 static 类型的 关键字,这里根据开发者自身来定义就行(尽量写的有根据一点,避免以后忘记是干啥用的)
//3.第三个参数:  id value : 传入的是: 对象的子分支
//4.第四个参数: objc_AssociationPolicy policy :是当前关联对象的类型 strong,weak,copy (枚举类型:开发者可以点进去看)
//获取关联对象
//objc_getAssociatedObject(<#id object#>, <#const void *key#>)就相对来说容易理解一点了
//
//1.第一个参数 : 主分支
//2.第二个参数 : 关键字

//防止button 连续点击
- (NSTimeInterval)clickTime {
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}
//动态设置类的属性 clickTime
-(void)setClickTime:(NSTimeInterval)clickTime {
    objc_setAssociatedObject(self, @selector(clickTime), @(clickTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//动态设置类的属性 clickInterval
-(NSTimeInterval)clickInterval {
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}
-(void)setClickInterval:(NSTimeInterval)clickInterval {
    objc_setAssociatedObject(self, @selector(clickInterval), @(clickInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (void)load {
    //    AspectPositionInstead = 1,            /// Will replace the original implementation. 是替换原方法
    //^(id<AspectInfo> info){ } 传入block
    [UIButton aspect_hookSelector:@selector(sendAction:to:forEvent:) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> info){
        //info.instance 获取对象
        UIButton *obj = info.instance;
        NSLog(@">>>>%f",obj.clickInterval);
        if (obj.clickInterval <= 0) {
//            //获取当前时间和点击时间 差
//            if ([NSDate date].timeIntervalSince1970 - obj.clickTime < 0.25) {
//                return;
//            }
//            obj.clickTime = [NSDate date].timeIntervalSince1970;
//            [info.originalInvocation invoke];
            //执行原来的方法
            [info.originalInvocation invoke];
        }else {
            //获取当前时间和点击时间 差
            if ([NSDate date].timeIntervalSince1970 - obj.clickTime < obj.clickInterval) {
                return;
            }
            obj.clickTime = [NSDate date].timeIntervalSince1970;
            [info.originalInvocation invoke];

        }
    } error:nil];
}
@end
