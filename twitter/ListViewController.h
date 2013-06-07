//
//  ListViewController.h
//  TwitterCliant03
//
//  Created by PANCAKE on 13/06/03.
//  Copyright (c) 2013年 PANCAKE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface ListViewController : UITableViewController


@property (nonatomic, strong) ACAccountStore *accountStore;
@property (nonatomic, strong) NSArray *timelineData;


@end
