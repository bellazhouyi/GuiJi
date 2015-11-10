//
//  MyCell.m
//  te
//
//  Created by 邢家赫 on 15/11/9.
//  Copyright © 2015年 邢家赫. All rights reserved.
//

#import "MyCell.h"
#import "UIView+Genie.h"
#import <QuartzCore/QuartzCore.h>


@interface MyCell ()




// 视图是否收起
@property (nonatomic) BOOL viewIsIn;

@property (nonatomic,strong) NSArray *buttons;

@end


@implementation MyCell


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        self.leftButton.layer.masksToBounds = YES;
        self.leftButton.layer.cornerRadius = 10;
        
    }
    return self;
}


// 弹出左抽屉
- (IBAction)leftButtonAction:(UIButton *)sender {
    
    
    
    
    NSLog(@"aaaaaaaaaaaaaaaaaaaaaaa");
    
    // box一直存在,以前隐藏了 现在再显示
    self.leftBox.hidden = NO;
    
    [self genieToRect:sender.frame edge:BCRectEdgeRight];

    
}

// 弹出/收起 抽屉
- (void) genieToRect: (CGRect)rect edge: (BCRectEdge) edge
{
    
    //self.leftButton.frame.size.width / 2 , self.leftButton.frame.size.height / 2
        CGRect endRect = CGRectInset(rect,self.leftButton.frame.size.width / 2 - 1,self.leftButton.frame.size.height / 2 - 1);
    
    
    
    
    if (self.viewIsIn) {
        
        
        
        // 上抽屉
        
        [self.leftBox genieInTransitionWithDuration:0.8 destinationRect:endRect destinationEdge:edge completion:
         ^{
             // 上抽屉收回 毛玻璃隐藏
             //_visualView.hidden = YES;
             // 返回按钮显示
             //_backButton.hidden = NO;
             
             [self.buttons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
                 
                 button.enabled = YES;
                 
                 
             }];
         }];
        
        
        
    }
    else
    {  // 抽屉弹出
        
        
        // 返回按钮隐藏
        //_backButton.hidden = YES;
        
        // 毛玻璃显示
        //_visualView.hidden = NO;
        
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

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end
