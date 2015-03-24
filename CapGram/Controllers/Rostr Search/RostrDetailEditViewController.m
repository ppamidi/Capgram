//
//  RostrDetailEditViewController.m
//  CapGram
//
//  Created by Prasad Pamidi on 11/9/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "RostrDetailEditViewController.h"

@interface RostrDetailEditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *roleTitle;
@property (weak, nonatomic) IBOutlet UITextField *mobileNo;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *location;

@property (weak, nonatomic) IBOutlet UITextField *upn;
@property (weak, nonatomic) IBOutlet UITextField *userId;
@property (weak, nonatomic) IBOutlet UITextField *startDate;
@property (weak, nonatomic) IBOutlet UITextField *type;
@property (weak, nonatomic) IBOutlet UITextField *userCapability;
@property (weak, nonatomic) IBOutlet UITextField *gradeBand;
@property (weak, nonatomic) IBOutlet UITextField *businessUnit;
@property (weak, nonatomic) IBOutlet UITextField *orgUnit;
@property (weak, nonatomic) IBOutlet UITextField *officeAddress;
@property (weak, nonatomic) IBOutlet UITextField *shore;
@property (weak, nonatomic) IBOutlet UITextField *status;
@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *contract;
@property (weak, nonatomic) IBOutlet UITextField *clientEmail;
@property (weak, nonatomic) IBOutlet UITextField *clientUserId;
@property (weak, nonatomic) IBOutlet UITextField *cubicle;
@property (weak, nonatomic) IBOutlet UITextField *role;
@property (weak, nonatomic) IBOutlet UITextField *reportingManager;
@property (weak, nonatomic) IBOutlet UITextField *clientManager;
@property (weak, nonatomic) IBOutlet UITextField *contractEndDate;
@property (weak, nonatomic) IBOutlet UITextField *forecastEndDate;
@property (weak, nonatomic) IBOutlet UITextField *expense;
@property (weak, nonatomic) IBOutlet UITextField *clientLevel;
@property (weak, nonatomic) IBOutlet UITextField *clientStartDate;

@property (weak, nonatomic) IBOutlet UITextField *citizenship;
@property (weak, nonatomic) IBOutlet UITextField *visaType;
@property (weak, nonatomic) IBOutlet UITextField *visaIssuedCountry;
@property (weak, nonatomic) IBOutlet UITextField *visaExpirationDate;
@end

