//
//  WriteWeiboViewController.m
//  Febo
//
//  Created by YY on 14/10/24.
//  Copyright (c) 2014年 ckdai. All rights reserved.
//

#import "WriteWeiboViewController.h"

@interface WriteWeiboViewController ()

@end

@implementation WriteWeiboViewController

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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"发微博";
    [self createBackButtonWithTitle:@"取消" andType:Present];
    [self createRightButtonWithTitle:@"发送" tag:1];
    __block WriteWeiboViewController *writeWBVC = self;
    [self setRightButtonAction:^(NSInteger tag){
        if (tag == 1) {
            [writeWBVC sendWeibo];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sendWeibo
{
    if (contentTextView.text.length == 0) {
        return;
    }
    if ([Common CheckLogin]) {
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:[self accessToken] forKey:@"access_token"];
        [params setObject:contentTextView.text forKey:@"status"];
        [WBHttpRequest requestWithAccessToken:[self accessToken] url:PostNewWeibo httpMethod:@"POST" params:params delegate:self withTag:@"postweibo"];
    }
}

#pragma mark 微博Delegate
- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    NSLog(@"result：%@", result);
    NSDictionary *resultDic = [[[SBJsonParser alloc] init] objectWithString:result];
    if ([resultDic objectForKey:@"error_code"]) {
        
    }
    else {
        [Common showBottomToast:@"发布成功"];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
