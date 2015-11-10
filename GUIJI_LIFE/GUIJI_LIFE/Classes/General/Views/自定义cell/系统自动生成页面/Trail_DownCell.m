//
//  Trail_DownCell.m
//  GUIJI_LIFE
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 周屹. All rights reserved.
//

#import "Trail_DownCell.h"

@implementation Trail_DownCell

#pragma mark - 视图加载完成
- (void)awakeFromNib {
    
    // 创建imageView
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.DownLabel.bounds];
    // 给imageView 添加图片
    [imageView setImage:[UIImage imageNamed:@""]];
    // 将imageView 添加到DownLabel上
    [self.DownLabel addSubview:imageView];
    // 将imageView 交互开启
    imageView.userInteractionEnabled = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
