//
//  ViewController.m
//  ttt
//
//  Created by 邢家赫 on 15/11/9.
//  Copyright © 2015年 邢家赫. All rights reserved.
//

#import "ViewController.h"
#import "MyCell.h"
#import "UIView+Genie.h"
#import <QuartzCore/QuartzCore.h>
#import "ADCircularMenuViewController.h"
#define KscreenHeight [UIScreen mainScreen].bounds.size.height

typedef void (^block) (void);

@interface ViewController () <UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,ADCircularMenuDelegate>
{
    ADCircularMenuViewController *circularMenuVC;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 视图是否收起
@property (nonatomic) BOOL viewIsIn;


// 添加Topbutton
@property (nonatomic,strong)  NSArray *buttons;

// 给buttons传值
@property (nonatomic,copy) block passBlock;

// footerview
@property (nonatomic,strong) UIView *footerView;


// 记录line的原始位置
@property (nonatomic,assign) CGRect frame;
// 判断是否已经旋转90度
@property (nonatomic,assign) BOOL turn;

// 毛玻璃
@property (weak, nonatomic) IBOutlet UIVisualEffectView *visualView;

@property (weak, nonatomic) IBOutlet UIImageView *lineView;

// 下抽屉
@property (weak, nonatomic) IBOutlet UITableView *boundingBox;

// 返回按钮
@property (weak, nonatomic) IBOutlet UIButton *backButton;

// 下按钮(行囊)
@property (weak, nonatomic) IBOutlet UIButton *TopButton;


// 设置抽屉 边缘
@property (nonatomic,assign) CGRect endRect;

// 第一次指示气泡(判断是否是第一次)
@property (nonatomic,assign) BOOL first;

// 所有日程数据数组
@property (nonatomic,strong) NSMutableArray *dataArray;

// 数据管理者
@property (nonatomic,strong) ScheduleHelper *scheduleHelper;

// 右下角菜单
@property (weak, nonatomic) IBOutlet UIButton *rightButton;


@end

static NSString *const cellID = @"mycell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // box隐藏
    self.buttons = @[_TopButton];
    self.boundingBox.hidden = YES;
    
    // 毛玻璃隐藏
    _visualView.hidden = YES;
    
    
    // 给毛玻璃添加tap手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.visualView addGestureRecognizer:tap];
    

    // 给lineView添加手势
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapviewAction)];
    [self.lineView addGestureRecognizer:tap1];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MyCell" bundle:nil] forCellReuseIdentifier:cellID];
    
    // tableview设置代理
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

}


// 右下角菜单按钮
- (IBAction)rightButtonAction:(UIButton *)sender {
    
    
    circularMenuVC = nil;
    
    //use 3 or 7 or 12 for symmetric look (current implementation supports max 12 buttons)
    NSArray *arrImageName = [[NSArray alloc] initWithObjects:@"btnMenu",
                             @"btnMenu",
                             @"btnMenu",
                             @"btnMenu",
                             @"btnMenu",
                             @"btnMenu",
                             @"btnMenu", nil];
    
    circularMenuVC = [[ADCircularMenuViewController alloc] initWithMenuButtonImageNameArray:arrImageName andCornerButtonImageName:@"btnMenuCorner"];
    
    circularMenuVC.delegateCircularMenu = self;
    [circularMenuVC show];

    
}

// 选项点击的事件
- (void)circularMenuClickedButtonAtIndex:(int) buttonIndex
{
    
    
}






#pragma mark -- 返回
- (IBAction)backAction:(UIButton *)sender {
    
        
    
    
    // 时间轴出现
    _lineView.hidden = NO;

    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        // ScrollView位移到原来位置
        self.scrollView.contentOffset = CGPointMake(0, 0);
        
        // 转动
        self.lineView.transform = CGAffineTransformMakeRotation(0);
        // 移动到原来位置
        self.lineView.frame = _frame;
        
    } completion:^(BOOL finished) {
        NSLog(@"动画完成了");
        
    }];
 
    
    
}


