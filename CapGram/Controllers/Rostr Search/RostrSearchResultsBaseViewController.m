//
//  RostrSearchResultsBaseViewController.m
//  CapGram
//
//  Created by Prasad Pamidi on 11/9/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "RostrSearchResultsBaseViewController.h"
#import "RosterTableViewCell.h"
#import "RostrDetailInfoViewController.h"

@interface RostrSearchResultsBaseViewController()

@end
@implementation RostrSearchResultsBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}



#pragma mark - Property Overrides

- (void)setFilterString:(NSString *)filterString {
    _filterString = filterString;
    
    if ((!filterString || filterString.length <= 0) && self.allResults.count > 0) {
        self.visibleResults = self.allResults;
    }
    else {
        NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"(lastName contains[c] %@) OR (firstName contains[c] %@) OR (contract contains[c] %@) OR (capability contains[c] %@) OR (title contains[c] %@) OR (role contains[c] %@)", filterString, filterString, filterString, filterString, filterString, filterString];
        self.visibleResults = [self.allResults filteredArrayUsingPredicate:filterPredicate];
    }
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.visibleResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"rostr_search_cell";
    
    RosterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[RosterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    PFObject *rostrObject = [_visibleResults objectAtIndex:indexPath.row];
    
    NSLog(@"Rostr object %@", rostrObject);
    
    cell.type.text = [[rostrObject objectForKey:@"type"] stringByTrimmingCharactersInSet:[NSCharacterSet symbolCharacterSet]];
    cell.name.text = [NSString stringWithFormat:@"%@ %@", [rostrObject objectForKey:@"firstName"],[rostrObject objectForKey:@"lastName"]];
    cell.title.text = [NSString stringWithFormat:@"%@ | %@", [rostrObject objectForKey:@"title"],[rostrObject objectForKey:@"contract"]];
    cell.location.text = [[rostrObject objectForKey:@"location"] stringByTrimmingCharactersInSet:[NSCharacterSet symbolCharacterSet]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [_delegate selectedObject:[_visibleResults objectAtIndex:indexPath.row]];
}

@end
