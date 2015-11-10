//
//  AppDelegate.m
//  GUIJILIFE
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 周屹. All rights reserved.
//

#import "AppDelegate.h"

//引入地图框架
@import MapKit;

@interface AppDelegate ()<MKMapViewDelegate,CLLocationManagerDelegate>

//定义CLLocationManager属性
@property(nonatomic,strong) CLLocationManager *locationManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    //定义MKMapView视图
    MKMapView *mapView = [[MKMapView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    //初始化CLLocationManager属性
    self.locationManager = [[CLLocationManager alloc]init];
    
    //判断系统版本
    if ([[UIDevice currentDevice].systemVersion floatValue] > 8.0) {
        
        //设置授权方式
        [self.locationManager requestWhenInUseAuthorization];
        
        //用户是否允许位置访问
        [CLLocationManager locationServicesEnabled];
        
        //设置跟踪模式
        [mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
        
        //设置地图样式
        mapView.mapType = MKMapTypeStandard;
    }
    
    
    //打开地图的总开关
    mapView.showsUserLocation = YES;
    
    //添加到window上
    [self.window addSubview:mapView];
    
    //设置代理
    mapView.delegate = self;
    self.locationManager.delegate = self;
    
    //开启定位功能
    [self.locationManager startUpdatingLocation];
    
    //设置更新间距
    self.locationManager.distanceFilter = 100;
    
    
    return YES;
}



#pragma mark CLLocationManagerDelegate
//更新位置
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    //获取最新位置
    CLLocation *currentLocation = [locations lastObject];
  
    //根据最新位置,进行地理反编码
    CLGeocoder *gecoder = [CLGeocoder new];
    
    //声明block变量
    __block typeof(self) temp = self;
    
    [gecoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        //获取用户当前位置信息
        NSString *userLocationInfo = [[placemarks lastObject] name];
        
        //得到系统当地当前时间
        NSTimeZone *zone = [NSTimeZone localTimeZone];
        //时间戳
        NSInteger offset = [zone secondsFromGMT];
        //得出具体时间
        NSDate *userDate = [NSDate dateWithTimeIntervalSinceNow:offset];
       
        //存入数据库中
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"MapInfo" inManagedObjectContext:temp.managedObjectContext];
        
        MapInfo *mapInfo = [[MapInfo alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:temp.managedObjectContext];
        
        mapInfo.time = userDate;
        mapInfo.locationName = userLocationInfo;
        
        //保存更新
        [temp saveContext];
        
    }];
    
    
}





- (void)applicationWillResignActive:(UIApplication *)application {
  
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
   
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
   
}

- (void)applicationWillTerminate:(UIApplication *)application {
   
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "lanou.3g.com.GUIJILIFE" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"GUIJI_LIFE" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"GUIJILIFE.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
