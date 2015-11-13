//
//  ScheduleHelper.h
//  GUIJI_LIFE
//
//  Created by 邢家赫 on 15/11/12.
//  Copyright © 2015年 周屹. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
@interface ScheduleHelper : NSObject
// 从数据库中读取数据的数组
@property (nonatomic,strong) NSMutableArray *scheduleArray;

// 初始化 源数组
@property (nonatomic,strong) NSMutableArray *dataArray;

// 日程数据模型
//@property (nonatomic,strong) Schedule *schedule;

@property (nonatomic,strong) AppDelegate *appDelegate;


+ (instancetype)sharedDatamanager;

#pragma mark 初始化原数组
- (instancetype)init;


#pragma mark 保存数据
- (void)saveDataWithHour:(NSNumber *)hour content:(NSString *)content isClock:(BOOL)isColock;


@end
