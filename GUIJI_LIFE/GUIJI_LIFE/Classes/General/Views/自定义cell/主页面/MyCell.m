//
//  MyCell.m
//  te
//
//  Created by 邢家赫 on 15/11/9.
//  Copyright © 2015年 邢家赫. All rights reserved.
//

#import "MyCell.h"

@interface MyCell () 

// 视图是否收起
@property (nonatomic) BOOL viewIsIn;

@property (nonatomic,strong) NSArray *buttons;

@end


@implementation MyCell


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
    

        
    }
    return self;
}


// 闹钟开关按钮
- (IBAction)ClockAction:(UISwitch *)sender {
    
    // 如果闹钟提醒关闭 就开启
    if (self.clockSwitch.on == YES) {
        
        self.clockLabel.text = @"闹钟已开启";
    }
    else
    {
        self.clockLabel.text = @"闹钟已关闭";
    }
    
    // 单例
    ScheduleHelper *s = [ScheduleHelper sharedDatamanager];
    
    
    
    NSLog(@"%@",s.scheduleArray);
    // 把schedule模型保存进数据库
    _schedule =  s.scheduleArray[self.num] ;
    
    // 接收闹钟开关的状态
    _schedule.isClock = [NSNumber numberWithBool:self.clockSwitch.on];
    
    [s.appDelegate.managedObjectContext save:nil];
    
    //判断数据库中保存的值是否是允许开启闹钟功能
    if ([[_schedule isClock] boolValue] == YES) {
        
        //得到时间
        NSString *hour = [NSString stringWithFormat:@"%@",[_schedule hour]];
        //得到内容
        NSString *content = [_schedule content];
        
        //是的话，就写一个通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"clock" object:nil userInfo:@{@"hour":hour,@"content":content}];
        
    }
    
    
}


// 添加完成
- (IBAction)addDownAction:(UIButton *)sender {
    
    
    
    // 把文本框内容给cell
    
    self.namelabel.text = self.addTextField.text;

    // 收回抽屉
    [self genieToRect:self.leftButton.frame edge:BCRectEdgeRight];
    
    // 如果namelabel 不为空 就显示气泡图片
    if ([self.namelabel.text isEqualToString:@""]) {
        
        self.bubbleimage.hidden = YES;
        
    }
    else
    {
        self.bubbleimage.hidden = NO;
    }
    
    ScheduleHelper *s = [ScheduleHelper sharedDatamanager];
    
    _schedule = s.scheduleArray[self.num];
    
    // 保存namelabel 给 content
    _schedule.content = self.addTextField.text;

    
    
    NSError *error = nil;
    
    
    [s.appDelegate.managedObjectContext save:&error];

    
}




// 点击按钮 弹出左抽屉
- (IBAction)leftButtonAction:(UIButton *)sender {
    

    // 弹出 / 收起抽屉方法
    [self genieToRect:sender.frame edge:BCRectEdgeRight];

    
}

// 弹出/收起 抽屉
- (void) genieToRect: (CGRect)rect edge: (BCRectEdge) edge
{
    
    
    CGRect endRect = CGRectInset(rect,self.leftButton.frame.size.width / 2 - 1,self.leftButton.frame.size.height / 2 - 1);
    
    
    if (self.viewIsIn) {
        
        
        
        // 抽屉收起
        
        [self.leftBox genieInTransitionWithDuration:0.8 destinationRect:endRect destinationEdge:edge completion:
         ^{

             
             // 把文本框内容给cell

             self.namelabel.text = self.addTextField.text;
             
             [self.buttons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
                 
                 button.enabled = YES;
                 
                 
             }];
         }];
        
        
        
    }
    else
    {
        // 把cell内容给文本框

        self.addTextField.text = self.namelabel.text;
        
        
        
        // 抽屉弹出
        // box一直存在,以前隐藏了 现在再显示
        self.leftBox.hidden = NO;
        
        [self.leftBox genieOutTransitionWithDuration:0.8 startRect:endRect startEdge:edge completion:^{
            [self.buttons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
                button.enabled = YES;
                
                
                
            }];
        }];
    }
    
    self.viewIsIn = ! self.viewIsIn;
    

    
}



#pragma mark schedule 的 setter方法
- (void)setSchedule:(Schedule *)schedule
{
    self.namelabel.text = schedule.content;
    
    NSNumber *num = [NSNumber numberWithInt:1];


    
    if ([schedule.isClock isEqualToNumber:num]) {

        self.clockSwitch.on = YES;
    }
    else
    {
        
        self.clockSwitch.on = NO;
    }
    
    
    
    
}





- (void)awakeFromNib {

    // 设置leftBox首先隐藏
    self.leftBox.hidden = YES;
    
    // 将气泡图片 隐藏 当没有文字时(没有添加日程)
    self.bubbleimage.hidden = YES;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end
