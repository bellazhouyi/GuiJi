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

}


// 添加完成
- (IBAction)addDownAction:(UIButton *)sender {
    
    // 文本框内容给 cell
    self.namelabel.text = self.addTextField.text;
    // 如果namelabel 不为空 就显示气泡图片
    if ([self.namelabel.text isEqualToString:@""]) {
        
        self.bubbleimage.hidden = YES;
        
    }
    else
    {
        self.bubbleimage.hidden = NO;
    }
    
    // 收回抽屉
    [self genieToRect:self.leftButton.frame edge:BCRectEdgeRight];
    
}




// 弹出左抽屉
- (IBAction)leftButtonAction:(UIButton *)sender {
    
    
    NSLog(@"aaaaaaaaaaa");
    
    

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
