//
//  BaseViewController.h
//  Febo
//
//  Created by Andrew on 14-10-20.
//  Copyright (c) 2014年 ckdai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppDelegate;
@interface BaseViewController : UIViewController

- (AppDelegate *)appDelegate;
- (NSString *)accessToken;

@end
