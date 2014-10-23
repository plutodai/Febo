//
//  HomeViewController.h
//  Febo
//
//  Created by Andrew on 14-10-20.
//  Copyright (c) 2014年 ckdai. All rights reserved.
//

#import "BaseViewController.h"
#import "MJRefresh.h"

@interface HomeViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate, WBHttpRequestDelegate, MJRefreshBaseViewDelegate>
{
    IBOutlet UITableView *homeTable;
    IBOutlet MJRefreshHeaderView *refreshHeaderView;
    NSMutableArray *weiboList;
}

@end
