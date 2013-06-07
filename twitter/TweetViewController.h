//
//  TweetViewController.h
//  TwitterCliant03
//
//  Created by PANCAKE on 13/05/25.
//  Copyright (c) 2013年 PANCAKE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import <QuartzCore/QuartzCore.h>

//@interface MyAppViewController <UITextViewDelegate>


@interface TweetViewController : UIViewController <UITextViewDelegate>
//@interface TweetViewController  <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *count;
@property (strong, nonatomic) IBOutlet UITextView *tweetTextView;
@property (nonatomic, strong) ACAccountStore *accountStore;
@property(nonatomic, strong) UITapGestureRecognizer *singleTap;

- (IBAction)tweetAction:(id)sender;
- (IBAction)cameraAction:(id)sender;
- (IBAction)hashAction:(id)sender;
- (IBAction)rootAction:(id)sender;

@end
