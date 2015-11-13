//
//  ScheduleHelper.m
//  GUIJI_LIFE
//
//  Created by 邢家赫 on 15/11/12.
//  Copyright © 2015年 周屹. All rights reserved.
//

#import "ScheduleHelper.h"

@interface ScheduleHelper ()

// 声明appdelegate属性
//@property (nonatomic,strong) AppDelegate *appDelegate;


@end


@implementation ScheduleHelper

#pragma mark 单例
+ (instancetype)sharedDatamanager
{
    static ScheduleHelper *scheduleHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scheduleHelper = [[ScheduleHelper alloc] init];
    });
    return scheduleHelper;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        // 给scheduleArray初值 直接存进数据库(10个model)
        _scheduleArray = [self gainAllData];
        
        NSLog(@"~~%@",_scheduleArray);
        
        if (_scheduleArray.count == 0)
        {
            
            BOOL clock = NO;
            
            for (int i = 6;  i < 26; i += 2) {
                

                
                [self saveDataWithHour:[NSNumber numberWithInt:i] content:@"" isClock:clock];
                
                clock = !clock;
                
             }

            
       }
        
        _scheduleArray = [self gainAllData];
        
        NSLog(@"---%@",_scheduleArray);
        
        
        
        
    }
    return self;
}


#pragma  mark - 存储模型
- (void)saveDataWithHour:(NSNumber *)hour content:(NSString *)content isClock:(BOOL)isColock
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Schedule" inManagedObjectContext:self.appDelegate.managedObjectContext] ;
    
    Schedule *schedule = [[Schedule alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.appDelegate.managedObjectContext];
    
    
    
    
    schedule.hour = hour;
    schedule.content = content;
    schedule.isClock = [NSNumber numberWithBool:isColock];
    
    
    // 保存并更新
    [self.appDelegate saveContext];
    
    
}

#pragma  mark 取所有数据

- (NSMutableArray *)gainAllData
{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Schedule" inManagedObjectContext:self.appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"<#format string#>", <#arguments#>];
//    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    
    // 根据小时排序
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"hour" ascending:YES];
    
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"数据为空");
    }
    else
    {
        [self.dataArray addObjectsFromArray:fetchedObjects];
    }
    
    NSLog(@"%@",_dataArray);
    
    return _dataArray;
    
    //return fetchedObjects;
}







#pragma mark 根据小时取数据
- (Schedule *)gainDataWithHour:(NSNumber *)hour
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Schedule" inManagedObjectContext:self.appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];

    // 根据小时取数据
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"hour = %@", hour];
    [fetchRequest setPredicate:predicate];
    
    
    // Specify how the fetched objects should be sorted
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"<#key#>"
//                                                                   ascending:YES];
//    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"数据为空");
    }
    
    // 取第一个元素
    return [fetchedObjects firstObject];
}

#pragma  mark - 更新数据库

- (void)updateDataWithSchedule:(Schedule *)schedule
{
    // 查找到要修改的学生
    
    // 保存一下操作
    NSError *error = nil;
    [self.appDelegate.managedObjectContext save:&error];

}

#pragma mark 返回所有数据
- (NSMutableArray *)scheduleArray
{
    return [_dataArray copy];
}


#pragma mark 懒加载
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


#pragma mark 懒加载
-(AppDelegate *)appDelegate{
    if (!_appDelegate) {
        _appDelegate = [UIApplication sharedApplication].delegate;
    }
    return _appDelegate;
}

@end
