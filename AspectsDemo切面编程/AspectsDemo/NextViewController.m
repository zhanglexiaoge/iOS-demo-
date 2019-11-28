//
//  NextViewController.m
//  AspectsDemo
//
//  Created by 张乐工作 on 2019/11/21.
//  Copyright © 2019 张乐. All rights reserved.
//

#import "NextViewController.h"
#import "LoginViewController.h"


@interface NextViewController ()

@end

@implementation NextViewController
- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"拦截后 验证是否执行");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"next";
    [self setupUI];
   // [self reqestData];
}

- (void)reqestData {
    [[AFNetWorkUtility racGETWthURL:@"api/app/get" params:nil] subscribeNext:^(id  _Nullable x) {
        
    } error:^(NSError * _Nullable error) {
        
    }];
}

- (void) setupUI {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(50, 150, 50, 30)];
    //button.clickInterval = 0.25;
    [button setTitle:@"button" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(handelButtonTest:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(150, 150, 50, 30)];
    [button1 setTitle:@"button1" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:button1];
    [button1 addTarget:self action:@selector(handelButton1:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *view2 = [[UIView alloc ]initWithFrame:CGRectMake(50, 250, 50, 30)];
    view2.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view2];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handeltapTest:)];
    [view2 addGestureRecognizer:tap2];
    
    UIView *view1 = [[UIView alloc ]initWithFrame:CGRectMake(150, 250, 50, 30)];
    view1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view1];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handeltap1:)];
    [view1 addGestureRecognizer:tap1];
    
}
- (void)handelButtonTest:(UIButton *)sender {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        LoginViewController *logvc = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:logvc animated:NO];
    });
    
}

- (void)handelButton1:(UIButton *)sender {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        LoginViewController *logvc = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:logvc animated:NO];
    });
    
}
- (void)handeltapTest:(UITapGestureRecognizer *)sender {
    LoginViewController *logvc = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:logvc animated:NO];
}

- (void)handeltap1:(UITapGestureRecognizer *)sender {
    LoginViewController *logvc = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:logvc animated:NO];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
