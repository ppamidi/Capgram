//
//  EventTableViewCell.h
//  CapGram
//
//  Created by Prasad Pamidi on 9/8/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *location;

@end
