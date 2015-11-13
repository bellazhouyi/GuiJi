//
//  Schedule+CoreDataProperties.h
//  GUIJI_LIFE
//
//  Created by 邢家赫 on 15/11/13.
//  Copyright © 2015年 周屹. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Schedule.h"

NS_ASSUME_NONNULL_BEGIN

@interface Schedule (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *content;
@property (nullable, nonatomic, retain) NSNumber *hour;
@property (nullable, nonatomic, retain) NSNumber *isClock;
@property (nullable, nonatomic, retain) NSNumber *minute;
@property (nullable, nonatomic, retain) NSNumber *isShow;
@property (nullable, nonatomic, retain) NSNumber *showBox;

@end

NS_ASSUME_NONNULL_END
