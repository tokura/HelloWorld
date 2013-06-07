//
//  ViewController.m
//  TwitterCliant03
//
//  Created by PANCAKE on 13/04/30.
//  Copyright (c) 2013年 PANCAKE. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.navigationController.toolbarHidden = YES;
    
    //ナビゲーションバー、ツールバー隠す
    
     self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    //[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackTranslucent;
    self.wantsFullScreenLayout = YES;    // ステータスバーの背景コンテンツ表示
    //self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.toolbar.barStyle = UIBarStyleBlack;
      self.navigationController.toolbar.backgroundColor = [UIColor clearColor];

    self.navigationController.toolbar.translucent = YES;
    
    //navigationbar.toolbar半透明にする
    
   
}






- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    //self.navigationController.navigationBarHidden = YES;
    
    
	// Do any additional setup after loading the view, typically from a nib.
    self.accountStore = [[ACAccountStore alloc] init];
    ACAccountType *twitterType =
    [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [self.accountStore requestAccessToAccountsWithType:twitterType
                                               options:NULL
                                            completion:^(BOOL granted, NSError *error) {
                                                
                                                if (granted) {
                                                    self.twitterAccounts = [self.accountStore accountsWithAccountType:twitterType];
                                                    if (self.twitterAccounts > 0) {
                                                        ACAccount *account = [self.twitterAccounts lastObject];
                                                        self.identifier = account.identifier;
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            self.accountDisplayLabel.text = account.username;
                                                            //                     self.accountImageLabel.image = account.username;
                                                        });
                                                    }
                                                    else {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            self.accountDisplayLabel.text = @"アカウントなし";
                                                        });
                                                    }
                                                }
                                                else {
                                                    NSLog(@"Account Error: %@", [error localizedDescription]);
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        self.accountDisplayLabel.text = @"アカウント認証エラー";
                                                    });
                                                }
                                            }];
}








- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}










- (IBAction)setAccountAction:(id)sender { // アクションシート表示の定義
    
    UIActionSheet *sheet = [[UIActionSheet alloc] init];
    sheet.delegate = self;
    
    sheet.title = @"選択してください。";
    for (ACAccount *account in self.twitterAccounts) {
        [sheet addButtonWithTitle:account.username];
        //    [sheet addSubview:account.accountType.userImage];
        
        
    }
    [sheet addButtonWithTitle:@"キャンセル"];
    sheet.cancelButtonIndex = self.twitterAccounts.count;
    sheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [sheet showInView:self.view];
}







- (void)actionSheet:(UIActionSheet *)actionSheet  clickedButtonAtIndex:(NSInteger)buttonIndex {
    // アクションシート選択時の処理
    if (self.twitterAccounts.count > 0) {
        if (buttonIndex != self.twitterAccounts.count) {
            ACAccount *account = [self.twitterAccounts objectAtIndex:buttonIndex];
            self.identifier = account.identifier;
            self.accountDisplayLabel.text = account.username;
            //     self.accountImageLabel.image= account.username;
            NSLog(@"Account set! %@", account.username);
        }
        else {
            NSLog(@"cancel!");
        }
    }
}









- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TimeLineTableViewController *timeLineTableViewController = [segue destinationViewController];
    timeLineTableViewController.identifier = self.identifier;
}









@end
