//
//  HomeViewController.m
//  AspectsDemo
//
//  Created by 张乐工作 on 2019/11/21.
//  Copyright © 2019 张乐. All rights reserved.
//

#import "HomeViewController.h"
#import "SDCycleScrollView.h"
#import "HomeViewCell.h"
#import "homeModel.h"
#import "NextViewController.h"
#import "NextTwoViewController.h"

@interface HomeViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *customTableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) SDCycleScrollView *sdCycleScrollView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Manage share].isLogin = YES;
    [self setupUI];
}

- (void)setupUI {
    self.title = @"首页";
    self.sdCycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, IPHONE_NAVIGATION_HEIGHT, ScreenWidth, 200) delegate:self placeholderImage:[UIImage imageNamed:@"annuecementicon"]];
    self.sdCycleScrollView.imageURLStringsGroup = @[@"https://www.baidu.com/img/bd_logo1.png?qua=high&where=super",@"https://pics7.baidu.com/feed/d833c895d143ad4b92aa740e59d09daaa60f064b.jpeg?token=4bd4fd85d18489a48860fc8c7f57d508&s=58BA6FDBC63641940B854430030010D2",@"https://pics0.baidu.com/feed/5fdf8db1cb134954277734f194e5555dd0094a6f.png?token=26982a7f6150098d412d101a81fb4bea&s=5D849751669B706D10299C510300E0F0"];
    [self.view addSubview:self.sdCycleScrollView];
    self.customTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.sdCycleScrollView.frame), ScreenWidth, ScreenHeight - CGRectGetMaxY(self.sdCycleScrollView.frame) - IPHONE_BOTTOMSAFEAREA) style:UITableViewStylePlain];
    [self.view addSubview:self.customTableView];
    self.customTableView.delegate = self;
    self.customTableView.dataSource = self;
    [self.customTableView registerClass:[HomeViewCell class] forCellReuseIdentifier:@"HomeViewCell"];
    self.dataArray = [NSMutableArray array];
    for (int i = 0; i< 50; i++) {
        homeModel *model = [homeModel initUrl:@"https://pics7.baidu.com/feed/d833c895d143ad4b92aa740e59d09daaa60f064b.jpeg?token=4bd4fd85d18489a48860fc8c7f57d508&s=58BA6FDBC63641940B854430030010D2" withIndex:[NSString stringWithFormat:@"%d",i]];
        [self.dataArray addObject:model];
        
    }
    [self.customTableView reloadData];
    
    
}

-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeViewCell" forIndexPath:indexPath];
    [cell updteModel:self.dataArray[indexPath.row]];
    cell.indexPath = indexPath;
    return cell;
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        NextTwoViewController *nextVc = [[NextTwoViewController alloc] init];
        [self.navigationController pushViewController:nextVc animated:NO];
    }else {
        NextViewController *nextVc = [[NextViewController alloc] init];
        [self.navigationController pushViewController:nextVc animated:NO];
    }
  
}
@end
