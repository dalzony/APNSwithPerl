//
//  PushNotiAppDelegate.h
//  PushPush
//
//  Created by Minsun Lee on 12. 10. 13..
//  Copyright (c) 2012년 Mintegrals. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PushListViewController.h"

@interface PushNotiAppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate> {
    NSMutableArray* pushList;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) PushListViewController* viewController;
@property (nonatomic, assign) NSMutableArray* pushList;

@end
