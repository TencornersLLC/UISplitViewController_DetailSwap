//
//  LevelTwoMasterTableViewController.h
//  UISplitViewController_DetailSwap
//
//  Created by Travis Kent Beste on 1/15/15.
//  Copyright (c) 2015 Tencorners, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LevelOneMasterTableViewController.h"

@interface LevelTwoMasterTableViewController : UITableViewController {
    NSArray *tableViewItemsArray;
}

@property (nonatomic, retain) id <LevelTwoMasterTableViewControllerBackDelegate> backDelegate;

@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) UIBarButtonItem *rootPopoverButtonItem;

@end
