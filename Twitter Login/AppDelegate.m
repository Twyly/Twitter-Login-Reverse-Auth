//
//  AppDelegate.m
//  Twitter Login
//
//  Created by Teddy Wyly on 1/15/15.
//  Copyright (c) 2015 Teddy Wyly. All rights reserved.
//


// STEPS TO LAUNCH

// 1. Copy your TWITTER_CONSUMER_KEY and TWITTER_CONSUMER_SECRET keys from twitter.dev into their respective spots in Info.plist
// 2. Drag in Both Folders located in the External Code folder into your project
// 3. Add Social.Framework and Accounts.Framework in your build phases tab
// 3. Go to the TJWTwitterAccountsTableViewController Class
// 4. Reference the getAccountsBarButtonItemPressed: method to login through twitter (though Social.Framework)
// 5. Reference the tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath to retrieve both your key and secret key from reverse OAuth.  You can use this information later on the server side to make authenticated calls.  Notice that once you have these paramters, you can use them to get ANY users' followers, not just the followers of the user making the call.
// 6. Reference the getFollowersBarButtonItemPressed: method to pull followers.  Notice the cursor paramter allowing you to paginate. Each request will give you a new cursor number to pass in for the next call.  When the cursor hits 0, it means you have successfully hit all followers/friends.
// 7.If at any point you run out of requests, you can use your app to make authenticated requets.  See the below info:



// This is more easily seen https://dev.twitter.com/oauth/application-only at the example near the bottom
// Post To
// https://api.twitter.com/oauth2/token with Authorization Header of the BEARER_CREDENTIALS passed through the base64Encoded Metheod below

// Response will be {"token_type":"bearer","access_token":"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA%2FAAAAAAAAAAAAAAAAAAAA%3DAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"}

// Whenever making a REST request, include Authorization: Bearer access_token and it will be validated



#import "AppDelegate.h"

#define CONSUMER_KEY OCv8Xyv1hsyDZfSpc2bAv39n3
#define CONSUMER_SECRET MNnuHZdEOuizKbCDsQoIfZoJDSfbRfKAnsFPgdwitUzKdps8Sk
#define BEARER_CREDENTIALS OCv8Xyv1hsyDZfSpc2bAv39n3:MNnuHZdEOuizKbCDsQoIfZoJDSfbRfKAnsFPgdwitUzKdps8Sk

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    return YES;
}

- (NSString *)base64EncodedStringForString:(NSString *)string {
    NSData *plainData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [plainData base64EncodedStringWithOptions:0];
    return base64String;
}

@end
