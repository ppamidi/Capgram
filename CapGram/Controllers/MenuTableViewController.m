//
//  MenuTableViewController.m
//  CapGram
//
//  Created by Prasad Pamidi on 9/2/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "MenuTableViewController.h"
#import "NewsViewController.h"
#import "EventsViewController.h"
#import "RosterViewController.h"
#import "UIViewController+RESideMenu.h"
#import "YMLoginController.h"
#import "YMConstants.h"

@interface MenuTableViewController ()

@property (strong, readwrite, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSString *authToken;

@end

@implementation MenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 70 * 5) / 2.0f, self.view.frame.size.width, 70 * 5) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView.scrollsToTop = NO;
        tableView;
    });
    
    [self.view addSubview:self.tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateContentView) name:YMYammerSDKLoginDidCompleteNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateContentView) name:YMYammerSDKLoginDidFailNotification object:nil];
        
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateContentView) name:YMYammerSDKLogoutDidCompleteNotification object:nil];
    
}

- (void) updateContentView {

    [self.tableView reloadData];
    
    if (!_authToken) {
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:1 inSection:1];
        
        [self.tableView selectRowAtIndexPath:indexpath animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    _authToken = [[YMLoginController sharedInstance] storedAuthToken];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_authToken) {
        switch (indexPath.row) {
            case 0:
                [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"NewsViewController"]]
                                                             animated:YES];
                [self.sideMenuViewController hideMenuViewController];
                break;
            case 1:
                [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"EventsViewController"]]
                                                             animated:YES];
                [self.sideMenuViewController hideMenuViewController];
                break;
            case 2:
                [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"RosterViewController"]]
                                                             animated:YES];
                [self.sideMenuViewController hideMenuViewController];
                break;
            case 3:
                [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileTableViewController"]]
                                                             animated:YES];
                [self.sideMenuViewController hideMenuViewController];
                break;
            case 4:
                [[YMLoginController sharedInstance] clearAuthToken];
                break;
    
            default:
                break;

        }
    }
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
     if (_authToken) {
         return 5;

     }
     else {
         return 0;
     }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:21];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    
    if (_authToken) {
        NSArray *titles = @[@"News", @"Events", @"Roster", @"Profile", @"Log Out"];
        NSArray *images = @[@"News", @"Calendar", @"Rostr", @"Settings", @"Logout"];
        
        cell.textLabel.text = titles[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    }
    
    return cell;
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
