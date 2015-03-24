//
//  RostrSearchResultsBaseViewController.h
//  CapGram
//
//  Created by Prasad Pamidi on 11/9/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

@import UIKit;
#import <Parse/Parse.h>

@protocol RostrViewProtocol <NSObject>
- (void) selectedObject:(PFObject *) rostrObject;

@end

@interface RostrSearchResultsBaseViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *allResults;
@property (nonatomic, copy) NSString *filterString;
@property (readwrite, copy) NSArray *visibleResults;
@property (nonatomic, assign) id <RostrViewProtocol> delegate;
@end
