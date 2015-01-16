//
//  TJWTwitterKeysTableViewController.m
//  Twitter Login
//
//  Created by Teddy Wyly on 1/16/15.
//  Copyright (c) 2015 Teddy Wyly. All rights reserved.
//

#import "TJWTwitterKeysTableViewController.h"
#import "TWTAPIManager.h"


static NSString *const kKeyCellIdentifier = @"KeyCell";

@interface TJWTwitterKeysTableViewController ()

@property (strong, nonatomic) NSArray *keys;
@property (nonatomic, strong) TWTAPIManager *apiManager;

@end

@implementation TJWTwitterKeysTableViewController

- (TWTAPIManager *)apiManager {
    if (!_apiManager) {
        _apiManager = [[TWTAPIManager alloc] init];
    }
    return _apiManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 1;
    } else {
        return [self.keys count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kKeyCellIdentifier forIndexPath:indexPath];
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)path {
    if (path.section == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"@%@", self.account.username];
    } else {
        cell.textLabel.text = self.keys[path.row];
//        if (path.row == 0) {
//            cell.textLabel.text = @"Consumer Key";
//            cell.detailTextLabel.text = self.keys[path.row];
//        } else {
//            cell.textLabel.text = @"Secret Key";
//            cell.detailTextLabel.text = self.keys[path.row];
//        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Account";
    } else {
        return @"Keys";
    }
}

#pragma mark - IBActions

- (IBAction)getKeysBarButtonItemPressed:(UIBarButtonItem *)sender {
    
    sender.enabled = NO;
    ACAccount *account = self.account;
    [self.apiManager performReverseAuthForAccount:account withHandler:^(NSData *responseData, NSError *error) {
        if (responseData) {
            NSString *responseStr = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
            NSArray *parts = [responseStr componentsSeparatedByString:@"&"];
            //NSString *lined = [parts componentsJoinedByString:@"\n"];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.keys = parts;
                [self.tableView reloadData];
            });
            dispatch_async(dispatch_get_main_queue(), ^{
                sender.enabled = YES;
            });
        }
    }];
}

@end
