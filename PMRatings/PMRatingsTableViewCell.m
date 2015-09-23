//
//  PMRatingsTableViewCell.m
//  PMRatings
//
//  Created by Patrick Murray on 23/09/2015.
//  Copyright © 2015 Patrick Murray. All rights reserved.
//

#import "PMRatingsTableViewCell.h"
#import "PMRatingsString.h"

@implementation PMRatingsTableViewCell

- (instancetype) initWithAppID:(NSString *)appID minimunRatingCount:(int)aNum refreshPeriod:(NSTimeInterval)interval {
    if (self = [self initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil]) {
        PMRatingsString *string = [[PMRatingsString alloc] initWithAppID:appID minimunRatingCount:aNum];
        [string ratingStringWithCacheValue:^(NSString *result) {
            [self layoutCellForNewTitle:@"TEST" subtitle:result];
        } updated:^(NSString *result) {
            [self layoutCellForNewTitle:@"TEST 2" subtitle:result];
        }];
    }
    return self;
}

- (void) layoutCellForNewTitle:(NSString *)title subtitle:(NSString *)subtitle {
    self.textLabel.text = title;
    self.detailTextLabel.text = subtitle;
    [self setNeedsDisplay];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
