//
//  BaseViewController.h
//  Febo
//
//  Created by Andrew on 14-10-20.
//  Copyright (c) 2014年 ckdai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppDelegate;

typedef void (^RightButtonBlock)(NSInteger tag);

typedef NS_ENUM(NSInteger, PushType) {
    Present = 1,
    Push = 2,
};

@interface BaseViewController : UIViewController
{
    RightButtonBlock rightButtonBlock;
}

- (AppDelegate *)appDelegate;
- (NSString *)accessToken;
- (void)createBackButtonWithTitle:(NSString *)title andType:(PushType )type;
- (void)createBackButtonWithImageName:(NSString *)imageName andType:(PushType )type;
- (void)createRightButtonWithTitle:(NSString *)title tag:(NSInteger)tag;
- (void)createRightButtonWithImageName:(NSString *)imageName tag:(NSInteger)tag;
-(void)setRightButtonAction:(RightButtonBlock)ablock;

@end
