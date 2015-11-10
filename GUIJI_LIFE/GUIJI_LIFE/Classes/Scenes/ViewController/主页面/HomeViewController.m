//
//  HomeViewController.m
//  GUIJILIFE
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 周屹. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 跳转到TrailVC 界面
- (IBAction)toTrailVCAction:(UIButton *)sender {
    
    TrailViewController *trailVC = [TrailViewController new];
    
    //模态出TrailVC 界面
    [self presentViewController:trailVC animated:YES completion:nil];
    
}



@end
