//
//  RostrDetailInfoViewController.h
//  CapGram
//
//  Created by Prasad Pamidi on 11/9/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface RostrDetailInfoViewController : UITableViewController

@property (nonatomic, strong) PFObject *rostrObject;

@end
