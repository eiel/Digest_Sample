//
//  ALViewController.m
//  Digest_Sample
//
//  Created by えいる on 2013/03/19.
//  Copyright (c) 2013年 Tomohiko Himura. All rights reserved.
//

#import "ALViewController.h"
#import "AFHTTPRequestOperation.h"
#import "ALDigestAuthentication.h"

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

#pragma mark - private methoods
- (void)_request
{
    // いろんな場所で使うのであればシングルトンつくって保持させておくとよいかもね
    ALDigestAuthentication* auth =
        [[ALDigestAuthentication alloc] initWithUsername:@"username"
                                             andPassword:@"password"];
    
    // アクセス先設定
    NSURL* url = [NSURL URLWithString:@"http://localhost:9292"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 認証設定済みの AFHTTPRequestOperation を作成する
    _operation = [auth httpRequestOperation:request];

    __block ALViewController *that = self;
    [_operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //成功時
        that.responseLabel.text = operation.responseString;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 失敗時
        that.responseLabel.text = @"error";
    }];
    [_operation start];
}
@end
