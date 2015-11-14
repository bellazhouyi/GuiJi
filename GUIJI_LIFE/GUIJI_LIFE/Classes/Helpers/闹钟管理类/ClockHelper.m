//
//  ClockHelper.m
//  闹钟测试
//
//  Created by lanou3g on 15/11/13.
//  Copyright © 2015年 胡保轩. All rights reserved.
//

#import "ClockHelper.h"

@implementation ClockHelper


#pragma mark - 私有方法
#pragma mark 添加本地通知
- (void)addLocalNotificationWithTime:(NSString *)time
                             content:(NSString *)content
{
    
    //定义本地通知对象
    UILocalNotification *notification=[[UILocalNotification alloc]init];
    
    
    NSDate *currentDate  = [self getCustomDateWithHour:[time integerValue]];
    
    
    //设置调用时间
    notification.fireDate=currentDate;//通知触发的时间，10s以后
    notification.repeatInterval=2;//通知重复次数
    notification.timeZone=[NSTimeZone defaultTimeZone];
    //notification.repeatCalendar=[NSCalendar currentCalendar];//当前日历，使用前最好设置时区等信息以便能够自动同步时间
    
    //设置通知属性
    notification.alertBody=content; //通知主体
    notification.applicationIconBadgeNumber=0;//应用程序图标右上角显示的消息数
    notification.alertAction=@"打开应用"; //待机界面的滑动动作提示
    notification.alertLaunchImage=@"Default";//通过点击通知打开应用时的启动图片,这里使用程序启动图片
    //notification.soundName=UILocalNotificationDefaultSoundName;//收到通知时播放的声音，默认消息声音
    notification.soundName=@"msg.caf";//通知声音（需要真机才能听到声音）
    
    //设置用户信息
    notification.userInfo=@{@"id":@1,@"user":@"hhhhhhhhh"};//绑定到通知上的其他附加信息

    //调用通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
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
    [resultComps setMinute:29];
    [resultComps setSecond:00];
    
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    return [resultCalendar dateFromComponents:resultComps];
}


#pragma mark 移除本地通知，在不需要此通知时记得移除
-(void)removeNotification{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}




@end
