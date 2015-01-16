//
//  AppDelegate.m
//  Twitter Login
//
//  Created by Teddy Wyly on 1/15/15.
//  Copyright (c) 2015 Teddy Wyly. All rights reserved.
//


// For Extra, Use in app

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
