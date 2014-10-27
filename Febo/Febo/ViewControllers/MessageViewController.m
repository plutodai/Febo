//
//  MessageViewController.m
//  Febo
//
//  Created by Andrew on 14-10-20.
//  Copyright (c) 2014年 ckdai. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"
#import "MentionsViewController.h"

@interface MessageViewController ()
{
    NSMutableArray *cellTitleList;
    NSMutableArray *cellImageNameList;
}

@end

@implementation MessageViewController

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
    cellTitleList = [[NSMutableArray alloc] initWithObjects:@"@我的", @"评论", @"赞", nil];
    cellImageNameList = [[NSMutableArray alloc] initWithObjects:@"messagescenter_at", @"messagescenter_comments", @"messagescenter_good", nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.navigationItem.title = @"消息";
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 56, 21);
    [rightButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [rightButton setTitle:@"发起聊天" forState:UIControlStateNormal];
    [[rightButton titleLabel] setFont:[UIFont systemFontOfSize:14]];
    [rightButton addTarget:self action:@selector(createDialogButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.tabBarController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        MentionsViewController *mentionsVC = [[MentionsViewController alloc] init];
        [self.navigationController pushViewController:mentionsVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MessageTableViewCellIdentifier";
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MessageTableViewCell" owner:self options:nil] lastObject];
    }
    cell.cellTitleLabel.text = [cellTitleList objectAtIndex:indexPath.row];
    cell.cellImageView.image = [UIImage imageNamed:[cellImageNameList objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark ButtonClickedAction
- (void)createDialogButtonClicked:(UIButton *)sender
{
    
}

@end
