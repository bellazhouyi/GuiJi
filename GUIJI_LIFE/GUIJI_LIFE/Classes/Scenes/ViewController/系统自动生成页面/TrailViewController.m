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


//用于存储MapInfo的数组
@property(nonatomic,strong) NSMutableArray *arrayMapInfo;


@end

@implementation TrailViewController

static NSString *upCellID = @"cell";
static NSString *downCellID = @"cellID";

#pragma mark 视图加载完成
- (void)viewDidLoad {
    [super viewDidLoad];
    
#pragma mark 显示
    
    // 初始化TableView
    self.tableView = [UITableView new];
    
    // 将tableView 添加到View上
    [self.view addSubview:self.tableView];
    
    
    // 设置代理
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"Trail_UpCell" bundle:nil] forCellReuseIdentifier:upCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"Trail_DownCell" bundle:nil] forCellReuseIdentifier:downCellID];
    
    // tableView 逆时针旋转90度
    self.tableView.transform = CGAffineTransformMakeRotation(-M_PI/2);
    
    // 创建一个imageView
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Background.jpg"]];
    
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
    
    
#pragma mark  获取数据
    [self loadData];
    
    
}

#pragma mark 加载数据
-(void)loadData{
    
    TrailHelper *trailHelper = [[TrailHelper alloc]init];
    
#warning 测试的时候,改为8,而不是7
    for (int time = 7; time <= 32;) {
        MapInfo *timeMapInfo = [trailHelper gainMapInfoFromCoreDataBySpecifiedHour:time + 8];
        
        //判断当前用户是否有轨迹移动的数据
        if (timeMapInfo == nil) {
            NSLog(@"当前时刻没有开启地图定位功能");
        }
        else{
            NSLog(@"  %@",timeMapInfo.locationName);
        //添加到数组中
        [self.arrayMapInfo addObject:timeMapInfo];
        }
        time = time + 2;
    }
    

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
    return self.arrayMapInfo.count;
}

#pragma mark - cell 的行内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.row % 2) == 0) {
        Trail_UpCell *upCell = [tableView dequeueReusableCellWithIdentifier:upCellID forIndexPath:indexPath];
        
        
        // cell 顺时针旋转90度
        upCell.contentView.transform = CGAffineTransformMakeRotation(M_PI/2);
        
        // 设置 cell 的背景颜色为透明
        upCell.backgroundColor = [UIColor clearColor];
        
        //把数据填充到upCell上
        MapInfo *upMapInfo = self.arrayMapInfo[indexPath.row];
        
        if (upMapInfo == nil) {
        
            upCell.UPLabel.text = @"Sorry,那个时候还没跟上你的脚步";
        }else{
            
            NSString *message = [NSString stringWithFormat:@"%@+%@",upMapInfo.time,upMapInfo.locationName];
            
            upCell.UPLabel.text = message;
        }
        
        
        return upCell;
    }else{
        Trail_DownCell *downCell = [tableView dequeueReusableCellWithIdentifier:downCellID forIndexPath:indexPath];
        
        // cell 顺时针旋转90度
        downCell.contentView.transform = CGAffineTransformMakeRotation(M_PI/2);
        
        // 设置 cell 的背景颜色为透明
        downCell.backgroundColor=[UIColor clearColor];
        
        //把数据填充到upCell上
        MapInfo *upMapInfo = self.arrayMapInfo[indexPath.row];
        
        if (upMapInfo == nil) {
            
            downCell.DownLabel.text = @"Sorry,那个时候还没跟上你的脚步";
        }else{
            
            NSString *message = [NSString stringWithFormat:@"%@+%@",upMapInfo.time,upMapInfo.locationName];
            
            downCell.DownLabel.text = message;
        }

        
        return downCell;
    }
}

#pragma mark - 设置cell 高度（因为cell是旋转了90度，所以其实是设置cell的宽度）
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


#pragma mark 懒加载
-(NSMutableArray *)arrayMapInfo{
    if (!_arrayMapInfo) {
        _arrayMapInfo = [NSMutableArray arrayWithCapacity:10];
    }
    return _arrayMapInfo;
}

@end
