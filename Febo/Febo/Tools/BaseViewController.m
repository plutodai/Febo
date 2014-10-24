//
//  BaseViewController.m
//  Febo
//
//  Created by Andrew on 14-10-20.
//  Copyright (c) 2014年 ckdai. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (AppDelegate *)appDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (NSString *)accessToken
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:WeiboAuthInfo] objectForKey:@"accessToken"];
}

- (void)createBackButtonWithImageName:(NSString *)imageName andType:(PushType)type
{
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(0, 0, 21, 21);
    [back setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    back.tag = type;
    [back addTarget:self action:@selector(backToFormViewController:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:back];
}

- (void)createBackButtonWithTitle:(NSString *)title andType:(PushType)type
{
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(0, 0, 56, 21);
    [back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [back setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [back setTitle:title forState:UIControlStateNormal];
    [[back titleLabel] setFont:[UIFont systemFontOfSize:14]];
    back.tag = type;
    [back addTarget:self action:@selector(backToFormViewController:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:back];
}

- (void)createRightButtonWithTitle:(NSString *)title tag:(NSInteger)tag
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 56, 21);
    rightButton.tag = tag;
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [rightButton setTitle:title forState:UIControlStateNormal];
    [[rightButton titleLabel] setFont:[UIFont systemFontOfSize:14]];
    [rightButton addTarget:self action:@selector(modelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
}

- (void)createRightButtonWithImageName:(NSString *)imageName tag:(NSInteger)tag
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 21, 21);
    rightButton.tag = tag;
    [rightButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(modelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
}

- (void)backToFormViewController:(UIButton *)sender
{
    if (sender.tag == Present) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    if (sender.tag == Push) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)modelButtonAction:(UIButton *)sender
{
    rightButtonBlock (sender.tag);
}

-(void)setRightButtonAction:(RightButtonBlock)ablock
{
    rightButtonBlock = [ablock copy];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
