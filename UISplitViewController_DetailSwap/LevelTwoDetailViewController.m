//
//  LevelTwoDetailViewController.m
//  UISplitViewController_DetailSwap
//
//  Created by Travis Kent Beste on 1/15/15.
//  Copyright (c) 2015 Tencorners, LLC. All rights reserved.
//

#import "LevelTwoDetailViewController.h"

@interface LevelTwoDetailViewController ()

@end

@implementation LevelTwoDetailViewController

@synthesize toolbar;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Managing the popover
- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    //NSLog(@"%@ : showRootPopoverButtonItem", [self description]);
    
    // set the title
    barButtonItem.title = NSLocalizedString(@"Events", @"Events");
    
    // add the popover button to the toolbar.
    NSMutableArray *itemsArray = [self.toolbar.items mutableCopy];
    [itemsArray insertObject:barButtonItem atIndex:0];
    [self.toolbar setItems:itemsArray animated:NO];
}
- (void)invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    //NSLog(@"%@ : invalidateRootPopoverButton", [self description]);
    
    // remove the popover button from the toolbar
    NSMutableArray *itemsArray = [self.toolbar.items mutableCopy];
    [itemsArray removeObject:barButtonItem];
    [self.toolbar setItems:itemsArray animated:NO];
}

@end
