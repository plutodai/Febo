//
//  HotViewController.m
//  Febo
//
//  Created by Andrew on 14-10-20.
//  Copyright (c) 2014年 ckdai. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

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
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.navigationItem.title = @"发现";
    self.tabBarController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    if ([Common CheckLogin]) {
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:WeiboAppKey forKey:@"source"];
        [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/statuses/public_timeline.json" httpMethod:@"GET" params:params delegate:self withTag:@"public"];
    }
    else {
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:WeiboAppKey forKey:@"source"];
//        [WBHttpRequest requestWithAccessToken:[self accessToken] url:@"https://api.weibo.com/2/statuses/public_timeline.json" httpMethod:@"GET" params:params delegate:self withTag:@"public"];
        [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/statuses/public_timeline.json" httpMethod:@"GET" params:params delegate:self withTag:@"public"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 微博回调
- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    NSLog(@"%@", result);
}

@end
