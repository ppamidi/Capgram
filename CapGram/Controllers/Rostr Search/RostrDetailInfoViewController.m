//
//  RostrDetailInfoViewController.m
//  CapGram
//
//  Created by Prasad Pamidi on 11/9/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "RostrDetailInfoViewController.h"
#import "RostrDetailEditViewController.h"
#import "Constants.h"
#import "Networking.h"

@interface RostrDetailInfoViewController()

@property (weak, nonatomic) IBOutlet UILabel *firstName;
@property (weak, nonatomic) IBOutlet UILabel *lastName;
@property (weak, nonatomic) IBOutlet UILabel *jobTitle;
@property (weak, nonatomic) IBOutlet UILabel *mobileNo;
@property (weak, nonatomic) IBOutlet UILabel *compEmail;
@property (weak, nonatomic) IBOutlet UILabel *location;

@property (weak, nonatomic) IBOutlet UILabel *userId;
@property (weak, nonatomic) IBOutlet UILabel *upn;
@property (weak, nonatomic) IBOutlet UILabel *startDate;
@property (weak, nonatomic) IBOutlet UILabel *userType;
@property (weak, nonatomic) IBOutlet UILabel *userCapability;
@property (weak, nonatomic) IBOutlet UILabel *gradeBand;
@property (weak, nonatomic) IBOutlet UILabel *businessUnit;
@property (weak, nonatomic) IBOutlet UILabel *orgUnit;
@property (weak, nonatomic) IBOutlet UILabel *officeAddress;
@property (weak, nonatomic) IBOutlet UILabel *shore;
@property (weak, nonatomic) IBOutlet UILabel *status;

@property (weak, nonatomic) IBOutlet UILabel *account;
@property (weak, nonatomic) IBOutlet UILabel *contract;
@property (weak, nonatomic) IBOutlet UILabel *clientEmail;
@property (weak, nonatomic) IBOutlet UILabel *clientUserId;
@property (weak, nonatomic) IBOutlet UILabel *cubicle;
@property (weak, nonatomic) IBOutlet UILabel *reportingManger;
@property (weak, nonatomic) IBOutlet UILabel *clientLevel;
@property (weak, nonatomic) IBOutlet UILabel *clientManager;
@property (weak, nonatomic) IBOutlet UILabel *clientStartDate;
@property (weak, nonatomic) IBOutlet UILabel *role;
@property (weak, nonatomic) IBOutlet UILabel *contractEndDate;
@property (weak, nonatomic) IBOutlet UILabel *forecastEndDate;
@property (weak, nonatomic) IBOutlet UILabel *expense;

@property (weak, nonatomic) IBOutlet UILabel *citizenship;
@property (weak, nonatomic) IBOutlet UILabel *visaType;
@property (weak, nonatomic) IBOutlet UILabel *visaIssuedCountry;
@property (weak, nonatomic) IBOutlet UILabel *visaExpiration;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

