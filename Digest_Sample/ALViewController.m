//
//  ALViewController.m
//  Digest_Sample
//
//  Created by えいる on 2013/03/19.
//  Copyright (c) 2013年 Tomohiko Himura. All rights reserved.
//

#import "ALViewController.h"
#import "AFHTTPRequestOperation.h"

@interface ALViewController ()
{
    AFHTTPRequestOperation* _operation;
}
@end

@implementation ALViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapGetButton:(id)sender {
    [self _request];
}

- (void)_request
{
    // アクセス先設定
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:9292"]];
    
    _operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    // 認証設定
    [_operation setAuthenticationChallengeBlock:
     ^(NSURLConnection *connection, NSURLAuthenticationChallenge *challenge) {
         // この if をしなかったら何回も挑戦してしまう。何度か試みたいなら適当に調整
         if ([challenge previousFailureCount] == 0) {
             NSURLCredential* credential =
             [NSURLCredential credentialWithUser:@"username"
                                        password:@"password"
                                     persistence:NSURLCredentialPersistenceNone];
             [[challenge sender] useCredential:credential
                    forAuthenticationChallenge:challenge];
         } else {
             [[challenge sender] cancelAuthenticationChallenge:challenge];
         }
     }];
    
    // リクエストが帰ってきた時の処理の作成
    __block ALViewController *that = self;
    [_operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //成功時
        that.responseLabel.text = [NSString stringWithString:operation.responseString];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 失敗時
        that.responseLabel.text = @"error";
    }];
    [_operation start];
}
@end
