//
//  AppDelegate.m
//  Febo
//
//  Created by Andrew on 14-10-20.
//  Copyright (c) 2014年 ckdai. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "SearchViewController.h"
#import "UserCenterViewController.h"

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

@synthesize rootNaVC;
@synthesize accessToken;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    MessageViewController *messageVC = [[MessageViewController alloc] init];
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    UserCenterViewController *userCenterVC = [[UserCenterViewController alloc] init];
    homeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"tabbar_home"] tag:0];
    messageVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"消息" image:[UIImage imageNamed:@"tabbar_message"] tag:1];
    searchVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:[UIImage imageNamed:@"tabbar_search"] tag:2];
    userCenterVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"tabbar_usercenter"] tag:3];
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    [tabBarVC setViewControllers:[NSArray arrayWithObjects:homeVC, messageVC, searchVC, userCenterVC, nil]];
    rootNaVC = [[UINavigationController alloc] initWithRootViewController:tabBarVC];
    self.window.rootViewController = rootNaVC;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    //新浪微博注册
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:WeiboAppKey];
    
    NSDate *currentDate = [NSDate date];
    NSDate *expirationDate = [[[NSUserDefaults standardUserDefaults] objectForKey:@"WeiboAuthInfo"] objectForKey:@"expirationDate"];
    
    if ([expirationDate compare:currentDate] == NSOrderedDescending) {
        NSLog(@"还没过期");
        accessToken = [[[NSUserDefaults standardUserDefaults] objectForKey:@"WeiboAuthInfo"] objectForKey:@"accessToken"];
    }
    else {
        WBAuthorizeRequest *request = [WBAuthorizeRequest request];
        request.redirectURI = WeiboRedirectURL;
        request.scope = @"all";
        [WeiboSDK sendRequest:request];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Febo" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Febo.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark 新浪微博回调
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

#pragma mark 微博delegate
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    NSLog(@"%@", request);
}

/**
 收到一个来自微博客户端程序的响应
 
 收到微博的响应后，第三方应用可以通过响应类型、响应的数据和 WBBaseResponse.userInfo 中的数据完成自己的功能
 @param response 具体的响应对象
 */
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    WBAuthorizeResponse *_WBAuthorizeResponse = (WBAuthorizeResponse *)response;
    NSLog(@"%@", response);
    accessToken = _WBAuthorizeResponse.accessToken;
    NSDictionary *authInfo = [NSDictionary dictionaryWithObjects:@[_WBAuthorizeResponse.accessToken, _WBAuthorizeResponse.expirationDate] forKeys:@[@"accessToken", @"expirationDate"]];
    [[NSUserDefaults standardUserDefaults] setObject:authInfo forKey:@"WeiboAuthInfo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
