//
//  ProfileTableViewController.m
//  CapGram
//
//  Created by Prasad Pamidi on 11/9/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "ProfileTableViewController.h"
#import "Constants.h"
#import "ProfileEditTableViewController.h"
#import "Networking.h"

@interface ProfileTableViewController ()

@property (nonatomic, strong) PFObject *rostrObject;

@property (weak, nonatomic) IBOutlet UILabel *firstName;
@property (weak, nonatomic) IBOutlet UILabel *lastName;
@property (weak, nonatomic) IBOutlet UILabel *mobileNo;
@property (weak, nonatomic) IBOutlet UILabel *emailId;
@property (weak, nonatomic) IBOutlet UILabel *location;

@property (weak, nonatomic) IBOutlet UILabel *upn;
@property (weak, nonatomic) IBOutlet UILabel *userId;
@property (weak, nonatomic) IBOutlet UILabel *startDate;
@property (weak, nonatomic) IBOutlet UILabel *clientID;
@property (weak, nonatomic) IBOutlet UILabel *clientEmailId;
@property (weak, nonatomic) IBOutlet UILabel *cubicle;

@property (weak, nonatomic) IBOutlet UILabel *citizenship;
@property (weak, nonatomic) IBOutlet UILabel *visaType;
@property (weak, nonatomic) IBOutlet UILabel *visaIssuesCountry;
@property (weak, nonatomic) IBOutlet UILabel *visaExpiration;

@end

@implementation ProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.145 green:0.584 blue:0.831 alpha:1]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"ArialRoundedMTBold" size:21],
      NSFontAttributeName,  [UIColor whiteColor],NSForegroundColorAttributeName, [UIColor whiteColor],NSBackgroundColorAttributeName, nil]];
    
    [self.navigationController.navigationBar setTranslucent: NO];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString *email = [[[NSUserDefaults standardUserDefaults] objectForKey:kCapGramUserProfileInfo] objectForKey:@"email"];
    
    if (email) {
        
        if ([Networking networkStatus] == NetworkReachable) {
            PFQuery *query = [PFQuery queryWithClassName:@"Roster"];
            [query whereKey:@"emailAddress" equalTo:email];
            
            [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
                if (!object) {
                    [[[UIAlertView alloc] initWithTitle:@"Profile Unavailable" message:@"Unable to find a profile. Please update the information." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
                    
                } else {
                    
                    _rostrObject =  object;
                    
                    //personal information
                    _firstName.text = [_rostrObject objectForKey:@"firstName"]? [_rostrObject objectForKey:@"firstName"]:@"N/A";
                    _lastName.text = [_rostrObject objectForKey:@"lastName"]? [_rostrObject objectForKey:@"lastName"]:@"N/A";;
                    _mobileNo.text = [_rostrObject objectForKey:@"mobilePhone"]? [_rostrObject objectForKey:@"mobilePhone"]:@"N/A";
                    _emailId.text = [_rostrObject objectForKey:@"emailAddress"]? [_rostrObject objectForKey:@"emailAddress"]:@"N/A";
                    _location.text = [_rostrObject objectForKey:@"location"]? [_rostrObject objectForKey:@"location"]:@"N/A";
                    
                    //capgemini information
                    _upn.text = [_rostrObject objectForKey:@"upn"]? [_rostrObject objectForKey:@"upn"]:@"N/A";
                    _startDate.text =  [_rostrObject objectForKey:@"companyStartDate"]? [_rostrObject objectForKey:@"companyStartDate"] :@"N/A";
                    _userId.text = [_rostrObject objectForKey:@"userId"]? [_rostrObject objectForKey:@"userId"]:@"N/A";
                    
                    //client information
                    _clientEmailId.text = [_rostrObject objectForKey:@"clientEmail"]? [_rostrObject objectForKey:@"clientEmail"]:@"N/A";
                    _clientID.text = [_rostrObject objectForKey:@"clientUserID"]? [_rostrObject objectForKey:@"clientUserID"]:@"N/A";
                    _cubicle.text = [_rostrObject objectForKey:@"cubicle"]? [_rostrObject objectForKey:@"cubicle"] : @"N/A";
                    
                    //immigration information
                    _citizenship.text =  [_rostrObject objectForKey:@"citizenship"]? [_rostrObject objectForKey:@"citizenship"]:@"N/A";
                    _visaType.text = [_rostrObject objectForKey:@"visaType"]? [_rostrObject objectForKey:@"visaType"]:@"N/A";
                    _visaIssuesCountry.text = [_rostrObject objectForKey:@"visaCountry"]? [_rostrObject objectForKey:@"visaCountry"]:@"N/A";
                    _visaExpiration.text = [_rostrObject objectForKey:@"visaExpiration"]? [_rostrObject objectForKey:@"visaExpiration"]:@"N/A";
                }
            }];
        }else {
            [[[UIAlertView alloc] initWithTitle:@"Network Error" message:@"Unable to fetch profile. Please check WiFi settings." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
        }
        
    }else {
        [[[UIAlertView alloc] initWithTitle:@"Profile Unavailable" message:@"Unable to find a profile. Please update the information." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editProfile:(id)sender {
    
    if ([Networking networkStatus] == NetworkReachable) {
        ProfileEditTableViewController *profileVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileEditTableViewController"];
        
        profileVC.rostrObject = _rostrObject;
        
        [self.navigationController showViewController:profileVC sender:self];
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
