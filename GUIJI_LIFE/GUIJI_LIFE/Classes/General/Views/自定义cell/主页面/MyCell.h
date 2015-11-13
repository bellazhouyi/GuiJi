//
//  MyCell.h
//  te
//
//  Created by 邢家赫 on 15/11/9.
//  Copyright © 2015年 邢家赫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Genie.h"
#import <QuartzCore/QuartzCore.h>

// 传递时间给闹钟
typedef void (^passTimeBlock)(NSString *);


@interface MyCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imView;

@property (weak, nonatomic) IBOutlet UILabel *namelabel;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

// 弹出抽屉 button
@property (weak, nonatomic) IBOutlet UIButton *leftButton;

@property (weak, nonatomic) IBOutlet UIView *leftBox;

// 添加日程完成
@property (weak, nonatomic) IBOutlet UIButton *addButton;

// 是否添加闹钟开关
@property (weak, nonatomic) IBOutlet UISwitch *clockSwitch;
// 添加事件文本
@property (weak, nonatomic) IBOutlet UITextField *addTextField;

// 闹钟提醒
@property (weak, nonatomic) IBOutlet UILabel *clockLabel;
// 弹出 / 收起 抽屉
- (void) genieToRect: (CGRect)rect edge: (BCRectEdge) edge;

// 气泡图片
@property (weak, nonatomic) IBOutlet UIImageView *bubbleimage;

// 日程模型
@property (nonatomic,strong) Schedule *schedule;
// cell的标记
@property (nonatomic,assign) NSInteger num;

// 传递time block
@property (nonatomic,copy) passTimeBlock passTimeBlock;

// setter方法
- (void)setSchedule:(Schedule *)schedule;


@end
