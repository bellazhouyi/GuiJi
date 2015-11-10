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

#pragma mark 根据指定的时间返回特定的地点信息
-(MapInfo *)gainMapInfoFromCoreDataBySpecifiedHour:(NSInteger)hour{
    
    // 从CoreData中取出数据
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MapInfo" inManagedObjectContext:self.appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    
    //得到所有的MapInfo
    NSArray *fetchedObjects = [self.appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
   
    //获取根据自己规定的整点得到时间
    NSDate *specifiedTime = [self getCustomDateWithHour:hour];
    
    //得到指定时间的偏移量
    double specifiedOffset = [self calculateOffsetFromSpecifiedTime:specifiedTime];
    MapInfo *resultMapInfo ;
    
    //遍历，比较时间，得到具体信息
    for (MapInfo *mapInfo in fetchedObjects) {
        double mapInfoOffset = [self calculateOffsetFromSpecifiedTime:[mapInfo time]];
        //比较两个时间的偏移量
        if ((int)specifiedOffset - (int)mapInfoOffset == 0) {
            resultMapInfo = mapInfo;
            break;
        }
        
    }
    
        
    //返回最终的MapInfo信息
    return resultMapInfo;

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
    [resultComps setMinute:9];
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



-(AppDelegate *)appDelegate{
    if (!_appDelegate) {
        _appDelegate = [UIApplication sharedApplication].delegate;
    }
    return _appDelegate;
}

@end
