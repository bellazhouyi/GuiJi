//
//  TrailHelper.h
//  GUIJI_LIFE
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 周屹. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *用于从数据库中取地图相关信息的工具
 **/
@interface TrailHelper : NSObject


#pragma mark 根据指定的时间返回特定的地点信息
-(MapInfo *)gainMapInfoFromCoreDataBySpecifiedHour:(NSInteger)hour;



@end
