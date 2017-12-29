//
//  ViewController.m
//  pop手势返回
//
//  Created by mo on 2017/12/28.
//  Copyright © 2017年 momo. All rights reserved.
//

#import "ViewController.h"
#import <UINavigationController+FDFullscreenPopGesture.h>
#import <WRNavigationBar.h>

#define NAVBAR_COLORCHANGE_POINT (IMAGE_HEIGHT - NAV_HEIGHT*2)
#define IMAGE_HEIGHT 220
#define NAV_HEIGHT 64
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UIImageView *topView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *searchButton;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tableVeiw_main.frame = CGRectMake(0, -64, self.view.frame.size.width, self.view.frame.size.height);
    
    // 设置导航栏颜色
    [self wr_setNavBarBarTintColor:[UIColor colorWithRed:12/255.0 green:144/255.0 blue:168/255.0 alpha:1.0]];
    
    // 设置初始导航栏透明度
    [self wr_setNavBarBackgroundAlpha:0];
    
    // 设置导航栏按钮和标题颜色
    [self wr_setNavBarTintColor:[UIColor whiteColor]];
//    self.title = @"看我";
    
    self.tableView.tableHeaderView = self.topView;
    
    [self setSearchButton];


}

- (void)setSearchButton{
    
    
    self.searchButton = [[UIButton alloc]initWithFrame:CGRectMake(0, -3, 230, 30)];
    [self.searchButton setTitle:@"搜索职位/公司/商区" forState:UIControlStateNormal];
    self.searchButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.searchButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.searchButton setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [self.searchButton addTarget:self action:@selector(onClickSearchBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = self.searchButton;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_COLORCHANGE_POINT)
    {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAV_HEIGHT;
        [self wr_setNavBarBackgroundAlpha:alpha];
        [self wr_setNavBarTintColor:[[UIColor redColor] colorWithAlphaComponent:alpha]];
        [self wr_setNavBarTitleColor:[[UIColor redColor] colorWithAlphaComponent:alpha]];
        [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
        
    }
    else
    {
        [self wr_setNavBarBackgroundAlpha:0];
        [self wr_setNavBarTintColor:[UIColor whiteColor]];
        [self wr_setNavBarTitleColor:[UIColor whiteColor]];
        [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
        //        self.title = @"";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     NSString *ID = @"cells";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
       
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
    
}

- (int)navBarBottom
{
    if ([WRNavigationBar isIphoneX]) {
        return 88;
    } else {
        return 64;
    }
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        _tableView = [[UITableView alloc] initWithFrame:frame
                                                  style:UITableViewStylePlain];
        _tableView.contentInset = UIEdgeInsetsMake(-[self navBarBottom], 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


- (UIImageView *)topView
{
    if (_topView == nil) {
        _topView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wbBG"]];
        _topView.frame = CGRectMake(0, 0, self.view.frame.size.width, IMAGE_HEIGHT);
    }
    return _topView;
}

@end
