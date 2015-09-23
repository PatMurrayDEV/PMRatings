//
//  PMRatingsString.m
//  PMRatings
//
//  Created by Patrick Murray on 22/09/2015.
//  Copyright © 2015 Patrick Murray. All rights reserved.
//

#import "PMRatingsString.h"


@interface PMRatingsString()

@property (nonatomic) int ratingCountNumber;
@property (nonatomic) NSString * appID;

@end

@implementation PMRatingsString

NSString * const NSUSERDEFAULT_STRING = @"PMRatings_Ratings_Count";


#pragma mark - Public Methods

/*
 Initialisation of PMRatingString object
 */
- (id) initWithAppID:(NSString *)aAppID minimunRatingCount:(int)aNum {
    _ratingCountNumber = aNum;
    _appID = aAppID;
    return self;
}

/*
 Return through blocks the formatted string
 */
- (void) ratingStringWithCacheValue:(void (^)(NSString *result))cacheValue updated:(void (^)(NSString *result))updated {
    NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@", _appID];

    cacheValue([self setRatingString:(int)[[NSUserDefaults standardUserDefaults] integerForKey:NSUSERDEFAULT_STRING]]);
    
    [self fetchNumberWithURL:urlString completionHandler:^(int result) {
        NSString *returnString = [self getRatingStringWithCheck:result];
        if (returnString != nil) {
            updated(returnString);
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
}


#pragma mark - Private Methods
#pragma mark Return String
/*
 Checks if the passed in int is different from the cached rating count.
 If it is different, saves the number to the NSUserDefaults and returns string.
 If the value isn't different returns nil.
 */
- (NSString *) getRatingStringWithCheck:(int) number {
    if (number == (int)[[NSUserDefaults standardUserDefaults] integerForKey:NSUSERDEFAULT_STRING]) {
        return nil;
    } else {
        [self cacheRatingToUserDefaults:number];
        return [self setRatingString:number];
    }
}

/*
 Through a series of if statements compares the paramenter number to the instance's minimun ratingCountNumber. 
 Returns the appropriate string.
 Else returns "Every rating helps."
 */
- (NSString *) setRatingString:(int) number {
    NSString *string;
    if (number >= _ratingCountNumber) {
        string = [[NSString alloc] initWithFormat:@"%d people have rated this version.", number];
    } else if (number > 1 && number < _ratingCountNumber) {
        string = [[NSString alloc] initWithFormat:@"Only %d people have rated this version.", number];
    } else if (number == 1) {
        string = [[NSString alloc] initWithFormat:@"Only %d person has rated this version.", number];
    } else if (number == 0) {
        string = [[NSString alloc] initWithFormat:@"No one has rated this version yet."];
    } else {
        string = [[NSString alloc] initWithFormat:@"Every rating helps."];
    }
    return string;
}

#pragma mark Downloader
/*
 Takes in urlString, and two blocks. Fetches data from iTunes servers.
 Through thr blocks returns either an int or an error.
 */
- (void) fetchNumberWithURL:(NSString *)urlString
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
                                                
                                                completionHandler(number);
                                                
                                                if (error != Nil) {
                                                    failure(error);
                                                }
                                            }];
    [dataTask resume];
}

/*
 Extracts userRatingCountForCurrentVersion from the passed in dictionary.
 Retuns int extracted
 */
- (int) integerFromJson:(NSDictionary *)json {
    NSDictionary *object = [json[@"results"] lastObject];
    NSNumber *num = object[@"userRatingCountForCurrentVersion"];
    int number = [num intValue];
    return number;
}


#pragma mark Cache
/*
 
 */
- (void) cacheRatingToUserDefaults:(int)number {
    [[NSUserDefaults standardUserDefaults] setInteger:number forKey:NSUSERDEFAULT_STRING];
}

@end
