//
//  LevelOneDetailViewController.m
//  UISplitViewController_DetailSwap
//
//  Created by Travis Kent Beste on 1/15/15.
//  Copyright (c) 2015 Tencorners, LLC. All rights reserved.
//

#import "LevelOneDetailViewController.h"

@interface LevelOneDetailViewController ()

@end

@implementation LevelOneDetailViewController

@synthesize toolbar;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma managing the popover
- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    //NSLog(@"%@ : showRootPopoverButtonItem", [self description]);
    
    // set the title
    barButtonItem.title = NSLocalizedString(@"Activities", @"Activities");
    
    // add the popover button to the toolbar.
    NSMutableArray *itemsArray = [self.toolbar.items mutableCopy];
    [itemsArray insertObject:barButtonItem atIndex:0];
    [self.toolbar setItems:itemsArray animated:NO];
}
- (void)invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    //NSLog(@"%@ : invalidateRootPopoverButtonItem", [self description]);
    
    // remove the popover button from the toolbar
    NSMutableArray *itemsArray = [self.toolbar.items mutableCopy];
    [itemsArray removeObject:barButtonItem];
    [self.toolbar setItems:itemsArray animated:NO];
}

@end
