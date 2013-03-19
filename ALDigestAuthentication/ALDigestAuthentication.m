//  Copyright (c) 2013年 Tomohiko Himura. All rights reserved.

#import "ALDigestAuthentication.h"

typedef void (^AFURLConnectionOperationAuthenticationChallengeBlock)(NSURLConnection *connection, NSURLAuthenticationChallenge *challenge);

@interface ALDigestAuthentication ()
{
    AFURLConnectionOperationAuthenticationChallengeBlock _block;
    NSString* _username;
    NSString* _password;
}

@end

@implementation ALDigestAuthentication

- (id)initWithUsername:(NSString*)username andPassword:(NSString*)password
{
    self = [self init];
    if (self) {
        _block = nil;
        _username = username;
        _password = password;
    }
    return self;
}

- (AFHTTPRequestOperation*)httpRequestOperation:(NSURLRequest*)request
{
    AFHTTPRequestOperation* operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setAuthenticationChallengeBlock:[self authenticationChallenge]];
    return operation;
}

#pragma mark - private methods
// 認証が必要な時に呼び出されるブロックを作成して保持しておく。
- (void (^)(NSURLConnection *connection, NSURLAuthenticationChallenge *challenge))authenticationChallenge {
    if (!_block) {
        __block NSString* username = _username;
        __block NSString* password = _password;
        _block = ^(NSURLConnection *connection, NSURLAuthenticationChallenge *challenge) {
            // この if をしなかったら何回も挑戦してしまう。何度か試みたいなら適当に調整
            if ([challenge previousFailureCount] == 0) {
                NSURLCredential* credential =
                [NSURLCredential credentialWithUser:username
                                           password:password
                                        persistence:NSURLCredentialPersistenceNone];
                [[challenge sender] useCredential:credential
                       forAuthenticationChallenge:challenge];
            } else {
                [[challenge sender] cancelAuthenticationChallenge:challenge];
            }
        };
    }
    return _block;
}

@end
