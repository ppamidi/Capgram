//
//  RosterTableViewCell.h
//  CapGram
//
//  Created by Prasad Pamidi on 9/8/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RosterTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *location;

@end
