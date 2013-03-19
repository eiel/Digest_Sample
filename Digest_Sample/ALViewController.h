//
//  ALViewController.h
//  Digest_Sample
//
//  Created by えいる on 2013/03/19.
//  Copyright (c) 2013年 Tomohiko Himura. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *responseLabel;
- (IBAction)getButton:(id)sender;
@end
