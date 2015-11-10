//
//  PackViewController.m
//  GUIJILIFE
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 周屹. All rights reserved.
//

#import "PackViewController.h"
#import "PackCell.h"
@interface PackViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation PackViewController

static NSString * PackCellID = @"PackCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建tableView
    self.tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    // 添加tableView 在View 上
    [self.view addSubview:self.tableView];
    
    // 设置代理
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"PackCell" bundle:nil] forCellReuseIdentifier:PackCellID];
    
    // 创建一个imageView
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Background.jpg"]];
    
    // 将imageView 设置为tableView 的背景视图
    self.tableView.backgroundView = imageView;
    
    // scrollbar 不显示
    self.tableView.showsVerticalScrollIndicator = NO;
    
    // 隐藏cell 分割线
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    //禁止tableView 回弹
    self.tableView.bounces = NO;
    
}

#pragma mark - 禁止屏幕旋转
- (BOOL)shouldAutorotate
{
    return NO;
}


#pragma mark - UITableViewDataSource  UITableViewDelegate

#pragma mark - 设置cell 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

#pragma mark - 设置cell 内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PackCell *cell=[tableView dequeueReusableCellWithIdentifier:PackCellID forIndexPath:indexPath];
    
    cell.backgroundColor=[UIColor clearColor];
    
    return cell;
}

#pragma mark  设置cell 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

@end
