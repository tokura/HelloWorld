//
//  ListViewController.m
//  TwitterCliant03
//
//  Created by PANCAKE on 13/06/03.
//  Copyright (c) 2013年 PANCAKE. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.accountStore = [[ACAccountStore alloc] init]; // アカウントストアの初期化
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    // この行はテーブルビューセルの再利用で必要（iOS6以降）
    
    //  Step 1:  Obtain access to the user's Twitter accounts
    ACAccountType *twitterType =
    [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [self.accountStore
     requestAccessToAccountsWithType:twitterType
     options:NULL
     completion:^(BOOL granted, NSError *error) {
         if (granted) {
             //  Step 2:  Create a request
             
             
             NSArray *twitterAccounts = [self.accountStore accountsWithAccountType:twitterType];
             
             
             NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/lists/list.json"];
             
             //https://api.twitter.com/1.1/favorites/list.json
             
             
             // NSDictionary *params = @{
             
             // @"count" : @"1",
             //@"list_id" : @"90375234"
             
             //};
             // @"trim_user" : @"1",
             //@"include_entities" : @"0",
             
             SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                     requestMethod:SLRequestMethodGET
                                                               URL:url
                                                        parameters:nil];
             
             //  Attach an account to the request
             [request setAccount:[twitterAccounts lastObject]];
             
             //  Step 3:  Execute the request
             [request performRequestWithHandler:^(NSData *responseData,
                                                  NSHTTPURLResponse *urlResponse,
                                                  NSError *error) { // ここからは別スレッド（キュー）
                 if (responseData) {
                     if (urlResponse.statusCode >= 200 && urlResponse.statusCode < 300) {
                         NSError *jsonError;
                         self.timelineData =
                         [NSJSONSerialization JSONObjectWithData:responseData
                                                         options:NSJSONReadingAllowFragments
                                                           error:&jsonError];
                         if (self.timelineData) {
                             NSLog(@"Timeline Response: %@\n", self.timelineData);
                             dispatch_async(dispatch_get_main_queue(), ^{ // UI処理はメインキューで
                                 [self.tableView reloadData];
                             });
                         }
                         else {
                             // Our JSON deserialization went awry
                             NSLog(@"JSON Error: %@", [jsonError localizedDescription]);
                         }
                     }
                     else {
                         // The server did not respond successfully... were we rate-limited?
                         NSLog(@"The response status code is %d", urlResponse.statusCode);
                     }
                 }
             }];
         }
         else {
             // Access was not granted, or an error occurred
             NSLog(@"%@", [error localizedDescription]);
         }
     }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








#pragma mark - Table view data source






- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}







- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!self.timelineData) { // このif節は超重要！
        return 1;
    } else {
        return [self.timelineData count];
    }
}






NSString *statustext = @"list/";


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // この行はテーブルビューセルの再利用で必要（iOS6以降）
    
    // Configure the cell...
    NSString *status;
    NSString *status2;
    NSString *status3;
 
    if (!self.timelineData) { // このif節は超重要！
        status = @"";
    } else {
        
        //status = [[self.timelineData objectAtIndex:indexPath.row] valueForKey:@"name"];
        //status = [[[self.timelineData objectAtIndex:indexPath.row] valueForKey:@"status"]valueForKey:@"screen_name"];
        
        status = [[self.timelineData objectAtIndex:indexPath.row] valueForKey:@"name"];
        
        status2 = [[self.timelineData objectAtIndex:indexPath.row] valueForKey:@"full_name"];
        
        status3 = [[self.timelineData objectAtIndex:indexPath.row] valueForKey:@"member_count"];
        
        cell.textLabel.font = [UIFont systemFontOfSize:21];
        cell.textLabel.textColor = [UIColor  grayColor];
        
    }
    
    cell.textLabel.text =  status  ;
    cell.textLabel.text =  status2  ;
    //cell.textLabel.text =  status3  ;

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
