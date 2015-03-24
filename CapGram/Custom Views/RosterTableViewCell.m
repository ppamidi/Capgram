//
//  RosterTableViewCell.m
//  CapGram
//
//  Created by Prasad Pamidi on 9/8/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "RosterTableViewCell.h"

@implementation RosterTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.selectedBackgroundView.frame];
    [backgroundView setBackgroundColor:[UIColor colorWithRed:0.125 green:0.484 blue:0.731 alpha:0.5]];
    [self setSelectedBackgroundView:backgroundView];
}

@end