#pragma mark -- 旋转
- (void)tapviewAction
{
    // scrollView滚动
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.scrollView.contentOffset = CGPointMake([UIScreen mainScreen].bounds.size.width, 0);
        
        
    } completion:^(BOOL finished) {
        NSLog(@"11动画完成了");
        
        
    }];
    
    
    // 时间轴转动
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        
        // 记录初始位置
        _frame = self.lineView.frame;
        // 转动
        self.lineView.transform = CGAffineTransformMakeRotation(M_PI_2);
        // 向左移动
        self.lineView.center = CGPointMake(50, KscreenHeight / 2);
        
        
        
        
    } completion:^(BOOL finished) {
        NSLog(@"动画完成了");
        
        // 时间轴隐藏
        _lineView.hidden = YES;
    }];

}



#pragma mark -- 弹出/收起 抽屉
- (void) genieToRect: (CGRect)rect edge: (BCRectEdge) edge
{
    
    _endRect = CGRectInset(rect,50.0,50.0);

    if (self.viewIsIn) {
        
        
        
            // 上抽屉
            
            [self.boundingBox genieInTransitionWithDuration:1 destinationRect:_endRect destinationEdge:edge completion:
             ^{
                 // 上抽屉收回 毛玻璃隐藏
                 _visualView.hidden = YES;
                 // 返回按钮显示
                 _backButton.hidden = NO;
                 
                 [self.buttons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
                     button.enabled = YES;
                     
                     
                 }];
             }];
        
        
        
    }
    else
    {  // 抽屉弹出
        
        
            // 返回按钮隐藏
            _backButton.hidden = YES;
            
            // 毛玻璃显示
            _visualView.hidden = NO;
            
            [self.boundingBox genieOutTransitionWithDuration:1 startRect:_endRect startEdge:edge completion:^{
                [self.buttons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
                    button.enabled = YES;
                    
                    
                    
                }];
            }];
            
        
        
        
        
    }

    self.viewIsIn = ! self.viewIsIn;
    
}







#pragma mark -- 毛玻璃消失

- (void)tapAction
{
    [self genieToRect:_TopButton.frame edge:BCRectEdgeTop];
}


#pragma mark -- 毛玻璃消失

- (IBAction)topAction:(UIButton *)sender {
    
    
    // box一直存在,以前隐藏了 现在再显示
    self.boundingBox.hidden = NO;
    
    [self genieToRect:sender.frame edge:BCRectEdgeTop];


}



#pragma mark -- row的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ScheduleHelper *scheduleHelper = [ScheduleHelper sharedDatamanager];
    return  scheduleHelper.scheduleArray.count;

}


#pragma mark -- cell内容

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.addTextField.delegate = self;
    
    ScheduleHelper *scheduleHelper = [ScheduleHelper sharedDatamanager];
    
    Schedule *schedule = scheduleHelper.scheduleArray[indexPath.row];
    
    cell.num = indexPath.row;
    
    cell.leftButton.titleLabel.text = [NSString stringWithFormat:@"%ld",cell.num + 6];
    cell.schedule = schedule;

    
    return cell;
}

#pragma mark  -- UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark -- cell高度

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}



#pragma mark -- 区头

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(5, 0, 200, 80);
    titleLabel.textColor = [UIColor purpleColor];
    titleLabel.text = @"为你的行程填上一笔";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    return titleLabel;
    
}

#pragma mark -- 区头高度

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80;
}


// 选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取cell
    MyCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // 如果namelabel 为空 点击无效果
    if ([cell.namelabel.text isEqualToString:@""]) {
        return;
    }
    else
    {
        // 如果namelabel 不为空 弹出/收起 抽屉
        [cell genieToRect:cell.leftButton.frame edge:BCRectEdgeRight];
    }

    cell.namelabel.text = @"ttttttttttt";
    
    
}


#pragma mark - 懒加载
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


#pragma mark -跳转到系统自动生成轨迹页面
- (IBAction)toTrailVCAction:(UIButton *)sender {
    
    TrailViewController *trailVC = [TrailViewController new];
    
    [self presentViewController:trailVC animated:YES completion:nil];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
