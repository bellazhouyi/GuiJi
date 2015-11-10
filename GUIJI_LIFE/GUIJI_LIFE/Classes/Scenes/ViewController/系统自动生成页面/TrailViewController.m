//
//  TrailViewController.m
//  GUIJILIFE
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 周屹. All rights reserved.
//

#import "TrailViewController.h"
#import "Trail_UpCell.h"
#import "Trail_DownCell.h"
@interface TrailViewController ()<UITableViewDelegate,UITableViewDataSource>

// UITableView 的实例
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation TrailViewController

static NSString *cellID = @"cell";
static NSString *cellid = @"cellID";

#pragma mark 视图加载完成
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // 初始化TableView
    self.tableView = [UITableView new];
    
    // 将tableView 添加到View上
    [self.view addSubview:self.tableView];
    
    
    // 设置代理
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"Trail_UpCell" bundle:nil] forCellReuseIdentifier:cellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"Trail_DownCell" bundle:nil] forCellReuseIdentifier:cellid];
    
    // tableView 逆时针旋转90度
    self.tableView.transform = CGAffineTransformMakeRotation(-M_PI/2);
    
    // 创建一个imageView
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"2.jpg"]];
    
    // 将imageView 设置为tableView 的背景视图
    self.tableView.backgroundView = imageView;
    
    // 设置tableView 的大小
    self.tableView.frame = self.view.bounds;
    
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


#pragma mark - UITableViewDelegate UITableViewDataSource

#pragma mark - 设置cell 的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

#pragma mark - cell 的行内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.row % 2) == 0) {
        Trail_UpCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        
        
        // cell 顺时针旋转90度
        cell.contentView.transform = CGAffineTransformMakeRotation(M_PI/2);
        
        // 设置 cell 的背景颜色为透明
        cell.backgroundColor = [UIColor clearColor];
        
        
        return cell;
    }else{
        Trail_DownCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
        
        // cell 顺时针旋转90度
        cell.contentView.transform = CGAffineTransformMakeRotation(M_PI/2);
        
        // 设置 cell 的背景颜色为透明
        cell.backgroundColor=[UIColor clearColor];
        
        return cell;
    }
}

#pragma mark - 设置cell 高度（因为cell是旋转了90度，所以其实是设置cell的宽度）
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

@end
