//
//  PMRatingsDownloader.h
//  PMRatings
//
//  Created by Patrick Murray on 22/09/2015.
//  Copyright © 2015 Patrick Murray. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMRatingsDownloader : NSObject


/**
 Fetches data from the URL provided.
 @param urlString The URL as an NSString
 @returns completionHandler block with NSData
 */
+ (void) fetchDataWithURL:(NSString *)urlString
        completionHandler:(void (^)(NSData *result))completionHandler
                  failure:(void (^)(NSError *error))failure;

/**
 Fetches data from the URL provided and saves the rating to NSUserDefaults.
 @param urlString The URL as an NSString
 @returns completionHandler with int
 */
+ (void) fetchNumberWithURL:(NSString *)urlString
        completionHandler:(void (^)(int result))completionHandler
                  failure:(void (^)(NSError *error))failure;



@end
