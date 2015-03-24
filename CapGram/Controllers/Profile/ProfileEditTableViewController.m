//
//  ProfileEditTableViewController.m
//  CapGram
//
//  Created by Prasad Pamidi on 11/9/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "ProfileEditTableViewController.h"

@interface ProfileEditTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *mobileNo;
@property (weak, nonatomic) IBOutlet UITextField *emailId;
@property (weak, nonatomic) IBOutlet UITextField *location;

@property (weak, nonatomic) IBOutlet UITextField *upn;
@property (weak, nonatomic) IBOutlet UITextField *userId;
@property (weak, nonatomic) IBOutlet UITextField *startDate;

@property (weak, nonatomic) IBOutlet UITextField *clientId;
@property (weak, nonatomic) IBOutlet UITextField *clientEmailId;
@property (weak, nonatomic) IBOutlet UITextField *cubicle;

@property (weak, nonatomic) IBOutlet UITextField *citizenship;
@property (weak, nonatomic) IBOutlet UITextField *visaType;
@property (weak, nonatomic) IBOutlet UITextField *visaExpirationDate;
@property (weak, nonatomic) IBOutlet UITextField *visaIssuesCountry;
@end

@implementation ProfileEditTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.145 green:0.584 blue:0.831 alpha:1]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"ArialRoundedMTBold" size:21],
      NSFontAttributeName,  [UIColor whiteColor],NSForegroundColorAttributeName, [UIColor whiteColor],NSBackgroundColorAttributeName, nil]];
    
    [self.navigationController.navigationBar setTranslucent: NO];

    //personal information
    _firstName.text = [_rostrObject objectForKey:@"firstName"];
    _lastName.text = [_rostrObject objectForKey:@"lastName"];
    _mobileNo.text = [_rostrObject objectForKey:@"mobilePhone"];
    _emailId.text = [_rostrObject objectForKey:@"emailAddress"];
    _location.text = [_rostrObject objectForKey:@"location"];
    
    //capgemini information
    _upn.text = [_rostrObject objectForKey:@"upn"];
    _startDate.text =  [_rostrObject objectForKey:@"companyStartDate"];
    _userId.text = [_rostrObject objectForKey:@"userId"];
    
    //client information
    _clientEmailId.text = [_rostrObject objectForKey:@"clientEmail"];
    _clientId.text = [_rostrObject objectForKey:@"clientUserID"];
    _cubicle.text = [_rostrObject objectForKey:@"cubicle"];
   
    //immigration information
    _citizenship.text =  [_rostrObject objectForKey:@"citizenship"];
    _visaType.text = [_rostrObject objectForKey:@"visaType"];
    _visaIssuesCountry.text = [_rostrObject objectForKey:@"visaCountry"];
    _visaExpirationDate.text = [_rostrObject objectForKey:@"visaExpiration"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveProfile:(id)sender {
  
    //personal information
    [_rostrObject setObject:_firstName.text forKey:@"firstName"];
    [_rostrObject setObject:_lastName.text forKey:@"lastName"];
    [_rostrObject setObject:_mobileNo.text forKey:@"mobilePhone"];
    [_rostrObject setObject:_emailId.text forKey:@"emailAddress"];
    [_rostrObject setObject:_location.text forKey:@"location"];
    
    
    //capgemini information
    [_rostrObject setObject:_userId.text forKey:@"userId"];
    [_rostrObject setObject:_upn.text forKey:@"upn"];
    [_rostrObject setObject:_startDate.text forKey:@"companyStartDate"];
   
    
    //client information
    [_rostrObject setObject:_clientEmailId.text forKey:@"clientEmail"];
    [_rostrObject setObject:_clientId.text forKey:@"clientUserID"];
    [_rostrObject setObject:_cubicle.text forKey:@"cubicle"];
    
    //immigration information
    [_rostrObject setObject:_citizenship.text forKey:@"citizenship"];
    [_rostrObject setObject:_visaType.text forKey:@"visaType"];
    [_rostrObject setObject:_visaIssuesCountry.text forKey:@"visaCountry"];
    [_rostrObject setObject:_visaExpirationDate.text forKey:@"visaExpiration"];
    
    [_rostrObject saveInBackground];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
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
