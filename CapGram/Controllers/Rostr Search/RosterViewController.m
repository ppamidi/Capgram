//
//  RosterViewController.m
//  CapGram
//
//  Created by Prasad Pamidi on 9/8/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "RosterViewController.h"
#import "RostrSearchResultsViewController.h"
#import "RostrDetailInfoViewController.h"
#import "RosterTableViewCell.h"
#import "NoNetworkTableViewCell.h"
#import "Networking.h"
#import "FetchingFeedTableViewCell.h"

@interface RosterViewController ()
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray *rostrObjects;

@end

@implementation RosterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _rostrObjects = [NSMutableArray array];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.145 green:0.584 blue:0.831 alpha:1]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"ArialRoundedMTBold" size:21],
      NSFontAttributeName,  [UIColor whiteColor],NSForegroundColorAttributeName, [UIColor whiteColor],NSBackgroundColorAttributeName, nil]];
    
    [self.navigationController.navigationBar setTranslucent: NO];
    
    RostrSearchResultsViewController *searchResultsController = [self.storyboard instantiateViewControllerWithIdentifier:@"RostrSearchResultsViewController"];
    
    searchResultsController.delegate = self;

    
    PFQuery *query = [PFQuery queryWithClassName:@"Roster"];
    [query setLimit:1000];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultsController];
    
    self.searchController.searchBar.barTintColor = [UIColor colorWithRed:0.145 green:0.584 blue:0.831 alpha:1];
    self.searchController.searchResultsUpdater = searchResultsController;
    
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            [_rostrObjects addObjectsFromArray:objects];
            
            searchResultsController.allResults =  _rostrObjects;
            searchResultsController.visibleResults = searchResultsController.allResults;
            [searchResultsController.tableView reloadData];
            
            [self.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.rostrObjects.count > 0) {
        return self.rostrObjects.count;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.rostrObjects.count > 0) {
        static NSString *cellIdentifier = @"rostr_search_cell";
        
        RosterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil) {
            cell = [[RosterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        PFObject *rostrObject = [_rostrObjects objectAtIndex:indexPath.row];
        
        NSLog(@"Rostr object %@", rostrObject);
        
        cell.type.text = [[rostrObject objectForKey:@"type"] stringByTrimmingCharactersInSet:[NSCharacterSet symbolCharacterSet]];
        cell.name.text = [NSString stringWithFormat:@"%@ %@", [rostrObject objectForKey:@"firstName"],[rostrObject objectForKey:@"lastName"]];
        cell.title.text = [NSString stringWithFormat:@"%@ | %@", [rostrObject objectForKey:@"title"],[rostrObject objectForKey:@"contract"]];
        cell.location.text = [[rostrObject objectForKey:@"location"] stringByTrimmingCharactersInSet:[NSCharacterSet symbolCharacterSet]];
        
        return cell;
    }else {
        
        if ([Networking networkStatus] != NetworkReachable) {
            static NSString *cellIdentifier = @"no_network_cell";
            
            NoNetworkTableViewCell *cell = (NoNetworkTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (cell == nil) {
                cell = [[NoNetworkTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            
            return cell;
        }else {
            static NSString *cellIdentifier = @"fetch_feed_cell";
            
            FetchingFeedTableViewCell *cell = (FetchingFeedTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (cell == nil) {
                cell = [[FetchingFeedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_rostrObjects.count > 0) {
        RostrDetailInfoViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RostrDetailInfoViewController"];
        
        detailVC.rostrObject = [_rostrObjects objectAtIndex:indexPath.row];
        
        [self.navigationController showViewController:detailVC sender:self];

    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)searchButtonClicked:(UIBarButtonItem *)sender {
    
    // Present the view controller.
    [self presentViewController:self.searchController animated:YES completion:nil];

}

- (void) selectedObject:(PFObject *) rostrObject {
    
    if ([self.searchController isActive]) {
        [self.searchController setActive:NO];
       
        RostrDetailInfoViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RostrDetailInfoViewController"];
        
        detailVC.rostrObject = rostrObject;
        
        [self.navigationController showViewController:detailVC sender:self];
    }

}
@end
