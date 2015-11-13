//
//  ClockHelper.h
//  闹钟测试
//
//  Created by lanou3g on 15/11/13.
//  Copyright © 2015年 胡保轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@interface ClockHelper : NSObject


-(void)addLocalNotificationWithTime:(NSString *)time
                            content:(NSString *)content;


@end
