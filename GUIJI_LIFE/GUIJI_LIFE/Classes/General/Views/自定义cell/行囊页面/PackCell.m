//
//  PackCell.m
//  GUIJI_LIFE
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 周屹. All rights reserved.
//

#import "PackCell.h"

@implementation PackCell

- (void)awakeFromNib {
    // Initialization code
    
    // 创建imageView
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.label.bounds];
    // 给imageView 添加图片
    [imageView setImage:[UIImage imageNamed:@""]];
    // 将imageView 添加到DownLabel上
    [self.label addSubview:imageView];
    // 将imageView 交互开启
    imageView.userInteractionEnabled = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
