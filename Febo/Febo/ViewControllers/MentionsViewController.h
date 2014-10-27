//
//  MentionsViewController.h
//  Febo
//
//  Created by YY on 14/10/27.
//  Copyright (c) 2014年 ckdai. All rights reserved.
//

#import "BaseViewController.h"
#import "MJRefresh.h"

@interface MentionsViewController : BaseViewController<WBHttpRequestDelegate, UITableViewDataSource, UITableViewDelegate, MJRefreshBaseViewDelegate>
{
    IBOutlet UITableView *weiboTable;
    NSMutableArray *weiboList;
    MJRefreshFooterView *refreshFooterView;
    MJRefreshHeaderView *refreshHeaderView;
}

@end
