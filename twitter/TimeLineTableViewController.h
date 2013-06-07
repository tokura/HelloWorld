//
//  TimeLineTableViewController.h
//  TwitterCliant03
//
//  Created by PANCAKE on 13/04/30.
//  Copyright (c) 2013年 PANCAKE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "DetailViewController.h"
#import "TimeLineCell.h"
#import <QuartzCore/QuartzCore.h>



@interface TimeLineTableViewController : UITableViewController

- (IBAction)reloadTimeline:(id)sender;





@property (nonatomic, strong) NSArray *timeLineData;
@property (nonatomic, copy) NSString *httpErrorMessage;
@property (nonatomic, copy) NSString *identifier;
@property dispatch_queue_t mainQueue;
@property dispatch_queue_t imageQueue;

@property (nonatomic, strong) ACAccountStore *accountStore;



@end




