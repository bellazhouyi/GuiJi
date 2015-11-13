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


#define KscreenHeight [UIScreen mainScreen].bounds.size.height

typedef void (^block) (void);

@interface ViewController () <UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

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


// 时间轴
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


@end

static NSString *const cellID = @"mycell";

@implementation ViewController

//- (void)loadView
//{
//    
//    
//    // 加载数据
//    //s = [[ScheduleHelper alloc] init];
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    ScheduleHelper *s = [ScheduleHelper sharedDatamanager];
    
    NSLog(@"scheduleArray : %@",s.scheduleArray);

    
    
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

    
    



// 返回
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


// 旋转
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



// 弹出/收起 抽屉
- (void) genieToRect: (CGRect)rect edge: (BCRectEdge) edge
{
    
//self.boundingBox.frame.size.width / 2, self.boundingBox.frame.size.height /2
    
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

// 毛玻璃消失
- (void)tapAction
{
    [self genieToRect:_TopButton.frame edge:BCRectEdgeTop];
}


// 弹出/收起抽屉
- (IBAction)topAction:(UIButton *)sender {
    
    
    // box一直存在,以前隐藏了 现在再显示
    self.boundingBox.hidden = NO;
    
    [self genieToRect:sender.frame edge:BCRectEdgeTop];


}

// 分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    ScheduleHelper *s = [ScheduleHelper sharedDatamanager];
    return  s.scheduleArray.count;
}


// 显示内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    
//    if (self.first == NO) {
//        
//        if (indexPath.row == 0) {
//            cell.bubbleimage.hidden = NO;
//            cell.namelabel.text = @"在这里添加日程";
//            cell.namelabel.hidden = NO;
//        }
//        else
//        {
//            cell.bubbleimage.hidden = YES;
//            cell.namelabel.text = @"";
//            cell.namelabel.hidden = YES;
//        }
//        self.first = YES;
//        
//    }
//    else
//    {
    
    
//    }
    
    ScheduleHelper *s = [ScheduleHelper sharedDatamanager];
    
    Schedule *schedule = s.scheduleArray[indexPath.row];
    
    cell.num = indexPath.row;
    
    cell.schedule = schedule;
    return cell;
}

// cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}



// 区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(5, 0, 200, 80);
    titleLabel.textColor = [UIColor purpleColor];
    titleLabel.text = @"为你的行程填上一笔";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    return titleLabel;
    
}
// 区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80;
}


// 选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 获取cell
    MyCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSLog(@"cell: %ld",cell.num);
    
    
    // 如果namelabel 为空 点击无效果
    if ([cell.namelabel.text isEqualToString:@""]) {
        return;
    }
    else
    {
        // 如果namelabel 不为空 弹出/收起 抽屉
        [cell genieToRect:cell.leftButton.frame edge:BCRectEdgeRight];
    }
    
}








#pragma mark - 懒加载
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
