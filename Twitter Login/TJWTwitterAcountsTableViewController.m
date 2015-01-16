//
//  TJWTwitterAcountsTableViewController.m
//  Twitter Login
//
//  Created by Teddy Wyly on 1/15/15.
//  Copyright (c) 2015 Teddy Wyly. All rights reserved.
//


//Look into Application Only Authentication. Access friends and followers of any account;


#import "TJWTwitterAcountsTableViewController.h"
#import "TJWTwitterUserTableViewController.h"
#import "TJWTwitterKeysTableViewController.h"


static NSString *const kAccountCellIdentifier = @"AccountCell";
static NSString *const kSetAccountSegueIdentifier = @"setAccount:";
static NSString *const kSeeKeysSegueIdentifier = @"seeKeys";


@interface TJWTwitterAcountsTableViewController ()

@property (strong, nonatomic) NSArray *acounts;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *getAccountsBarButtonItem;

@end

@implementation TJWTwitterAcountsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.acounts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAccountCellIdentifier forIndexPath:indexPath];
    ACAccount *account = self.acounts[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"@%@", account.username];
    
    return cell;
}

#pragma mark - UITableViewDelegate


#pragma mark - IBAction

- (IBAction)getAccountsBarButtonItemPressed:(UIBarButtonItem *)sender {
    [self fetchAccountsAndReloadTableView];
}

- (void)fetchAccountsAndReloadTableView {
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    self.getAccountsBarButtonItem.enabled = NO;
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error)
     {
         if (granted)
         {
             NSArray *accounts = [accountStore accountsWithAccountType:accountType];
             // Check if the users has setup at least one Twitter account.
             if (accounts.count > 0) {
                 self.acounts = accounts;
             } else {
                 NSLog(@"No accounts");
             }
         } else {
             NSLog(@"No access granted");
         }
         dispatch_async(dispatch_get_main_queue(), ^{
             self.getAccountsBarButtonItem.enabled = YES;
             [self.tableView reloadData];
         });
     }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kSetAccountSegueIdentifier]) {
        NSIndexPath *path = [self.tableView indexPathForCell:sender];
        ACAccount *account = self.acounts[path.row];
        TJWTwitterUserTableViewController *targetVC = (TJWTwitterUserTableViewController *)segue.destinationViewController;
        targetVC.account = account;
    } else if ([segue.identifier isEqualToString:kSeeKeysSegueIdentifier]) {
        NSIndexPath *path = [self.tableView indexPathForCell:sender];
        ACAccount *account = self.acounts[path.row];
        TJWTwitterKeysTableViewController *targetVC = (TJWTwitterKeysTableViewController *)segue.destinationViewController;
        targetVC.account = account;
    }
}


@end
