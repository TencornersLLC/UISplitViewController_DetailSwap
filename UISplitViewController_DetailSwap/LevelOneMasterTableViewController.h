//
//  LevelOneMasterTableViewController.h
//  UISplitViewController_DetailSwap
//
//  Created by Travis Kent Beste on 1/15/15.
//  Copyright (c) 2015 Tencorners, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LevelTwoMasterTableViewControllerBackDelegate.h"

/*
 SubstitutableDetailViewController defines the protocol that detail view controllers must adopt.
 The protocol specifies methods to hide and show the bar button item controlling the popover.
 */
@protocol SubstitutableDetailViewController
- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem;
- (void)invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem;
@end

@interface LevelOneMasterTableViewController : UITableViewController <UISplitViewControllerDelegate, LevelTwoMasterTableViewControllerBackDelegate> {
    NSArray *tableViewItemsArray;
}

@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) UIBarButtonItem *rootPopoverButtonItem;

@end
