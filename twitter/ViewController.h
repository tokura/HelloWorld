//
//  ViewController.h
//  TwitterCliant03
//
//  Created by PANCAKE on 13/04/30.
//  Copyright (c) 2013年 PANCAKE. All rights reserved.
//





#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "TimeLineTableViewController.h"

@interface ViewController : UIViewController <UIActionSheetDelegate>


@property (strong, nonatomic) IBOutlet UILabel *accountDisplayLabel;
@property (nonatomic, strong) ACAccountStore *accountStore;
@property (nonatomic, strong) NSArray *twitterAccounts;
@property (nonatomic, copy) NSString *identifier;

- (IBAction)setAccountAction:(id)sender;

@end
