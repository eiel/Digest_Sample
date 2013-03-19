//  Copyright (c) 2013年 Tomohiko Himura. All rights reserved.

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"

@interface ALDigestAuthentication : NSObject

- (id)initWithUsername:(NSString*)username andPassword:(NSString*)password;

// 認証設定済みの AFHTTPRequestOperation を生成するファクトリメソッド
- (AFHTTPRequestOperation*)httpRequestOperation:(NSURLRequest*)request;

@end
