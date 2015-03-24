//
//  RosterViewController.h
//  CapGram
//
//  Created by Prasad Pamidi on 9/8/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "RESideMenu.h"
#import "RostrSearchResultsBaseViewController.h"


@interface RosterViewController : RostrSearchResultsBaseViewController<RESideMenuDelegate, RostrViewProtocol>

@end
