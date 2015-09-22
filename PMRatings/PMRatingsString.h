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
 <#description#>
 @param <#parameter#>
 @returns <#retval#>
 @exception <#throws#>
 */
- (id) initWithAppID:(NSString *)aAppID minimunRatingCount:(int)aNum;

/**
 <#description#>
 @param <#parameter#>
 @returns <#retval#>
 @exception <#throws#>
 */
- (void) ratingStringWithCompletionHandler:(void (^)(NSString *result))completionHandler;

@end
