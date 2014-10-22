//
//  HomeViewController.h
//  Febo
//
//  Created by Andrew on 14-10-20.
//  Copyright (c) 2014年 ckdai. All rights reserved.
//

#import "BaseViewController.h"

@interface HomeViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate, WBHttpRequestDelegate>
{
    IBOutlet UITableView *homeTable;
    NSMutableArray *weiboList;
}

@end
