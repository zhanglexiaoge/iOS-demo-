//
//  HomeViewCell.m
//  AspectsDemo
//
//  Created by 张乐工作 on 2019/11/21.
//  Copyright © 2019 张乐. All rights reserved.
//

#import "HomeViewCell.h"
#import <SDWebImage/SDWebImage.h>

@implementation HomeViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}
- (void) setupUI {
    _imageview = [[UIImageView alloc] init];
    self.imageview.frame = CGRectMake(15, 10, 50, 50);
    self.imageView.backgroundColor = [UIColor blueColor];
    _label = [UILabel new];
    _label.font = [UIFont systemFontOfSize:20];
    _label.textColor = [UIColor blackColor];
    self.label.frame = CGRectMake(CGRectGetMaxX(self.imageview.frame) + 10, 25, ScreenWidth - CGRectGetMaxX(self.imageview.frame) - 25, 20);
    [self.contentView addSubview:self.imageview];
    [self.contentView addSubview:self.label];
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(ScreenWidth - 60, 20, 45, 30);
    [self.button setTitle:@"button" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(handleCellButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.button];
}

- (void)handleCellButton:(UIButton *)sender {
    //EventPlist HomeViewCell 类名 不能Vc类名
    NSLog(@">>>>点击cell上button");
}
- (void)updteModel:(homeModel *)model {
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:[UIImage imageNamed:@"annuecementicon"]];
    self.label.text = model.index;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
