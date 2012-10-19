//
//  PushNotiAppDelegate.m
//  PushPush
//
//  Created by Minsun Lee on 12. 10. 13..
//  Copyright (c) 2012년 Mintegrals. All rights reserved.
//

#import "PushNotiAppDelegate.h"

@implementation PushNotiAppDelegate
@synthesize viewController;

- (void)dealloc
{
    [viewController release];
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.viewController = [[[NotiListViewController alloc]initWithNibName:@"NotiListViewController" bundle:nil] autorelease];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
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
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//push

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //설정 관련
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    //배지 개수 재설정
    application.applicationIconBadgeNumber = 0;
    NSLog(@"성공인가? ");
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //토큰을 서버로 전송
    NSMutableString *deviceId = [NSMutableString string];
    const unsigned char* ptr = (const unsigned char*) [deviceToken bytes];
    for(int i = 0 ; i < 32 ; i++) {
        [deviceId appendFormat:@"%02x", ptr[i]];
    }
    NSLog(@"APNS Device Token : %@", deviceId);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //토큰 전송 실패
    NSLog(@"Failed to register, error: %@",error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    //다른일 수행중일떄 받을 수 있음
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *msg = [NSString stringWithFormat:@"%@", [aps objectForKey:@"alert"]];
	NSLog(@"PUSH 메세지 : %@", msg);
    UIAlertView *pushAlert = [[UIAlertView alloc] initWithTitle:@"알 림"
                                                        message:msg
                                                       delegate:nil
                                              cancelButtonTitle:@"O K"
                                              otherButtonTitles:nil];
    [pushAlert show];
    [pushAlert release];
}

@end
