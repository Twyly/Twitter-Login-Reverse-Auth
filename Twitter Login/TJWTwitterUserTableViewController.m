//
//  TJWTwitterUserTableViewController.m
//  Twitter Login
//
//  Created by Teddy Wyly on 1/15/15.
//  Copyright (c) 2015 Teddy Wyly. All rights reserved.
//

#import "TJWTwitterUserTableViewController.h"

static NSString *const kTwitterFollowersURL = @"https://api.twitter.com/1.1/followers/list.json";
static NSString *const kTwitterFriendsURL = @"https://api.twitter.com/1.1/friends/list.json";

static NSString *const kFollowerCellIdentifier = @"FollowerCell";


@interface TJWTwitterUserTableViewController ()

@property (strong, nonatomic) NSMutableArray *followers;
@property (strong, nonatomic) NSString *nextCursor;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *getFollowersBarButtonItem;

@end

@implementation TJWTwitterUserTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSMutableArray *)followers {
    if (!_followers) {
        _followers = [NSMutableArray array];
    }
    return _followers;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.followers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFollowerCellIdentifier forIndexPath:indexPath];
    NSString *follower = self.followers[indexPath.row];
    cell.textLabel.text  = [NSString stringWithFormat:@"@%@", follower];
    return cell;
}

- (IBAction)getFollowersBarButtonItemPressed:(UIBarButtonItem *)sender {
    ACAccount *twitterAccount = self.account;
    
    NSURL *url = [NSURL URLWithString:kTwitterFollowersURL];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"screen_name" : twitterAccount.username}];

    if (self.nextCursor) {
        [parameters setValue:self.nextCursor forKey:@"cursor"];
    }
    
    if ([self.nextCursor isEqualToString:@"0"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Reached All People!" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    
    
    // Creating a request.
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                            requestMethod:SLRequestMethodGET
                                                      URL:url
                                               parameters:parameters];
    
    
    // Reverse Auth

    [request setAccount:twitterAccount];
    NSLog(@"Headers are %@", request.preparedURLRequest.allHTTPHeaderFields);
    
    
    self.getFollowersBarButtonItem.enabled = NO;
    
    // Perform the request.
    [request performRequestWithHandler:^(NSData *responseData,
                                         NSHTTPURLResponse *urlResponse,
                                         NSError *error)
     {
         dispatch_async(dispatch_get_main_queue(), ^
                        {
                            // Check if we reached the rate limit.
                            if ([urlResponse statusCode] == 429) {
                                NSLog(@"Rate limit reached");
                                return;
                            }
                            
                            // Check if there was an error
                            if (error) {
                                NSLog(@"Error: %@", error.localizedDescription);
                                return;
                            }
                            
                            // Check if there is some response data.
                            if (responseData) {
                                NSError *error = nil;
                                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseData
                                                                                           options:NSJSONReadingMutableLeaves
                                                                                             error:&error];
                                
                                //NSLog(@"Response is %@", dictionary);
                                NSString *nextCursor = dictionary[@"next_cursor_str"];
                                NSLog(@"nextCURSE is %@", nextCursor);
                                self.nextCursor = nextCursor;
                                NSArray *users = dictionary[@"users"];
                                NSArray *followers = [users valueForKeyPath:@"screen_name"];
                                [self.followers addObjectsFromArray:followers];
                                [self.tableView reloadData];

                            }
                            
                            self.getFollowersBarButtonItem.enabled = YES;

                        });
     }];
}




@end
