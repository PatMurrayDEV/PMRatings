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
        [self layoutCellForNewTitle:[self applicationName] subtitle:@"Blue"];
        PMRatingsString *string = [[PMRatingsString alloc] initWithAppID:appID minimunRatingCount:aNum];
        [string ratingStringWithCacheValue:^(NSString *result) {
            [self layoutCellForNewTitle:[self applicationName] subtitle:result];
        } updated:^(NSString *result) {
            [self layoutCellForNewTitle:@"TEST 2" subtitle:result];
        }];
    }
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return self;
}

- (void) layoutCellForNewTitle:(NSString *)title subtitle:(NSString *)subtitle {
    self.textLabel.text = [NSString stringWithFormat:@"Please rate %@", title];
    self.detailTextLabel.text = subtitle;
    [self setNeedsLayout];
    
    [self.detailTextLabel setNeedsLayout];
    [self reloadView];
    
}

- (void) reloadView {
    id view = [self superview];
    
    while (view && [view isKindOfClass:[UITableView class]] == NO) {
        view = [view superview];
    }
    
    UITableView *tableView = (UITableView *)view;
    [tableView reloadData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSString *) applicationName {
    NSBundle *bundle = [NSBundle mainBundle];
    NSDictionary *info = [bundle infoDictionary];
    NSString *prodName = [info objectForKey:@"CFBundleDisplayName"];
    return prodName;
}

@end
