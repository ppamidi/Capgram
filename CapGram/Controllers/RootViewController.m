//
//  ContentViewController.m
//  CapGram
//
//  Created by Prasad Pamidi on 9/6/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "RootViewController.h"
#import "YMConstants.h"
#import "HomeViewController.h"
#import "YMLoginController.h"
#import "Constants.h"

@interface RootViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.224 green:0.686 blue:0.969 alpha:1]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"ArialRoundedMTBold" size:21],
      NSFontAttributeName,  [UIColor whiteColor],NSForegroundColorAttributeName, [UIColor whiteColor],NSBackgroundColorAttributeName, nil]];
    
    [self.navigationController.navigationBar setTranslucent: NO];
    
    _loginButton.layer.cornerRadius = _loginButton.frame.size.height /2;
    _loginButton.layer.borderWidth = 0;
    _loginButton.layer.masksToBounds = YES;
    
    [[YMLoginController sharedInstance] setDelegate:self];

}

- (void) updateContentView {
    if ([[YMLoginController sharedInstance] storedAuthToken]) {
        
        [self showViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"] sender:self];
    } else {
        
    }
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updateContentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginThroughYammer:(id)sender {
    
    [[YMLoginController sharedInstance] startLogin];
    
}


#pragma mark - Login controller notification handling methods

- (void) loginController:(YMLoginController *)loginController didCompleteWithAuthToken:(NSString *)authToken forUser:(id) userObject
{
    NSString *emailAddress = [[[[[userObject objectForKey:@"user"] objectForKey:@"contact"]
                                objectForKey:@"email_addresses"]
                               objectAtIndex:0] objectForKey:@"address"];
    
    NSString *jobTitle = [[userObject objectForKey:@"user"] objectForKey:@"job_title"];
    
    NSDictionary *userDict = @{@"email":emailAddress,
                               @"title": jobTitle};
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:userDict forKey:kCapGramUserProfileInfo];
    [userDefaults synchronize];

    [self handleSuccessWithToken:authToken];
    
}

- (void) loginController:(YMLoginController *)loginController didFailWithError:(NSError *)error
{
    [self handleFailureWithError:error];
}

#pragma mark - Common error/success handling methods

- (void)handleSuccessWithToken:(NSString *)authToken
{
    [self updateContentView];
}

- (void)handleFailureWithError:(NSError *)error
{
    if (error.code == YMYammerSDKLoginInvalidNetworkError) {
        [[[UIAlertView alloc] initWithTitle:@"Invalid Network" message:@"You have not logged into Capgemini Yammer network" delegate:self cancelButtonTitle:@"" otherButtonTitles: nil] show];
    }
    
    [self updateContentView];
}
@end
