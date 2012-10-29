//
//  PushListViewController.h
//  PushPush
//
//  Created by Minsun Lee on 12. 10. 20..
//  Copyright (c) 2012년 Mintegrals. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PushListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray *pushList;
    UITableView* tableV;
}
@property (nonatomic, retain) IBOutlet UITableView *tableV;
@end