@end
@implementation RostrDetailInfoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [_rostrObject objectForKey:@"firstName"]? [_rostrObject objectForKey:@"firstName"]:@"Details";
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.145 green:0.584 blue:0.831 alpha:1]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"ArialRoundedMTBold" size:21],
      NSFontAttributeName,  [UIColor whiteColor],NSForegroundColorAttributeName, [UIColor whiteColor],NSBackgroundColorAttributeName, nil]];
    
    [self.navigationController.navigationBar setTranslucent: NO];
    
    //manually including allowable roles for editing
     NSDictionary *allowableUserRoles = @{@"manager": @"Manager", @"seniormanager": @"Senior Manager", @"pmo": @"PMO",@"principal": @"Principal", @"director/principal": @"Director/Principal", @"director": @"Director"};
    
    NSString *titleKey = [[[[[NSUserDefaults standardUserDefaults] objectForKey:kCapGramUserProfileInfo] objectForKey:@"title"] stringByReplacingOccurrencesOfString:@" " withString:@""] lowercaseString];
    
    if (![allowableUserRoles objectForKey:titleKey]) {
        _editButton.enabled = NO;
    }
    
    //personal
    _firstName.text = [_rostrObject objectForKey:@"firstName"]? [_rostrObject objectForKey:@"firstName"]:@"N/A";
    _lastName.text = [_rostrObject objectForKey:@"lastName"]? [_rostrObject objectForKey:@"lastName"]:@"N/A";;
    _jobTitle.text = [_rostrObject objectForKey:@"title"]? [_rostrObject objectForKey:@"title"]:@"N/A";
    _mobileNo.text = [_rostrObject objectForKey:@"mobilePhone"]? [_rostrObject objectForKey:@"mobilePhone"]:@"N/A";
    _compEmail.text = [_rostrObject objectForKey:@"emailAddress"]? [_rostrObject objectForKey:@"emailAddress"]:@"N/A";
   _location.text = [_rostrObject objectForKey:@"location"]? [_rostrObject objectForKey:@"location"]:@"N/A";
    
    //capgemini
    _userId.text = [_rostrObject objectForKey:@"userId"]? [_rostrObject objectForKey:@"userId"]:@"N/A";
    _role.text = [_rostrObject objectForKey:@"role"]? [_rostrObject objectForKey:@"role"]:@"N/A";
    _upn.text = [_rostrObject objectForKey:@"upn"]? [_rostrObject objectForKey:@"upn"]:@"N/A";
    _startDate.text =  [_rostrObject objectForKey:@"companyStartDate"]? [_rostrObject objectForKey:@"companyStartDate"] :@"N/A";
    _userType.text = [[_rostrObject objectForKey:@"type"] stringByTrimmingCharactersInSet:[NSCharacterSet symbolCharacterSet]]? [[_rostrObject objectForKey:@"type"] stringByTrimmingCharactersInSet:[NSCharacterSet symbolCharacterSet]]: @"N/A";
    _userCapability.text = [_rostrObject objectForKey:@"capability"]? [_rostrObject objectForKey:@"capability"]:@"N/A";
    _gradeBand.text = [_rostrObject objectForKey:@"gradeBand"]? [_rostrObject objectForKey:@"gradeBand"]:@"N/A";
    _businessUnit.text = [_rostrObject objectForKey:@"bu"]? [_rostrObject objectForKey:@"bu"]:@"N/A";
    _orgUnit.text = [_rostrObject objectForKey:@"orgUnit"]? [_rostrObject objectForKey:@"orgUnit"]:@"N/A";
    _officeAddress.text = [_rostrObject objectForKey:@"officeAddress"]? [_rostrObject objectForKey:@"officeAddress"]:@"N/A";
    _shore.text = [_rostrObject objectForKey:@"shore"]? [_rostrObject objectForKey:@"shore"]:@"N/A";
    _status.text = [_rostrObject objectForKey:@"status"]? [_rostrObject objectForKey:@"status"]:@"N/A";
    
    //client
    _account.text = [_rostrObject objectForKey:@"account"]? [_rostrObject objectForKey:@"account"]:@"N/A";
    _contract.text = [_rostrObject objectForKey:@"contract"]? [_rostrObject objectForKey:@"contract"]:@"N/A";
    _clientEmail.text = [_rostrObject objectForKey:@"clientEmail"]? [_rostrObject objectForKey:@"clientEmail"]:@"N/A";
    _clientUserId.text = [_rostrObject objectForKey:@"clientUserID"]? [_rostrObject objectForKey:@"clientUserID"]:@"N/A";
    _cubicle.text = [_rostrObject objectForKey:@"cubicle"]? [_rostrObject objectForKey:@"cubicle"] : @"N/A";
    _reportingManger.text = [_rostrObject objectForKey:@"reportingManager"]?[_rostrObject objectForKey:@"reportingManager"]:@"N/A";
    _clientLevel.text =  [_rostrObject objectForKey:@"clientLevel"]? [_rostrObject objectForKey:@"clientLevel"]:@"N/A";
    _clientManager.text = [_rostrObject objectForKey:@"clientManager"]? [_rostrObject objectForKey:@"clientManager"]:@"N/A";
    _clientStartDate.text = [_rostrObject objectForKey:@"companyStartDate"]? [_rostrObject objectForKey:@"companyStartDate"]:@"N/A";
    _contractEndDate.text = [_rostrObject objectForKey:@"contractEndDate"]? [_rostrObject objectForKey:@"contractEndDate"]:@"N/A";
    _forecastEndDate.text = [_rostrObject objectForKey:@"forecastEnd"]? [_rostrObject objectForKey:@"forecastEnd"]:@"N/A";
    _expense.text = [_rostrObject objectForKey:@"expenses"]? [_rostrObject objectForKey:@"expenses"]:@"N/A";

    //immigration
    _citizenship.text =  [_rostrObject objectForKey:@"citizenship"]? [_rostrObject objectForKey:@"citizenship"]:@"N/A";
    _visaType.text = [_rostrObject objectForKey:@"visaType"]? [_rostrObject objectForKey:@"visaType"]:@"N/A";
    _visaIssuedCountry.text = [_rostrObject objectForKey:@"visaCountry"]? [_rostrObject objectForKey:@"visaCountry"]:@"N/A";
     _visaExpiration.text = [_rostrObject objectForKey:@"visaExpiration"]? [_rostrObject objectForKey:@"visaExpiration"]:@"N/A";
}

- (IBAction)editRostrInfo:(id)sender {
    
    if ([Networking networkStatus] == NetworkReachable) {
        RostrDetailEditViewController *editVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RostrDetailEditViewController"];
        
        editVC.rostrObject = _rostrObject;
        
        [self.navigationController showViewController:editVC sender:self];
    }
}
@end
