//
//  HomeViewController.h
//  CapGram
//
//  Created by Prasad Pamidi on 9/6/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "RESideMenu.h"

@interface NewsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, RESideMenuDelegate>

@end