@implementation RostrDetailEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //personal information
    _firstName.text = [_rostrObject objectForKey:@"firstName"];
    _lastName.text = [_rostrObject objectForKey:@"lastName"];
    _roleTitle.text = [_rostrObject objectForKey:@"title"];
    _mobileNo.text = [_rostrObject objectForKey:@"mobilePhone"];
    _email.text = [_rostrObject objectForKey:@"emailAddress"];
    _location.text = [_rostrObject objectForKey:@"location"];
    
    //capgemini information
    _upn.text = [_rostrObject objectForKey:@"upn"];
    _userId.text = [_rostrObject objectForKey:@"userId"];
    _startDate.text =  [_rostrObject objectForKey:@"companyStartDate"];
    _type.text = [[_rostrObject objectForKey:@"type"] stringByTrimmingCharactersInSet:[NSCharacterSet symbolCharacterSet]];
    _userCapability.text = [_rostrObject objectForKey:@"capability"];
    _gradeBand.text = [_rostrObject objectForKey:@"gradeBand"];
    _businessUnit.text = [_rostrObject objectForKey:@"bu"];
    _orgUnit.text = [_rostrObject objectForKey:@"orgUnit"];
    _officeAddress.text = [_rostrObject objectForKey:@"officeAddress"];
    _shore.text = [_rostrObject objectForKey:@"shore"];
    _status.text = [_rostrObject objectForKey:@"status"];

    //client information
    _account.text = [_rostrObject objectForKey:@"account"];
    _contract.text = [_rostrObject objectForKey:@"contract"];
    _clientEmail.text = [_rostrObject objectForKey:@"clientEmail"];
    _clientUserId.text = [_rostrObject objectForKey:@"clientUserID"];
    _cubicle.text = [_rostrObject objectForKey:@"cubicle"];
    _reportingManager.text = [_rostrObject objectForKey:@"reportingManager"];
    _clientLevel.text =  [_rostrObject objectForKey:@"clientLevel"];
    _clientManager.text = [_rostrObject objectForKey:@"clientManager"];
    _clientStartDate.text = [_rostrObject objectForKey:@"companyStartDate"];
    _contractEndDate.text = [_rostrObject objectForKey:@"contractEndDate"];
    _forecastEndDate.text = [_rostrObject objectForKey:@"forecastEnd"];
    _expense.text = [_rostrObject objectForKey:@"expenses"];
    _role.text = [_rostrObject objectForKey:@"role"];

    //immigration information
    _citizenship.text =  [_rostrObject objectForKey:@"citizenship"];
    _visaType.text = [_rostrObject objectForKey:@"visaType"];
    _visaIssuedCountry.text = [_rostrObject objectForKey:@"visaCountry"];
    _visaExpirationDate.text = [_rostrObject objectForKey:@"visaExpiration"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveRostrChanges:(id)sender {
    
    //personal information
    [_rostrObject setObject:_firstName.text forKey:@"firstName"];
    [_rostrObject setObject:_lastName.text forKey:@"lastName"];
    [_rostrObject setObject:_roleTitle.text forKey:@"title"];
    [_rostrObject setObject:_mobileNo.text forKey:@"mobilePhone"];
    [_rostrObject setObject:_email.text forKey:@"emailAddress"];
    [_rostrObject setObject:_location.text forKey:@"location"];
    
    //capgemini information
    [_rostrObject setObject:_userId.text forKey:@"userId"];
    [_rostrObject setObject:_upn.text forKey:@"upn"];
    [_rostrObject setObject:_startDate.text forKey:@"companyStartDate"];
    [_rostrObject setObject:_type.text forKey:@"type"];
    [_rostrObject setObject:_userCapability.text forKey:@"capability"];
    [_rostrObject setObject:_gradeBand.text forKey:@"gradeBand"];
    [_rostrObject setObject:_businessUnit.text forKey:@"bu"];
    [_rostrObject setObject:_orgUnit.text forKey:@"orgUnit"];
    [_rostrObject setObject:_officeAddress.text forKey:@"officeAddress"];
    [_rostrObject setObject:_shore.text forKey:@"shore"];
    [_rostrObject setObject:_status.text forKey:@"status"];
   
    //client information
    [_rostrObject setObject:_account.text forKey:@"account"];
    [_rostrObject setObject:_contract.text forKey:@"contract"];
    [_rostrObject setObject:_clientEmail.text forKey:@"clientEmail"];
    [_rostrObject setObject:_clientUserId.text forKey:@"clientUserID"];
    [_rostrObject setObject:_cubicle.text forKey:@"cubicle"];
    [_rostrObject setObject:_reportingManager.text forKey:@"reportingManager"];
    [_rostrObject setObject:_clientLevel.text forKey:@"clientLevel"];
    [_rostrObject setObject:_clientManager.text forKey:@"clientManager"];
    [_rostrObject setObject:_clientStartDate.text forKey:@"clientStartDate"];
    [_rostrObject setObject:_contractEndDate.text forKey:@"contractEndDate"];
    [_rostrObject setObject:_forecastEndDate.text forKey:@"forecastEnd"];
    [_rostrObject setObject:_expense.text forKey:@"expense"];
    [_rostrObject setObject:_role.text forKey:@"role"];
    
    //immigration
    [_rostrObject setObject:_citizenship.text forKey:@"citizenship"];
    [_rostrObject setObject:_visaType.text forKey:@"visaType"];
    [_rostrObject setObject:_visaIssuedCountry.text forKey:@"visaCountry"];
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
