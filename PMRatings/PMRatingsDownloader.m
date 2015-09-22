//
//  PMRatingsDownloader.m
//  PMRatings
//
//  Created by Patrick Murray on 22/09/2015.
//  Copyright © 2015 Patrick Murray. All rights reserved.
//

#import "PMRatingsDownloader.h"

@implementation PMRatingsDownloader 

NSString * const NSUSERDEFAULT_STRING = @"PMRatings_Ratings_Count";


#pragma mark - Public Methods
+ (void) fetchDataWithURL:(NSString *)urlString
            completionHandler:(void (^)(NSData *result))completionHandler
                      failure:(void (^)(NSError *error))failure {
    
    NSURL *url = [NSURL URLWithString:urlString];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url
                                            completionHandler:^(NSData *data,
                                                                NSURLResponse *response,
                                                                NSError *error) {
                                                
                                                completionHandler(data);
                                                if (error != Nil) {
                                                    failure(error);
                                                }
                                            }];
    
    [dataTask resume];
    
}

+ (void) fetchNumberWithURL:(NSString *)urlString
          completionHandler:(void (^)(int))completionHandler
                    failure:(void (^)(NSError *))failure {
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url
                                            completionHandler:^(NSData *data,
                                                                NSURLResponse *response,
                                                                NSError *error) {
                                                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                
                                                int number = [self integerFromJson:json];
                                                [self cacheRatingToUserDefaults:number];
                                                
                                                completionHandler(number);
                                                
                                                if (error != Nil) {
                                                    failure(error);
                                                }
                                            }];
    
    [dataTask resume];
    
}

#pragma mark - Private Methods

+ (int) integerFromJson:(NSDictionary *)json {
    NSDictionary *object = [json[@"results"] lastObject];
    NSNumber *num = object[@"userRatingCountForCurrentVersion"];
    int number = [num intValue];
    return number;
}

+ (void) cacheRatingToUserDefaults:(int)number {
    [[NSUserDefaults standardUserDefaults] setInteger:number forKey:NSUSERDEFAULT_STRING];
}


@end
