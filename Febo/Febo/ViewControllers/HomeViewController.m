//
//  HomeViewController.m
//  Febo
//
//  Created by Andrew on 14-10-20.
//  Copyright (c) 2014年 ckdai. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

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
    weiboList = [[NSMutableArray alloc] init];
    //发送微博HTTP请求
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[self accessToken] forKey:@"access_token"];
    [WBHttpRequest requestWithAccessToken:[self accessToken] url:@"https://api.weibo.com/2/statuses/friends_timeline.json" httpMethod:@"GET" params:params delegate:self withTag:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.navigationItem.title = @"首页";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return weiboList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"HomeTableViewCellIdentifier";
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeTableViewCell" owner:self options:nil] lastObject];
    }
    return cell;
}

#pragma mark 微博Http请求的响应
-(void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    NSLog(@"%@", result);
    NSDictionary *resultDic = [[[SBJsonParser alloc] init] objectWithString:result];
    [weiboList addObjectsFromArray:[resultDic objectForKey:@"statuses"]];
    [homeTable reloadData];
}

-(void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error
{
    
}

@end
