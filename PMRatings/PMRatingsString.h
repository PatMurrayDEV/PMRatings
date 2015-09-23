//
//  PMRatingsString.h
//  PMRatings
//
//  Created by Patrick Murray on 22/09/2015.
//  Copyright © 2015 Patrick Murray. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PMRatingsString : NSObject

/**
 Initialize a new intance of PMRatingsString.
 @param NSString iTunes Store App ID
 @param int Minimun rating count to include "only" before
 @returns PMRatingsString object
 */
- (id) initWithAppID:(NSString *)aAppID minimunRatingCount:(int)aNum;


/**
 <#description#>
 @param <#parameter#>
 @returns <#retval#>
 @exception <#throws#>
 */
- (void) ratingStringWithCacheValue:(void (^)(NSString *result))cacheValue updated:(void (^)(NSString *result))updated;


@end
