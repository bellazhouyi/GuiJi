//
//  Trail_UpCell.m
//  GUIJI_LIFE
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 周屹. All rights reserved.
//

#import "Trail_UpCell.h"

@implementation Trail_UpCell

#pragma mark - 视图加载完成
- (void)awakeFromNib {
    
    // 创建imageView
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.UPLabel.bounds];
    // 给imageView 添加图片
    [imageView setImage:[UIImage imageNamed:@""]];
    // 把imageView 添加到UPlabel上面
    [self.UPLabel addSubview:imageView];
    // 开启imageView 的交互
    imageView.userInteractionEnabled = YES;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
