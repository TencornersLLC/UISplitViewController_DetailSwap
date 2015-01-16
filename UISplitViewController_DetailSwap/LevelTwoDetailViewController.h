//
//  LevelTwoDetailViewController.h
//  UISplitViewController_DetailSwap
//
//  Created by Travis Kent Beste on 1/15/15.
//  Copyright (c) 2015 Tencorners, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LevelOneMasterTableViewController.h"

@interface LevelTwoDetailViewController : UIViewController <SubstitutableDetailViewController> {
}

@property (retain, nonatomic) IBOutlet UIToolbar *toolbar;

@end
