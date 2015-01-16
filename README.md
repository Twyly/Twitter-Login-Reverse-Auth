# Twitter Login Example

This is the sample application for twitter login and reverese Auth (for Ben).  Follow the steps below:

// STEPS TO LAUNCH

// 1. Copy your TWITTER_CONSUMER_KEY and TWITTER_CONSUMER_SECRET keys from twitter.dev into their respective spots in Info.plist
// 2. Drag in Both Folders located in the External Code folder into your project
// 3. Add Social.Framework and Accounts.Framework in your build phases tab
// 3. Go to the TJWTwitterAccountsTableViewController class
// 4. Reference the fetchAccountsAndReloadTableView method to login through twitter (though Social.Framework)
// 5. Go to the TJWTwitterKeysTableViewController class
// 6. Reference the getKeysBarButtonItemPressed: method to retrieve both your key and secret key from reverse OAuth.  You can use this information later on the server side to make authenticated calls.  Notice that once you have these paramters, you can use them to get ANY users' followers, not just the followers of the user making the call.
// 7. Go to the TJWTwitterUserController class
// 8. Reference the getFollowersBarButtonItemPressed: method to pull followers.  Notice the cursor paramter allowing you to paginate. Each request will give you a new cursor number to pass in for the next call.  When the cursor hits 0, it means you have successfully hit all followers/friends.
// 7.If at any point you run out of requests (which I can't really see happening), you can use your app to make authenticated requets.  See the info in the app delegate