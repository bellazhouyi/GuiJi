//
//  TrailHelper.m
//  GUIJI_LIFE
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 周屹. All rights reserved.
//

#import "TrailHelper.h"

@interface TrailHelper ()

//声明AppDelegate实例
@property(nonatomic,strong) AppDelegate *appDelegate;


@end


@implementation TrailHelper

#pragma mark 存数据
-(void)saveMapInfoWithTime:(NSString *)time date:(NSString *)date andLocationName:(NSString *)locationName{
    
    //获得实体描述实例
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"MapInfo" inManagedObjectContext:self.appDelegate.managedObjectContext];
    
    //根据实体描述实例获得实体
    MapInfo *mapInfo = [[MapInfo alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.appDelegate.managedObjectContext];
    
    //给数据库实体的各个字段赋值
    mapInfo.time = time;
    mapInfo.date = date;
    mapInfo.locationName = locationName;
    
    //保存并更新
    [self.appDelegate saveContext];
    
    
}

/*
#pragma mark 判断当前系统时间和指定时间是否是一致的
-(BOOL)compareCurrentDate:(NSDate *)currentDate withSpecifiedDate:(NSInteger)hour{
    
    //算出当前时间的偏移量
    int currentDateOffset = (int)[self calculateOffsetFromSpecifiedTime:currentDate];
    
    //获取根据自己规定的整点得到时间
    NSDate *specifiedTime = [self getCustomDateWithHour:hour];
    
    //算出指定时间的偏移量
    int specifiedTimeOffset = (int)[self calculateOffsetFromSpecifiedTime:specifiedTime];
    
    if (currentDateOffset == specifiedTimeOffset) {
        return YES;
    }
    else{
        return NO;
    }
}

#pragma mark 生成当天的某个具体时间点
- (NSDate *)getCustomDateWithHour:(NSInteger)hour
{
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    currentComps = [currentCalendar components:unitFlags fromDate:currentDate];
    
    //设置当天的某个点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    [resultComps setMinute:24];
    [resultComps setSecond:0];
    
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    return [resultCalendar dateFromComponents:resultComps];
}

#pragma mark 根据当前时间算出距离某一个时间的偏移量
-(double)calculateOffsetFromSpecifiedTime:(NSDate *)currentDate{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // 设置时间格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    
    //设置时区 ＋8:00
    [dateFormatter setTimeZone:timeZone];
    
    // 设置过去的某个时间点比如:2015-10-01 00:00:00
    NSString  *someDayStr= @"2015-10-01 00:00:00";
    
    NSDate *someDayDate = [dateFormatter dateFromString:someDayStr];
    
    //当前时间距离2015-10-01 00:00:00的秒数
    NSTimeInterval time=[currentDate timeIntervalSinceDate:someDayDate];
    
    return time;
    
}

*/


#pragma mark 根据日期筛选数据
-(NSArray *)filterMapInfoDataByDate:(NSString *)date{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MapInfo" inManagedObjectContext:self.appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date = %@", date];
    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"time"
                                                                   ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"当前日期下没有相应的数据");
    }
    
    return fetchedObjects;
}


#pragma mark 返回数据库中的所有信息
-(NSArray *)gainAllMapInfoFromCoreData{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MapInfo" inManagedObjectContext:self.appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        
    }
    
    return fetchedObjects;
}



#pragma mark 返回所有数据
-(NSArray *)allMapInfo{
    return  [self gainAllMapInfoFromCoreData];
}


#pragma mark appDelegate懒加载
-(AppDelegate *)appDelegate{
    if (!_appDelegate) {
        _appDelegate = [UIApplication sharedApplication].delegate;
    }
    return _appDelegate;
}

@end
