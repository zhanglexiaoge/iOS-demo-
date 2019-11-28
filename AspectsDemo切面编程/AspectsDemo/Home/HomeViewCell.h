//
//  HomeViewCell.h
//  AspectsDemo
//
//  Created by 张乐工作 on 2019/11/21.
//  Copyright © 2019 张乐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "homeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imageview;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) NSIndexPath *indexPath;
- (void)updteModel:(homeModel *)model;
@end

NS_ASSUME_NONNULL_END
