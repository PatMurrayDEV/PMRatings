//
//  MasterViewController.m
//  PMRatingsExample
//
//  Created by Patrick Murray on 22/09/2015.
//  Copyright © 2015 Patrick Murray. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import <PMRatings/PMRatings.h>

@interface MasterViewController ()

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Segues

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSDate *object = self.objects[indexPath.row];
//        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
//        [controller setDetailItem:object];
//        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
//        controller.navigationItem.leftItemsSupplementBackButton = YES;
//    }
//}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//
//    PMRatingsString *PMstring = [[PMRatingsString alloc] initWithAppID:@"406128109" minimunRatingCount:100];
//    [PMstring ratingStringWithCacheValue:^(NSString *result) {
//        cell.textLabel.text = result;
//    } updated:^(NSString *result) {
//        cell.textLabel.text = result;
//    }];
//
    
    PMRatingsTableViewCell * cell = [[PMRatingsTableViewCell alloc] initWithAppID:@"324684580"
                                                               minimunRatingCount:100
                                                                    refreshPeriod:400];
    
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}



@end
