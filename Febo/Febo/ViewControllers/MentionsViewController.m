//
//  MentionsViewController.m
//  Febo
//
//  Created by YY on 14/10/27.
//  Copyright (c) 2014年 ckdai. All rights reserved.
//

#import "MentionsViewController.h"
#import "HomeTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "UserInfoViewController.h"

@interface MentionsViewController ()

@end

@implementation MentionsViewController
{
    NSString *pageNumber;
}

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
    self.navigationItem.title = @"@我的";
    [self createBackButtonWithImageName:@"navigationbar_back" andType:Push];
    refreshHeaderView = [[MJRefreshHeaderView alloc] init];
    refreshFooterView = [[MJRefreshFooterView alloc] init];
    refreshFooterView.scrollView = weiboTable;
    refreshHeaderView.scrollView = weiboTable;
    refreshHeaderView.delegate = self;
    refreshFooterView.delegate = self;
    weiboList = [[NSMutableArray alloc] init];
    if ([Common CheckLogin]) {
        [self loadMentionsData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadMentionsData
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[self accessToken] forKey:@"access_token"];
    [params setObject:@"1" forKey:@"page"];
    [WBHttpRequest requestWithAccessToken:[self accessToken] url:Mentions httpMethod:@"GET" params:params delegate:self withTag:@"refresh"];
}

- (void)loadMoreMentions
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[self accessToken] forKey:@"access_token"];
    int page = [pageNumber integerValue];
    [params setObject:[NSString stringWithFormat:@"%i", ++page] forKey:@"page"];
    [WBHttpRequest requestWithAccessToken:[self accessToken] url:Mentions httpMethod:@"GET" params:params delegate:self withTag:@"loadmore"];
}

#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *weiboInfoDic = [weiboList objectAtIndex:indexPath.row];
    NSDictionary *repostWeiboInfo = [weiboInfoDic objectForKey:@"retweeted_status"];
    if (!repostWeiboInfo) {
        return [Common heightForString:[weiboInfoDic objectForKey:@"text"] withFontSize:14.0f labelWidth:ScreenWidth - 40] + 66;
    }
    else {
        return [Common heightForString:[weiboInfoDic objectForKey:@"text"] withFontSize:14.0f labelWidth:ScreenWidth - 40] + 66 + 8 + [Common heightForString:[NSString stringWithFormat:@"@%@:%@", [[repostWeiboInfo objectForKey:@"user"] objectForKey:@"name"], [repostWeiboInfo objectForKey:@"text"]]withFontSize:14 labelWidth:ScreenWidth - 40];
    }
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
    NSDictionary *weiboInfoDic = [weiboList objectAtIndex:indexPath.row];
    cell.nameLabel.text = [[weiboInfoDic objectForKey:@"user"] objectForKey:@"name"];
    cell.contentLabel.text = [weiboInfoDic objectForKey:@"text"];
    cell.contentLabel.frame = CGRectMake(20, 55, ScreenWidth - 40, [Common heightForString:cell.contentLabel.text withFontSize:14 labelWidth:ScreenWidth - 40]);
    [cell.avatarImage setImageWithURL:[NSURL URLWithString:[[weiboInfoDic objectForKey:@"user"] objectForKey:@"avatar_hd"]] placeholderImage:[UIImage imageNamed:@"tabbar_usercenter"]];
    cell.dateAndFromLabel.text = [NSString stringWithFormat:@"来自%@", [Common filterHTML:[weiboInfoDic objectForKey:@"source"]]];
    
    cell.avatarImage.userInteractionEnabled = YES;
    cell.avatarImage.tag = indexPath.row;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userHeaderImagePressed:)];
    [cell.avatarImage addGestureRecognizer:tapGesture];
    
    NSDictionary *repostWeiboInfo = [weiboInfoDic objectForKey:@"retweeted_status"];
    
    if (!repostWeiboInfo) { //没有转发内容
        cell.repostWeiboLabel.hidden = YES;
    }
    else {  //有转发内容
        cell.repostWeiboLabel.hidden = NO;
        cell.repostWeiboLabel.text = [NSString stringWithFormat:@"@%@:%@", [[repostWeiboInfo objectForKey:@"user"] objectForKey:@"name"], [repostWeiboInfo objectForKey:@"text"]];
        cell.repostWeiboLabel.frame = CGRectMake(20, cell.contentLabel.frame.origin.y + cell.contentLabel.frame.size.height + 8, ScreenWidth - 40, [Common heightForString:cell.repostWeiboLabel.text withFontSize:14 labelWidth:ScreenWidth - 40]);
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark 点击微博用户头像事件
- (void)userHeaderImagePressed:(UITapGestureRecognizer *)recognizer
{
    //    recognizer.view.tag
    NSDictionary *weiboInfo = [weiboList objectAtIndex:recognizer.view.tag];
    NSString *userIdStr = [[weiboInfo objectForKey:@"user"] objectForKey:@"idstr"];
    NSLog(@"微博用户ID:%@",userIdStr);
    UserInfoViewController *userInfoVC = [[UserInfoViewController alloc] init];
    userInfoVC.uid = userIdStr;
    [self.navigationController pushViewController:userInfoVC animated:YES];
    
}

#pragma mark 微博Http请求的响应
-(void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    //响应成功
    if ([request.tag isEqualToString:@"refresh"]) {
        [weiboList removeAllObjects];
        NSDictionary *resultDic = [[[SBJsonParser alloc] init] objectWithString:result];
        [weiboList addObjectsFromArray:[resultDic objectForKey:@"statuses"]];
        [weiboTable reloadData];
        [refreshHeaderView endRefreshing];
    }
    else if ([request.tag isEqualToString:@"loadmore"]){
        NSDictionary *resultDic = [[[SBJsonParser alloc] init] objectWithString:result];
        [weiboList addObjectsFromArray:[resultDic objectForKey:@"statuses"]];
        [weiboTable reloadData];
        [refreshFooterView endRefreshing];
    }
}

-(void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error
{
    //响应失败
    NSLog(@"响应失败，error：%@", [error userInfo]);
    [refreshHeaderView endRefreshing];
}

#pragma mark 下拉刷新的Delegate
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView == refreshHeaderView) {
        [self loadMentionsData];
    }
    else {
        [self loadMoreMentions];
    }
}

- (void)dealloc
{
    [refreshFooterView free];
    [refreshHeaderView free];
}

@end
