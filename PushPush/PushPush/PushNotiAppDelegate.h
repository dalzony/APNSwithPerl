//
//  PushNotiAppDelegate.h
//  PushPush
//
//  Created by Minsun Lee on 12. 10. 13..
//  Copyright (c) 2012년 Mintegrals. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotiListViewController.h"

@interface PushNotiAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) NotiListViewController* viewController;

@end
