//
//  TweetViewController.m
//  TwitterCliant03
//
//  Created by PANCAKE on 13/05/25.
//  Copyright (c) 2013年 PANCAKE. All rights reserved.
//

#import "TweetViewController.h"

@interface TweetViewController ()

@end

@implementation TweetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}






- (void)viewDidLoad
{
  //  [self.navigationController setNavigationBarHidden:NO animated:YES];
  //  [self.navigationController setToolbarHidden:YES animated:NO];
   
    


    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.accountStore = [[ACAccountStore alloc] init];
            
    
    _tweetTextView.layer.cornerRadius = 8;
    _tweetTextView.clipsToBounds = true;
    //角丸コード

    
    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSingleTap:)];
    self.singleTap.delegate = self;
    self.singleTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:self.singleTap];
    //画面タップでキーボード引っ込める
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (IBAction)tweetAction:(id)sender {
    ACAccountType *twitterType =
    [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    SLRequestHandler requestHandler =
    ^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        if (responseData) {
            NSInteger statusCode = urlResponse.statusCode;
            if (statusCode >= 200 && statusCode < 300) {
                NSDictionary *postResponseData =
                [NSJSONSerialization JSONObjectWithData:responseData
                                                options:NSJSONReadingMutableContainers
                                                  error:NULL];
                NSLog(@"[SUCCESS!] Created Tweet with ID: %@", postResponseData[@"id_str"]);
            }
            else {
                NSLog(@"[ERROR] Server responded: status code %d %@", statusCode,
                      [NSHTTPURLResponse localizedStringForStatusCode:statusCode]);
            }
        }
        else {
            NSLog(@"[ERROR] An error occurred while posting: %@", [error localizedDescription]);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:^{
                NSLog(@"Tweet Sheet has been dismissed.");
            }];
        });
    };
    
    NSString *tweetString = self.tweetTextView.text;
    
    ACAccountStoreRequestAccessCompletionHandler accountStoreHandler =
    ^(BOOL granted, NSError *error) {
        if (granted) {
            
            NSArray *accounts = [self.accountStore accountsWithAccountType:twitterType];
            NSURL *url = [NSURL URLWithString:@"https://api.twitter.com"
                          @"/1.1/statuses/update.json"];
            NSDictionary *params = @{@"status" : tweetString};
            
            SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                    requestMethod:SLRequestMethodPOST
                                                              URL:url
                                                       parameters:params];
            [request setAccount:[accounts lastObject]];
            [request performRequestWithHandler:requestHandler];
        }
        else {
            NSLog(@"[ERROR] An error occurred while asking for user authorization: %@",
                  [error localizedDescription]);
        }
    };
    
    [self.accountStore requestAccessToAccountsWithType:twitterType
                                               options:NULL
                                            completion:accountStoreHandler];
}











- (IBAction)cameraAction:(id)sender {
    _tweetTextView.text = @"ダミー";
}

- (IBAction)hashAction:(id)sender {
    _tweetTextView.text = @"#";
}

- (IBAction)rootAction:(id)sender {
    _tweetTextView.text = @"ダミー";

}
//ボタン処理



- (BOOL)textFieldShouldReturn:(UITextField *)tweetTextView {
    [tweetTextView resignFirstResponder];
    return YES;
}
//画面タップでキーボード引っ込める1?



-(void)onSingleTap:(UITapGestureRecognizer *)recognizer {
    [self.tweetTextView resignFirstResponder];
}
//画面タップでキーボード引っ込める2



-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (gestureRecognizer == self.singleTap) {
        // キーボード表示中のみ有効
        if (self.tweetTextView.isFirstResponder) {
            return YES;
        } else {
            return NO;
        }
    }
    return YES;
}
//画面タップでキーボード引っ込める3



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setValue:_tweetTextView.text forKey:@"voice"];
    _count.text = [NSString stringWithFormat:@"%d", (140 - (textView.text.length - range.length)) ];
    return YES;
}
//文字数カウンタ


@end
