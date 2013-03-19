# これは何

 Digest認証をするのに少しだけ楽する クラスを提供とそのサンプルです。

現在は [AFNetwoking](https://github.com/AFNetworking/AFNetworking) というライブラリのみに対応しています。

以下の感じに使います。

```Objective-C
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
        that.responseLabel.text = [NSString stringWithString:operation.responseString];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 失敗時
        that.responseLabel.text = @"error";
    }];
    [_operation start];
```

ALDigestAuthentication クラスのインスタンスが 認証時の処理を追加済みの AFHTTPRequestOperation クラスのインスタンスを生成できます。
あとは AFHTTPRequestOperation を普段通り使用してください。

# 試す方法

```
$ git clone --recursive git@github.com:eiel/Digest_Sample.git
```

Server ディレクトリに動作確認用のサーバを起動する Ruby スクリプトがありますので、起動しておきます。

```
$ cd Server
$ bundle install
$ rackup
```

とすると、ウェブサーバが立ち上がります。
URLは http://localhost:9292/ です。

初期パスワードは password です。
ユーザ名は特に関係ありません。
認証に成功すると `hoge` と表示されます。

あとはプロジェクトを開いて実行してください。

# 使い方

ALDigestAuthentication ディレクトリをプロジェクトに追加してください。
AFNetworking も追加していない場合は追加してください。