//
//  LevelOneMasterTableViewController.m
//  UISplitViewController_DetailSwap
//
//  Created by Travis Kent Beste on 1/15/15.
//  Copyright (c) 2015 Tencorners, LLC. All rights reserved.
//

#import "LevelOneMasterTableViewController.h"
#import "LevelOneDetailViewController.h"

#import "LevelTwoMasterTableViewController.h"
#import "LevelTwoDetailViewController.h"

@interface LevelOneMasterTableViewController ()

@end

@implementation LevelOneMasterTableViewController

@synthesize popoverController;
@synthesize rootPopoverButtonItem;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // if account is adminstrative, show different
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:@"Decend To Level Two"];
    tableViewItemsArray = array;
    
    self.navigationItem.title = @"Level One";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backButtonAction {
    UIViewController <SubstitutableDetailViewController> *detailViewController = nil;
    UINavigationController *detailNavigationController = nil;
    
    //----------------------//
    // set the detail view
    //----------------------//
    LevelOneDetailViewController *detail = [[LevelOneDetailViewController alloc] initWithNibName:@"LevelOneDetailViewController" bundle:nil];
    detailViewController = detail;
    // need to assign our detail view controller to the tableViewController so that we can modify it based on selection
    //master.delegate = detail;
    // also add the splitViewController
    UINavigationController *newNavigationController = [[UINavigationController alloc] initWithRootViewController:detail];
    detailNavigationController = newNavigationController;
    
    
    // Update the split view controller's view controllers array.
    NSArray *viewControllers = [[NSArray alloc] initWithObjects:self.navigationController, detailViewController, nil];
    self.splitViewController.viewControllers = viewControllers;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [tableViewItemsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell...
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [tableViewItemsArray objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate
// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController <SubstitutableDetailViewController> *detailViewController = nil;
    UINavigationController *detailNavigationController = nil;
    
    if (indexPath.row == 0) {
        
        //----------------------//
        // set the master view
        //----------------------//
        LevelTwoMasterTableViewController *master = [[LevelTwoMasterTableViewController alloc] initWithNibName:@"LevelTwoMasterTableViewController" bundle:nil];
        master.popoverController = self.popoverController;
        master.rootPopoverButtonItem = self.rootPopoverButtonItem;
        master.backDelegate = self;
        
        //NSLog(@"Activities rowselect : %@", master.popoverController);
        //NSLog(@"Activities rowselect : %@", master.rootPopoverButtonItem);
        
        //----------------------//
        // set the detail view
        //----------------------//
        LevelTwoDetailViewController *detail = [[LevelTwoDetailViewController alloc] initWithNibName:@"LevelTwoDetailViewController" bundle:nil];
        detailViewController = detail;
        // need to assign our detail view controller to the tableViewController so that we can modify it based on selection
        //master.delegate = detail;
        // also add the splitViewController
        UINavigationController *newNavigationController = [[UINavigationController alloc] initWithRootViewController:detail];
        detailNavigationController = newNavigationController;
        
        // finally push on the nav controller
        [self.navigationController pushViewController:master animated:YES];
    }
    
    // Update the split view controller's view controllers array.
    NSArray *viewControllers = [[NSArray alloc] initWithObjects:self.navigationController, detailViewController, nil];
    self.splitViewController.viewControllers = viewControllers;
    
    // Dismiss the popover if it's present.
    if (popoverController != nil) {
        [popoverController dismissPopoverAnimated:YES];
    }
    
    // Configure the new view controller's popover button (after the view has been displayed and its toolbar/navigation bar has been created).
    if (rootPopoverButtonItem != nil) {
        [detailViewController showRootPopoverButtonItem:self.rootPopoverButtonItem];
    }
}

# pragma mark SplitViewController delegate functions
- (void)splitViewController:(UISplitViewController*)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem*)barButtonItem
       forPopoverController:(UIPopoverController*)pc {
    //NSLog(@"Master : willHideViewController");
    
    //NSLog(@"setting popover...");
    if ([[[self.splitViewController.viewControllers objectAtIndex:0] viewControllers] count] == 3) {
        //NSLog(@"setting pc/barButtonItem to detail ViewController...");
        
        //NSLog(@"What type are we? : %@", [[[self.splitViewController.viewControllers objectAtIndex:0] viewControllers] objectAtIndex:2]);
        [[[[self.splitViewController.viewControllers objectAtIndex:0] viewControllers] objectAtIndex:2] setPopoverController:pc];
        [[[[self.splitViewController.viewControllers objectAtIndex:0] viewControllers] objectAtIndex:2] setRootPopoverButtonItem:barButtonItem];
    } else if ([[[self.splitViewController.viewControllers objectAtIndex:0] viewControllers] count] == 2) {
        //NSLog(@"setting pc/barButtonItem to master ViewController...");
        [[[[self.splitViewController.viewControllers objectAtIndex:0] viewControllers] objectAtIndex:1] setPopoverController:pc];
        [[[[self.splitViewController.viewControllers objectAtIndex:0] viewControllers] objectAtIndex:1] setRootPopoverButtonItem:barButtonItem];
    } else {
        //NSLog(@"setting pc/barButtonItem to self...");
        self.popoverController = pc;
        self.rootPopoverButtonItem = barButtonItem;
    }
    
    //NSLog(@"setting barButtonItem");
    // detail view controller may be a tabbar so we need to set the item on the viewcontroller and the navigationcontroller (tabbarcontroller)
    UIViewController <SubstitutableDetailViewController> *detailViewController = [self.splitViewController.viewControllers objectAtIndex:1];
    //NSLog(@"detailViewController : %@", detailViewController);
    if (! [detailViewController isKindOfClass:[UITabBarController class]]) {
        [detailViewController showRootPopoverButtonItem:barButtonItem];
    }
    
}
- (void)splitViewController:(UISplitViewController*)svc
     willShowViewController:(UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    //NSLog(@"Master : willShowViewController");
    
    // Nil out references to the popover controller and the popover button, and tell the detail view controller to hide the button.
    UIViewController <SubstitutableDetailViewController> *detailViewController = [self.splitViewController.viewControllers objectAtIndex:1];
    if (! [detailViewController isKindOfClass:[UITabBarController class]]) {
        [detailViewController invalidateRootPopoverButtonItem:barButtonItem];
    }
    
    //NSLog(@"removing popover...");
    if ([[[self.splitViewController.viewControllers objectAtIndex:0] viewControllers] count] == 3) {
        //NSLog(@"setting Receiptss pc/barButtonItem to nil...");
        [[[[self.splitViewController.viewControllers objectAtIndex:0] viewControllers] objectAtIndex:2] setPopoverController:nil];
        [[[[self.splitViewController.viewControllers objectAtIndex:0] viewControllers] objectAtIndex:2] setRootPopoverButtonItem:nil];
    } else if ([[[self.splitViewController.viewControllers objectAtIndex:0] viewControllers] count] == 2) {
        //NSLog(@"setting Events pc/barButtonItem to nil...");
        [[[[self.splitViewController.viewControllers objectAtIndex:0] viewControllers] objectAtIndex:1] setPopoverController:nil];
        [[[[self.splitViewController.viewControllers objectAtIndex:0] viewControllers] objectAtIndex:1] setRootPopoverButtonItem:nil];
    } else {
        //NSLog(@"setting Activities pc/barButtonItem to nil...");
        self.popoverController = nil;
        self.rootPopoverButtonItem = nil;
    }
}
- (void)splitViewController:(UISplitViewController *)svc
          popoverController:(UIPopoverController *)pc
  willPresentViewController:(UIViewController *)aViewController {
    //NSLog(@"Master : willPresentViewController");
}

@end
