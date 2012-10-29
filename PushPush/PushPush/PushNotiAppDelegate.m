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
@synthesize pushList;

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
    pushList = [[NSUserDefaults standardUserDefaults] objectForKey:@"push_list"];
    if ( !pushList )
        pushList = [[NSMutableArray alloc] init];
    self.viewController = [[[PushListViewController alloc]initWithNibName:@"PushListViewController" bundle:nil] autorelease];
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
    //확인했는지에 따라 숫자 조절
    application.applicationIconBadgeNumber = 0;
    NSLog(@"성공인가? ");
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //토큰을 서버로 전송
    NSLog(@"APNS Device Token : %@", [deviceToken description]);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //토큰 전송 실패
    NSLog(@"Failed to register, error: %@",error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    //다른일 수행중일떄 받을 수 있음
    
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *subject = [NSString stringWithFormat:@"%@", [aps objectForKey:@"alert"]];
    NSDictionary *link = [userInfo valueForKey:@"link"];
    NSDictionary* listDict = [NSDictionary dictionaryWithObjectsAndKeys:subject,@"subject",link,@"link", nil];
    [pushList addObject:listDict];
    NSLog(@"%@",listDict);  
    UIAlertView *pushAlert = [[UIAlertView alloc] initWithTitle:@"클량 실시간 베스트"
                                                        message:subject
                                                       delegate:self
                                              cancelButtonTitle:@"Cancle"
                                              otherButtonTitles:@"Open", nil];
    [pushAlert show];
    [pushAlert release];
    [[NSUserDefaults standardUserDefaults] setObject:pushList forKey:@"push_list"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

# pragma mark UIAlert Delegate
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex ==1){
        NSString *link;
        for (int ii=0; ii<[pushList count]; ii++) {
            NSString *subject = [[pushList objectAtIndex:ii] objectForKey:@"subject"];
            if ([[alertView message] isEqualToString:subject]) {
                link = [[pushList objectAtIndex:ii] objectForKey:@"link"];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:link]];
            }
        }
    }
}

@end
