//
//  PMRatingsTableViewCell.h
//  PMRatings
//
//  Created by Patrick Murray on 23/09/2015.
//  Copyright © 2015 Patrick Murray. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMRatingsTableViewCell : UITableViewCell



- (instancetype) initWithAppID:(NSString *)appID minimunRatingCount:(int)aNum refreshPeriod:(NSTimeInterval)interval;

@end
