//
//  Utility.h
//  AspectsDemo
//
//  Created by 张乐工作 on 2019/11/21.
//  Copyright © 2019 张乐. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Aspects.h"

NS_ASSUME_NONNULL_BEGIN

@interface Utility : NSObject
#pragma mark --埋点事件
+(void)trackAspectHooks;
@end

NS_ASSUME_NONNULL_END
