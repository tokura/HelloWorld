//
//  DetailViewController.h
//  TwitterCliant03
//
//  Created by PANCAKE on 13/05/07.
//  Copyright (c) 2013年 PANCAKE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import <QuartzCore/QuartzCore.h>




@interface DetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UITextView *nameView;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *idStr;



- (IBAction)retweetAction:(id)sender;




@end
