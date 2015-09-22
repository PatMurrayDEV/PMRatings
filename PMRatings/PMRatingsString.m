//
//  PMRatingsString.m
//  PMRatings
//
//  Created by Patrick Murray on 22/09/2015.
//  Copyright © 2015 Patrick Murray. All rights reserved.
//

#import "PMRatingsString.h"
#import "PMRatingsDownloader.h"


@interface PMRatingsString()

@property (nonatomic) int ratingCountNumber;
@property (nonatomic) NSString * appID;

@end

@implementation PMRatingsString


#pragma mark - Public Methods

- (id) initWithAppID:(NSString *)aAppID minimunRatingCount:(int)aNum {
    
    _ratingCountNumber = aNum;
    _appID = aAppID;
    
    return self;
    
}


- (void) ratingStringWithCompletionHandler:(void (^)(NSString *))completionHandler {

    NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@", _appID];
    
//    [PMRatingsDownloader fetchDataWithURL:urlString
//                        completionHandler:^(NSData *result) {
//                            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:result options:0 error:nil];
//                            completionHandler([self formattedStringFromJSON:json]);
//                        }
//                                  failure:^(NSError *error) {
//                        
//                                  }];
    
    [PMRatingsDownloader fetchNumberWithURL:urlString completionHandler:^(int result) {
        completionHandler([self setRatingString:result]);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - Private Methods
- (NSString *) formattedStringFromJSON:(NSDictionary *)json {
    NSDictionary *object = [json[@"results"] lastObject];
    NSNumber *num = object[@"userRatingCountForCurrentVersion"];
    int number = [num intValue];
    
    return [self setRatingString:number];
}


- (NSString *)setRatingString:(int) number {
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

@end
