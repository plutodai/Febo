//
//  WriteWeiboViewController.h
//  Febo
//
//  Created by YY on 14/10/24.
//  Copyright (c) 2014年 ckdai. All rights reserved.
//

#import "BaseViewController.h"

@interface WriteWeiboViewController : BaseViewController<WBHttpRequestDelegate>
{
    IBOutlet UITextView *contentTextView;
}

@end
