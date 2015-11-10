//
//  MapInfo+CoreDataProperties.h
//  GUIJI_LIFE
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 周屹. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MapInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface MapInfo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *time;
@property (nullable, nonatomic, retain) NSString *locationName;


@end

NS_ASSUME_NONNULL_END
