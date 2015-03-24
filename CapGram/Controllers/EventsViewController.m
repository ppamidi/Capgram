//
//  EventsViewController.m
//  CapGram
//
//  Created by Prasad Pamidi on 9/8/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "EventsViewController.h"
#import "EventTableViewCell.h"
#import "DateHelper.h"
#import "NoNetworkTableViewCell.h"
#import "Networking.h"
#import "FetchingFeedTableViewCell.h"

@interface EventsViewController ()
@property (nonatomic, strong) NSMutableArray *eventObjects;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation EventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _eventObjects = [NSMutableArray array];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.145 green:0.584 blue:0.831 alpha:1]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"ArialRoundedMTBold" size:21],
      NSFontAttributeName,  [UIColor whiteColor],NSForegroundColorAttributeName, [UIColor whiteColor],NSBackgroundColorAttributeName, nil]];
    
    [self.navigationController.navigationBar setTranslucent: NO];
}

- (void) viewWillAppear:(BOOL)animated {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Events"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"%@", objects);
            [_eventObjects addObjectsFromArray:objects];
            
            [self.tableView reloadData];
        }
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    if (_eventObjects.count > 0) {
        return _eventObjects.count;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_eventObjects.count > 0) {
        static NSString *cellIdentifier = @"event_cell";
        
        EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil) {
            cell = [[EventTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        PFObject *eventObject = [_eventObjects objectAtIndex:indexPath.row];
        
        cell.date.text = [DateHelper stringFromDateFormat2:[DateHelper dateFromStringFormat1:[eventObject objectForKey:@"DateTime"]]];
        cell.title.text = [NSString stringWithFormat:@"%@", [eventObject objectForKey:@"Description"]];
        cell.location.text = [eventObject objectForKey:@"LocationText"];
        
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
